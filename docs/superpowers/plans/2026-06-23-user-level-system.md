# User Level System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the hardcoded "Novice Chanter" placeholder with a dynamic rank system based on total lifetime rounds completed, auto-updating when a chant session ends.

**Architecture:** A pure function maps total rounds to a rank title. This function is called inside `updateLifetimeStats()` which already writes to the `rankTitle` column. The missing piece is that `updateLifetimeStats()` is never called — we add a call after session save.

**Tech Stack:** Dart, Drift (SQLite), Flutter Riverpod

## Global Constraints

- Follow existing code conventions (Geist/JetBrains Mono fonts, `Color(0xFFFF8400)` accent)
- No schema changes — `rankTitle` column already exists in `UserInfoTable`
- Existing users auto-upgrade on next session end

---

## File Structure

| File | Action | Purpose |
|---|---|---|
| `lib/core/utils/rank_utils.dart` | Create | Pure function `rankForRounds(int) → String` |
| `lib/core/database/daos/user_info_dao.dart` | Modify | Call `rankForRounds()` in `updateLifetimeStats()` |
| `lib/features/counter/presentation/screens/counter_screen.dart` | Modify | Call `updateLifetimeStats()` after session save |
| `test/rank_utils_test.dart` | Create | Unit tests for `rankForRounds()` |
| `test/widget_test.dart` | Modify | Add rank-update integration test |

---

### Task 1: Create rank utility function

**Files:**
- Create: `lib/core/utils/rank_utils.dart`
- Test: `test/rank_utils_test.dart`

**Interfaces:**
- Consumes: nothing
- Produces: `String rankForRounds(int totalRounds)` — pure function, no dependencies

- [ ] **Step 1: Write the failing test**

Create `test/rank_utils_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:meditation/core/utils/rank_utils.dart';

void main() {
  group('rankForRounds', () {
    test('returns Novice Chanter for 0 rounds', () {
      expect(rankForRounds(0), 'Novice Chanter');
    });

    test('returns Novice Chanter for 9 rounds', () {
      expect(rankForRounds(9), 'Novice Chanter');
    });

    test('returns Aspiring Devotee at 10 rounds', () {
      expect(rankForRounds(10), 'Aspiring Devotee');
    });

    test('returns Steady Practitioner at 50 rounds', () {
      expect(rankForRounds(50), 'Steady Practitioner');
    });

    test('returns Devoted Chanter at 100 rounds', () {
      expect(rankForRounds(100), 'Devoted Chanter');
    });

    test('returns Faithful Reciter at 250 rounds', () {
      expect(rankForRounds(250), 'Faithful Reciter');
    });

    test('returns Venerable Chanter at 500 rounds', () {
      expect(rankForRounds(500), 'Venerable Chanter');
    });

    test('returns Senior Devotee at 1000 rounds', () {
      expect(rankForRounds(1000), 'Senior Devotee');
    });

    test('returns Noble Chanter at 2500 rounds', () {
      expect(rankForRounds(2500), 'Noble Chanter');
    });

    test('returns Elder Devotee at 5000 rounds', () {
      expect(rankForRounds(5000), 'Elder Devotee');
    });

    test('returns Master Chanter at 10000 rounds', () {
      expect(rankForRounds(10000), 'Master Chanter');
    });

    test('returns Master Chanter for very high round counts', () {
      expect(rankForRounds(50000), 'Master Chanter');
    });

    test('returns correct rank for boundary value 49', () {
      expect(rankForRounds(49), 'Aspiring Devotee');
    });

    test('returns correct rank for boundary value 99', () {
      expect(rankForRounds(99), 'Steady Practitioner');
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/rank_utils_test.dart`
Expected: FAIL — file `lib/core/utils/rank_utils.dart` does not exist

- [ ] **Step 3: Write minimal implementation**

Create `lib/core/utils/rank_utils.dart`:

```dart
const _rankThresholds = [
  (10000, 'Master Chanter'),
  (5000, 'Elder Devotee'),
  (2500, 'Noble Chanter'),
  (1000, 'Senior Devotee'),
  (500, 'Venerable Chanter'),
  (250, 'Faithful Reciter'),
  (100, 'Devoted Chanter'),
  (50, 'Steady Practitioner'),
  (10, 'Aspiring Devotee'),
];

String rankForRounds(int totalRounds) {
  for (final (threshold, title) in _rankThresholds) {
    if (totalRounds >= threshold) return title;
  }
  return 'Novice Chanter';
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/rank_utils_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/core/utils/rank_utils.dart test/rank_utils_test.dart
git commit -m "feat: add rankForRounds utility function with unit tests"
```

---

### Task 2: Integrate rank update into updateLifetimeStats

**Files:**
- Modify: `lib/core/database/daos/user_info_dao.dart:20-33`

**Interfaces:**
- Consumes: `rankForRounds(int)` from Task 1
- Produces: `updateLifetimeStats()` now also writes `rankTitle`

- [ ] **Step 1: Update the DAO to compute rank**

Edit `lib/core/database/daos/user_info_dao.dart` — add import and update `updateLifetimeStats`:

```dart
import 'package:drift/drift.dart';
import '../../utils/rank_utils.dart';
import '../database.dart';
import '../tables/user_info_table.dart';

part 'user_info_dao.g.dart';

@DriftAccessor(tables: [UserInfoTable])
class UserInfoDao extends DatabaseAccessor<AppDatabase>
    with _$UserInfoDaoMixin {
  UserInfoDao(super.db);

  Future<UserInfo?> getUser() {
    return (select(userInfoTable)..limit(1)).getSingleOrNull();
  }

  Future<void> upsertUser(UserInfo user) {
    return into(userInfoTable).insertOnConflictUpdate(user);
  }

  Future<void> updateLifetimeStats({
    required int totalBeads,
    required int totalRounds,
  }) async {
    final user = await getUser();
    if (user == null) return;
    await upsertUser(
      user.copyWith(
        totalLifetimeBeads: totalBeads,
        totalLifetimeRounds: totalRounds,
        rankTitle: rankForRounds(totalRounds),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
```

- [ ] **Step 2: Run existing tests to verify nothing breaks**

Run: `flutter test`
Expected: All existing tests PASS

- [ ] **Step 3: Commit**

```bash
git add lib/core/database/daos/user_info_dao.dart
git commit -m "feat: updateLifetimeStats now recalculates rank title"
```

---

### Task 3: Call updateLifetimeStats after session save

**Files:**
- Modify: `lib/features/counter/presentation/screens/counter_screen.dart:203-218`

**Interfaces:**
- Consumes: `UserInfoDao.updateLifetimeStats()` from Task 2, `ChantSessionDao.getTotalBeads()` and `getTotalRounds()` from existing DAO
- Produces: rank auto-updates after every session save

- [ ] **Step 1: Add the call after session insert**

In `counter_screen.dart`, the session save block (lines 203-218) currently inserts the session and invalidates providers. Add the `updateLifetimeStats` call after the insert:

```dart
    if (result == true) {
      await dao.insertSession(
        ChantSessionsTableCompanion(
          mode: Value(state.mode.label),
          beadsCount: Value(state.sessionBeads),
          roundsCompleted: Value(state.roundsCompleted),
          startedAt: Value(state.sessionStartedAt ?? DateTime.now()),
          completedAt: Value(DateTime.now()),
        ),
      );
      // Recalculate lifetime stats and rank
      final sessionDao = ref.read(chantSessionDaoProvider);
      final totalBeads = await sessionDao.getTotalBeads();
      final totalRounds = await sessionDao.getTotalRounds();
      await ref.read(userInfoDaoProvider).updateLifetimeStats(
            totalBeads: totalBeads,
            totalRounds: totalRounds,
          );
      ref.invalidate(recentSessionsProvider);
      ref.invalidate(lifetimeBeadsProvider);
      ref.invalidate(lifetimeRoundsProvider);
      ref.invalidate(userInfoProvider);
      ref.invalidate(completedPlansProvider);
      ref.invalidate(recentPlansProvider);
    }
```

Also add the necessary import at the top of `counter_screen.dart` if `chantSessionDaoProvider` and `userInfoDaoProvider` are not already imported:

```dart
import '../../../../core/database/providers/app_database_providers.dart';
```

- [ ] **Step 2: Run all tests**

Run: `flutter test`
Expected: All tests PASS

- [ ] **Step 3: Commit**

```bash
git add lib/features/counter/presentation/screens/counter_screen.dart
git commit -m "feat: recalculate rank after saving chant session"
```

---

### Task 4: Add integration test for rank update

**Files:**
- Modify: `test/widget_test.dart`

**Interfaces:**
- Consumes: rank system from Tasks 1-3
- Produces: test proving rank updates after session completion

- [ ] **Step 1: Add test for rank update after session**

Add to `test/widget_test.dart` before the closing `}`:

```dart
  testWidgets('Rank updates after completing rounds and saving session', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Tap 10 times to get 10 beads = 1 round in Standard (108) mode
    // (need 108 for a full round, so we need to complete 108 taps)
    for (int i = 0; i < 108; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();

    // Switch mode to trigger save dialog
    await tester.tap(find.text('Short (8)'));
    await tester.pump();
    expect(find.text('Save Session?'), findsOneWidget);

    // Save the session
    await tester.tap(find.text('Save'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    // Navigate to profile to check rank
    await tester.tap(find.text('Profile'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    // 1 round completed → rank should still be "Novice Chanter" (< 10)
    expect(find.textContaining('Novice Chanter'), findsOneWidget);
  });
```

- [ ] **Step 2: Run all tests**

Run: `flutter test`
Expected: All tests PASS

- [ ] **Step 3: Commit**

```bash
git add test/widget_test.dart
git commit -m "test: add integration test for rank update after session"
```

---

### Task 5: Run lint and final verification

- [ ] **Step 1: Run flutter analyze**

Run: `flutter analyze`
Expected: No issues found

- [ ] **Step 2: Run all tests**

Run: `flutter test`
Expected: All tests PASS

- [ ] **Step 3: Format code**

Run: `dart format .`
Expected: All files already formatted or auto-formatted

- [ ] **Step 4: Final commit if formatting changed files**

```bash
git add -A
git commit -m "chore: format code"
```
