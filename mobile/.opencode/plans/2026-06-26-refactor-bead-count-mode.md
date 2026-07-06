# Refactor Bead Count Mode — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move the bead count mode selector from the counter screen to the settings page, add mode selection as an onboarding step, persist the selected mode to the database, and display the current mode as a pill badge on the counter screen.

**Architecture:** Add a `defaultMode` column to `UserInfoTable` (DB migration v3→v4). Create a reusable `ModeSelectionPage` used both in onboarding (page 2) and from settings. The counter provider loads the persisted mode on init. The `ModeSelector` widget is deleted. A pill badge below `TapToCount` shows the current mode.

**Tech Stack:** Flutter, Drift (SQLite), Riverpod, intl (l10n)

## Global Constraints

- Schema version must be bumped from 3→4 with proper migration
- All localization strings must be added to both `app_en.arb` and `app_my.arb`, then regenerated
- Follow existing code style: `Geist` fontFamily, `Color(0xFFFF8400)` accent, `Color(0xFF111111)` text, `Color(0xFF666666)` secondary
- `CounterMode` enum values: `standard`, `short`, `continuous` (already defined)
- Existing users with `name == 'Meditator' && totalLifetimeBeads == 0` are treated as new users in `app.dart`

---

## File Structure

| File | Action | Purpose |
|------|--------|---------|
| `lib/core/database/tables/user_info_table.dart` | Modify | Add `defaultMode` column |
| `lib/core/database/database.dart` | Modify | Bump schema to v4, add migration, update seed |
| `lib/core/database/database.g.dart` | Regenerate | Run `build_runner` |
| `lib/core/database/daos/user_info_dao.dart` | Modify | Add `updateDefaultMode()` method |
| `lib/core/database/daos/user_info_dao.g.dart` | Regenerate | Run `build_runner` |
| `lib/features/counter/providers/counter_provider.dart` | Modify | Add `loadMode()` to notifier |
| `lib/features/counter/presentation/screens/counter_screen.dart` | Modify | Remove `ModeSelector`, add pill badge |
| `lib/features/counter/presentation/widgets/mode_selector.dart` | Delete | No longer needed |
| `lib/features/counter/presentation/widgets/tap_to_count.dart` | Modify | Add mode pill badge below circle |
| `lib/features/onboarding/presentation/screens/onboarding_screen.dart` | Modify | Split into page 1 (name) + page 2 (mode) |
| `lib/features/settings/presentation/screens/settings_screen.dart` | Modify | Add mode row, navigate to mode selection |
| `lib/l10n/app_en.arb` | Modify | Add new strings |
| `lib/l10n/app_my.arb` | Modify | Add new strings |
| `lib/l10n/app_localizations.dart` | Regenerate | Run `flutter gen-l10n` |
| `lib/l10n/app_localizations_en.dart` | Regenerate | Run `flutter gen-l10n` |
| `lib/l10n/app_localizations_my.dart` | Regenerate | Run `flutter gen-l10n` |
| `lib/app.dart` | Modify | Update new-user detection logic |

---

### Task 1: Add `defaultMode` column to UserInfoTable and bump schema

**Files:**
- Modify: `lib/core/database/tables/user_info_table.dart`
- Modify: `lib/core/database/database.dart`
- Regenerate: `lib/core/database/database.g.dart`, `lib/core/database/daos/user_info_dao.g.dart`

**Interfaces:**
- Consumes: existing `UserInfoTable`, `UserInfo` data class
- Produces: `UserInfo.defaultMode` field (String, nullable with default `'standard'`)

- [ ] **Step 1: Add column to UserInfoTable**

```dart
// lib/core/database/tables/user_info_table.dart
import 'package:drift/drift.dart';

@DataClassName('UserInfo')
class UserInfoTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get rankTitle => text()();
  TextColumn get defaultMode => text().withDefault(const Constant('standard'))();
  IntColumn get streakDays => integer()();
  IntColumn get totalLifetimeBeads => integer()();
  IntColumn get totalLifetimeRounds => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
```

- [ ] **Step 2: Bump schema version and add migration**

```dart
// In lib/core/database/database.dart, change:
@override
int get schemaVersion => 4;

// In onUpgrade, add after the from < 3 block:
if (from < 4) {
  await m.addColumn(userInfoTable, userInfoTable.defaultMode);
}
```

- [ ] **Step 3: Update seed data to include defaultMode**

In `onCreate`, the existing `UserInfo` insert already works since the column has a default. Update the constructor call explicitly for clarity:

```dart
await into(userInfoTable).insert(
  UserInfo(
    id: 1,
    name: 'Meditator',
    rankTitle: 'Novice Chanter',
    defaultMode: 'standard',
    streakDays: 0,
    totalLifetimeBeads: 0,
    totalLifetimeRounds: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
);
```

- [ ] **Step 4: Run codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: Generates `database.g.dart` and `user_info_dao.g.dart` with the new column

- [ ] **Step 5: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 6: Commit**

```bash
git add lib/core/database/tables/user_info_table.dart lib/core/database/database.dart lib/core/database/database.g.dart lib/core/database/daos/user_info_dao.g.dart
git commit -m "feat(db): add defaultMode column to UserInfoTable with migration v4"
```

---

### Task 2: Add `updateDefaultMode` to UserInfoDao

**Files:**
- Modify: `lib/core/database/daos/user_info_dao.dart`
- Regenerate: `lib/core/database/daos/user_info_dao.g.dart`

**Interfaces:**
- Consumes: `UserInfo` from `getUser()`
- Produces: `updateDefaultMode(String mode)` method

- [ ] **Step 1: Add updateDefaultMode method**

```dart
// lib/core/database/daos/user_info_dao.dart — add after updateLifetimeStats:
Future<void> updateDefaultMode(String mode) async {
  final user = await getUser();
  if (user == null) return;
  await upsertUser(
    user.copyWith(
      defaultMode: mode,
      updatedAt: DateTime.now(),
    ),
  );
}
```

- [ ] **Step 2: Run codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: `user_info_dao.g.dart` regenerated

- [ ] **Step 3: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/core/database/daos/user_info_dao.dart lib/core/database/daos/user_info_dao.g.dart
git commit -m "feat(dao): add updateDefaultMode method to UserInfoDao"
```

---

### Task 3: Add localization strings

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_my.arb`
- Regenerate: `lib/l10n/app_localizations.dart`, `app_localizations_en.dart`, `app_localizations_my.dart`

**Interfaces:**
- Consumes: none
- Produces: new localization keys for mode selection UI

- [ ] **Step 1: Add English strings to app_en.arb**

Add before the closing `}`:

```json
"selectMode": "Select your counting mode",
"selectModeSubtitle": "Choose how you want to count beads",
"modeStandardDescription": "Count 108 beads per round",
"modeShortDescription": "Count 8 beads per round",
"modeContinuousDescription": "Count without rounds",
"currentMode": "Counting Mode",
"changeMode": "Change"
```

- [ ] **Step 2: Add Myanmar strings to app_my.arb**

```json
"selectMode": "ရေတွက်နည်းကို ရွေးချယ်ပါ",
"selectModeSubtitle": "ပုတီးစိပ်နည်းကို ရွေးချယ်ပါ",
"modeStandardDescription": "တစ်ပတ်လျှင် ၁၀၈ လုံး ရေတွက်ပါ",
"modeShortDescription": "တစ်ပတ်လျှင် ၈ လုံး ရေတွက်ပါ",
"modeContinuousDescription": "ပတ်ရေမရှိဘဲ ဆက်တိုက်ရေတွက်ပါ",
"currentMode": "ရေတွက်နည်း",
"changeMode": "ပြောင်းရန်"
```

- [ ] **Step 3: Run codegen**

Run: `flutter gen-l10n`
Expected: Updates `app_localizations.dart`, `app_localizations_en.dart`, `app_localizations_my.dart`

- [ ] **Step 4: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/l10n/
git commit -m "feat(l10n): add mode selection localization strings"
```

---

### Task 4: Create ModeSelectionPage (inlined in onboarding_screen.dart)

**Files:**
- Modify: `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

**Interfaces:**
- Consumes: `CounterMode` enum from `counter_provider.dart`, `AppLocalizations`
- Produces: Two-step onboarding flow (name page → mode page → save & go to home)

- [ ] **Step 1: Rewrite onboarding_screen.dart**

Replace the entire file content with a `PageView`-based two-step onboarding:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _pageController = PageController();
  bool _saving = false;
  CounterMode _selectedMode = CounterMode.standard;

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToModeSelection() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);

    final dao = ref.read(userInfoDaoProvider);
    final now = DateTime.now();
    await dao.upsertUser(
      UserInfo(
        id: 1,
        name: name,
        rankTitle: 'Novice Chanter',
        defaultMode: _selectedMode.name,
        streakDays: 0,
        totalLifetimeBeads: 0,
        totalLifetimeRounds: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    ref.read(counterProvider.notifier).setMode(_selectedMode);
    ref.invalidate(userInfoProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildNamePage(),
          _buildModePage(),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeTo,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 20,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 48),
            Text(
              AppLocalizations.of(context)!.enterNamePrompt,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.nameHint,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFCBCCC9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF8400),
                    width: 2,
                  ),
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 18,
                color: Color(0xFF111111),
              ),
              onSubmitted: (_) => _goToModeSelection(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _goToModeSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8400),
                  foregroundColor: const Color(0xFF111111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.start,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModePage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text(
              AppLocalizations.of(context)!.selectMode,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.selectModeSubtitle,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
            _ModeOption(
              mode: CounterMode.standard,
              label: AppLocalizations.of(context)!.standardMode,
              description: AppLocalizations.of(context)!.modeStandardDescription,
              isSelected: _selectedMode == CounterMode.standard,
              onTap: () => setState(() => _selectedMode = CounterMode.standard),
            ),
            const SizedBox(height: 12),
            _ModeOption(
              mode: CounterMode.short,
              label: AppLocalizations.of(context)!.shortMode,
              description: AppLocalizations.of(context)!.modeShortDescription,
              isSelected: _selectedMode == CounterMode.short,
              onTap: () => setState(() => _selectedMode = CounterMode.short),
            ),
            const SizedBox(height: 12),
            _ModeOption(
              mode: CounterMode.continuous,
              label: AppLocalizations.of(context)!.continuousMode,
              description: AppLocalizations.of(context)!.modeContinuousDescription,
              isSelected: _selectedMode == CounterMode.continuous,
              onTap: () => setState(() => _selectedMode = CounterMode.continuous),
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8400),
                  foregroundColor: const Color(0xFF111111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF111111),
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.start,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  final CounterMode mode;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeOption({
    required this.mode,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF8400)
                : const Color(0xFFE7E8E5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF8400)
                      : const Color(0xFFCBCCC9),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.circle,
                        size: 10,
                        color: Color(0xFFFF8400),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/onboarding/presentation/screens/onboarding_screen.dart
git commit -m "feat(onboarding): add mode selection as second onboarding step"
```

---

### Task 5: Add `loadMode` to CounterNotifier

**Files:**
- Modify: `lib/features/counter/providers/counter_provider.dart`

**Interfaces:**
- Consumes: `CounterMode` enum
- Produces: `CounterNotifier.loadMode(CounterMode mode)` method

- [ ] **Step 1: Add loadMode method**

In `CounterNotifier` class, add after `setMode`:

```dart
void loadMode(CounterMode mode) {
  state = state.copyWith(mode: mode);
}
```

- [ ] **Step 2: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/counter/providers/counter_provider.dart
git commit -m "feat(counter): add loadMode method to CounterNotifier"
```

---

### Task 6: Update CounterScreen — remove ModeSelector, add mode pill badge

**Files:**
- Modify: `lib/features/counter/presentation/screens/counter_screen.dart`
- Modify: `lib/features/counter/presentation/widgets/tap_to_count.dart`
- Delete: `lib/features/counter/presentation/widgets/mode_selector.dart`

**Interfaces:**
- Consumes: `CounterMode` from `counterProvider`
- Produces: Updated counter screen layout without mode selector, pill badge on TapToCount

- [ ] **Step 1: Update counter_screen.dart**

Remove import: `import '../widgets/mode_selector.dart';`

In the `build` method, replace the mode selector section (lines 52-58):

```dart
// Before:
if (counterState.isTodayPlanActive)
  const TodayPlanDetail()
else
  ModeSelector(
    onModeChange: (mode) => _onModeChange(context, ref, mode),
  ),

// After:
if (counterState.isTodayPlanActive)
  const TodayPlanDetail(),
```

Remove the entire `_onModeChange` method (lines 153-218).

- [ ] **Step 2: Update tap_to_count.dart — add mode pill badge below the circle**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class TapToCount extends ConsumerWidget {
  const TapToCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(counterProvider.select((s) => s.mode));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => ref.read(counterProvider.notifier).increment(),
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withAlpha(13),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.tapToCount,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8400).withAlpha(25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            mode.label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFF8400),
            ),
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 3: Delete mode_selector.dart**

```bash
rm lib/features/counter/presentation/widgets/mode_selector.dart
```

- [ ] **Step 4: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/features/counter/presentation/screens/counter_screen.dart lib/features/counter/presentation/widgets/tap_to_count.dart lib/features/counter/presentation/widgets/mode_selector.dart
git commit -m "feat(counter): remove ModeSelector, show mode as pill badge below TapToCount"
```

---

### Task 7: Add mode row to SettingsScreen

**Files:**
- Modify: `lib/features/settings/presentation/screens/settings_screen.dart`

**Interfaces:**
- Consumes: `CounterMode` from `counterProvider`, `UserInfoDao`, `ModeSelectionPage`
- Produces: Settings screen with mode row that navigates to mode selection

- [ ] **Step 1: Update settings_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/localization/providers/locale_provider.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../counter/providers/counter_provider.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentMode = ref.watch(counterProvider.select((s) => s.mode));

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F0),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.currentMode,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  currentMode.label,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    color: Color(0xFF111111),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => _changeMode(context, ref),
                  child: Text(
                    AppLocalizations.of(context)!.changeMode,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF8400),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _LanguageOption(
                    label: AppLocalizations.of(context)!.english,
                    isSelected: currentLocale.languageCode == 'en',
                    onTap: () => ref
                        .read(localeProvider.notifier)
                        .setLocale(const Locale('en')),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _LanguageOption(
                    label: AppLocalizations.of(context)!.burmese,
                    isSelected: currentLocale.languageCode == 'my',
                    onTap: () => ref
                        .read(localeProvider.notifier)
                        .setLocale(const Locale('my')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeMode(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<CounterMode>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _ModeBottomSheet(
        currentMode: ref.read(counterProvider.select((s) => s.mode)),
      ),
    );
    if (result != null) {
      ref.read(counterProvider.notifier).setMode(result);
      final dao = ref.read(userInfoDaoProvider);
      await dao.updateDefaultMode(result.name);
    }
  }
}

class _ModeBottomSheet extends StatelessWidget {
  final CounterMode currentMode;

  const _ModeBottomSheet({required this.currentMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectMode,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 16),
          ...CounterMode.values.map(
            (mode) => ListTile(
              title: Text(
                mode.label,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  color: Color(0xFF111111),
                ),
              ),
              trailing: mode == currentMode
                  ? const Icon(
                      Icons.check_rounded,
                      color: Color(0xFFFF8400),
                      size: 20,
                    )
                  : null,
              onTap: () => Navigator.pop(context, mode),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: Color(0xFF111111),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: Color(0xFFFF8400),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/settings/presentation/screens/settings_screen.dart
git commit -m "feat(settings): add mode selection row with bottom sheet"
```

---

### Task 8: Update app.dart to load persisted mode

**Files:**
- Modify: `lib/app.dart`

**Interfaces:**
- Consumes: `UserInfo.defaultMode`, `CounterNotifier.loadMode()`
- Produces: Updated routing logic, mode loaded on app start

- [ ] **Step 1: Update app.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/providers/app_database_providers.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/providers/locale_provider.dart';
import 'features/home/presentation/screens/home_shell.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/counter/providers/counter_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Meditation',
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F3F0),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF8400),
          surface: Color(0xFFF2F3F0),
          onSurface: Color(0xFF111111),
        ),
        fontFamily: 'Geist',
      ),
      home: userAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => Scaffold(
          body: Center(
            child: Text(
              'Error loading app',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ),
        data: (user) {
          if (user == null) return const OnboardingScreen();
          if (user.name == 'Meditator' && user.totalLifetimeBeads == 0) {
            return const OnboardingScreen();
          }
          // Load persisted mode into counter provider
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final modeName = user.defaultMode ?? 'standard';
            final mode = CounterMode.values.firstWhere(
              (m) => m.name == modeName,
              orElse: () => CounterMode.standard,
            );
            ref.read(counterProvider.notifier).loadMode(mode);
          });
          return const HomeShell();
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/app.dart
git commit -m "feat(app): load persisted user mode on app start"
```

---

### Task 9: Run full verification

**Files:**
- None (verification only)

- [ ] **Step 1: Run all codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: All `.g.dart` files regenerated

- [ ] **Step 2: Run l10n generation**

Run: `flutter gen-l10n`
Expected: All localization files updated

- [ ] **Step 3: Run analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 4: Run tests**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 5: Final commit if any files changed**

```bash
git add -A
git commit -m "chore: regenerate codegen and l10n files"
```
