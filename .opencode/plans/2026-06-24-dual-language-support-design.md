# Dual Language Support (English / Burmese)

## Goal

Add English and Burmese (Myanmar) language support to the meditation app with a language toggle on a new Settings screen accessible from the Profile page.

## Scope

- **In scope**: UI chrome strings (buttons, labels, headings, navigation, error messages)
- **Out of scope**: Buddhist content stored in the database (gong/daw names, plan titles) — these remain as-is

## Approach

Flutter's official localization system: `flutter_localizations` + ARB files + `flutter gen-l10n`.

## Dependencies

| Package | Purpose |
|---|---|
| `flutter_localizations` (SDK) | Flutter localization delegates |
| `intl` | ICU message formatting, ARB support |
| `shared_preferences` | Persist language selection across restarts |

## Files to Create

### `l10n.yaml` (project root)

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

### `lib/l10n/app_en.arb`

English translations (template file). All UI strings with keys following `snake_case` convention.

### `lib/l10n/app_my.arb`

Burmese/Myanmar translations. Same keys as English, Burmese values.

### `lib/core/localization/providers/locale_provider.dart`

Riverpod providers for locale management:

- `localeProvider` — `StateProvider<Locale>` defaulting to `Locale('en')`
- On change, persists to `shared_preferences` under key `selected_locale`
- On app startup, reads persisted locale and initializes `localeProvider`

### `lib/features/settings/presentation/screens/settings_screen.dart`

Language toggle screen:
- Title: "Settings" / "ဆက်ညှိနှိုင်းခြင်း"
- Language section with two options:
  - English — "English"
  - Myanmar — "မြန်မာ"
- Active language shows a checkmark (orange, matching brand color)
- Selecting a language updates `localeProvider` and pops back to Profile
- Follows existing card-based UI patterns (white cards, rounded corners, brand orange accent)

## Files to Modify

### `pubspec.yaml`

- Add `flutter_localizations` and `intl` to dependencies
- Add `shared_preferences` to dependencies
- Add `generate: true` under `flutter:` section

### `lib/app.dart`

- Import generated `AppLocalizations`
- Add to `MaterialApp`:
  - `localizationsDelegates: AppLocalizations.localizationsDelegates`
  - `supportedLocales: AppLocalizations.supportedLocales`
  - `locale: ref.watch(localeProvider)` (wrap with Consumer)

### `lib/features/profile/presentation/screens/profile_screen.dart`

- Add a settings icon button (gear icon) in the header area
- On tap, navigate to `SettingsScreen`
- Migrate all hardcoded strings to `AppLocalizations.of(context)!.key`

### Screen-by-screen string migration

All screens get their hardcoded strings replaced with localized lookups:

- `home_shell.dart` — bottom nav labels (Counter, Plans, Profile)
- `counter_screen.dart` — counter labels and messages
- `plans_screen.dart` — plan list headers, empty states
- `plan_detail_screen.dart` — plan detail labels
- `add_plan_screen.dart` — form labels
- `onboarding_screen.dart` — onboarding prompts

## Locale Persistence Flow

1. App starts → read `shared_preferences` for `selected_locale`
2. If found, set `localeProvider` to that locale
3. If not found, default to `Locale('en')`
4. User changes language in Settings → update `localeProvider` → save to `shared_preferences`
5. `MaterialApp` rebuilds with new locale via `ref.watch(localeProvider)`

## String Count Estimate

~40-50 translatable strings across all screens.

## Verification

1. `flutter gen-l10n` generates without errors
2. `flutter analyze` passes
3. `flutter test` passes
4. Manual verification: toggle language in Settings, confirm all UI strings update
5. Restart app, confirm language persists
