# AGENTS.md

## Commands

| Action | Command |
|---|---|
| Run all tests | `flutter test` |
| Run a specific test | `flutter test test/widget_test.dart` |
| Lint check | `flutter analyze` |
| Format code | `dart format .` |
| Drift codegen | `dart run build_runner build --delete-conflicting-outputs` |

**Required order** after editing Drift tables or DAOs: `build_runner` → `flutter analyze` → `flutter test`. After changing `pubspec.yaml`: `flutter pub get`.

## Architecture

- **State management:** Hand-written Riverpod providers (`Provider`, `FutureProvider`, `StateNotifierProvider`) — no `riverpod_generator` or `@riverpod` annotations. Providers live in `lib/features/{name}/providers/` and `lib/core/database/providers/`.
- **Database:** Drift (SQLite) with codegen (`*_dao.g.dart`, `database.g.dart`). Schema version 3 with migration logic in `lib/core/database/database.dart`. The `AppDatabase` class has two constructors: default (production) and `AppDatabase.fromExecutor(executor)` (for in-memory test DB).
- **Migration history:** v1→v2 creates tables `gongDawDetails`, `beadPlans`, `planDays`, `userPlanProgress` + seeds predefined data. v2→v3 adds `gongDawName` column to `planDays`. On fresh creation, DB also inserts a default user ("Meditator") and a 9-day predefined plan.
- **Feature structure:** `lib/features/{name}/{presentation,providers}/`. UI in `screens/`, reusable widgets in `widgets/`. Not every feature has both subdirectories.
- **Routing:** No router library. Conditional inline routing in `lib/app.dart` via `userAsync.when`. The `lib/router/` directory exists but is empty and unused.
- **Custom font:** `fontFamily: 'Geist'` is set in the theme but **font files are not bundled** — no `assets/` or `fonts/` directory exists, no font declared in `pubspec.yaml`. The app silently falls back to the system default. To actually use Geist, you must add font files to the project and declare them in `pubspec.yaml` under `flutter: fonts:`.

## Testing

- Test helpers in `test/test_helpers.dart`: `createTestDatabase()` (in-memory SQLite via `NativeDatabase.memory()`), `createTestProviderScope()` (overrides `databaseProvider`), `seedTestUser()`, `seedTestPlan()`.
- After async DB writes in tests, use `tester.runAsync(() => Future.delayed(...))` followed by multiple `tester.pump()` — never just `pump()` alone.
- All tests are in a single file `test/widget_test.dart`.
- No CI workflows exist (`.github/workflows/` is absent).

## Constraints

- **This file is gitignored** (listed in root `.gitignore`). Changes to `AGENTS.md` will not be tracked.
- Never run the app (`flutter run`) unless explicitly asked.
- This is a private project (`publish_to: none`).
- The `.idea/`, `build/`, `.dart_tool/`, `*.iml` files are gitignored.
