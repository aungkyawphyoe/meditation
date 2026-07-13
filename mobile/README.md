# Bead Counter (Mobile)

A Buddhist meditation bead counter app for Android and iOS. Track meditation sessions, follow structured multi-day plans centered on the 9 Noble Qualities of the Buddha, and monitor progress over time.

## Features

- **Bead Counter** — Tap to count beads with three modes: Standard (108), Short (8), and Continuous
- **Plans** — Create and follow structured multi-day meditation plans with escalating round targets
- **Predefined Plan** — "ကိုးနဝင်း အဓိဋ္ဌာန် (၉ ရက်)" built-in 9-day plan covering the 9 Noble Qualities
- **Profile** — Lifetime stats, rank progression (10 tiers based on total rounds), streak tracking
- **Rank System** — Progress from Novice Chanter to Master Chanter based on total rounds completed
- **Localization** — English and Myanmar (Burmese) language support
- **Daily Reminders** — Configurable notification at 9 AM every day
- **Wear OS Sync** — Sync bead counts and rounds with the watch companion app
- **Session History** — All sessions saved to local database with mode, bead count, and rounds

## Screens

| Screen | Description |
|---|---|
| **Onboarding** | Name entry, counter mode selection, language picker |
| **Counter** | Bead counting interface with tap area, stats display, and plan controls |
| **Plans** | List of all plans (predefined + custom) and subscribed active plan view |
| **Plan Detail** | View and activate a plan, see day-by-day schedule |
| **Add Plan** | Create custom plans with custom days, gong/daw, and round targets |
| **Profile** | User avatar, name, rank, stats, and recent plan history |
| **Settings** | Change counter mode and language preference |

## Tech Stack

| Component | Technology |
|---|---|
| Framework | Flutter (SDK ^3.11.5) |
| State Management | flutter_riverpod ^2.6.1 |
| Database | drift ^2.26.0 (SQLite) |
| Notifications | flutter_local_notifications ^18.0.0 |
| Wear OS | wear_plus (phone-side communication) |
| Localization | Flutter intl (English + Myanmar) |
| Codegen | build_runner + drift_dev |

## Architecture

```
lib/
├── app.dart                   # App root, routing, sync listener
├── main.dart                  # Entry point, notification setup
├── core/
│   ├── database/
│   │   ├── database.dart      # Drift database, migrations, seed data
│   │   ├── daos/              # Data access objects
│   │   ├── tables/            # Table definitions
│   │   ├── models/            # Data classes (PlanProgressSummary)
│   │   └── providers/         # Riverpod providers for DB
│   ├── localization/          # Locale state provider
│   ├── theme/                 # Theme constants
│   └── utils/                 # Rank calculation
├── features/
│   ├── counter/               # Bead counter (screen, widgets, provider)
│   ├── home/                  # Bottom navigation shell
│   ├── onboarding/            # Welcome flow
│   ├── plans/                 # Plan management
│   └── profile/               # User profile
└── services/
    └── wear_communication.dart  # Wear OS MethodChannel bridge
```

### State Management

- **CounterNotifier** (StateNotifier) manages bead count, rounds, session state, and plan context
- **FutureProvider** wrappers around DAO calls for async data
- **ref.invalidate(...)** is the primary refresh strategy after writes

### Routing

No routing library. The root `App` widget conditionally renders `OnboardingScreen` or `HomeShell` based on user state. Sub-screens use `Navigator.push`.

## Database

6 tables managed by Drift:

| Table | Purpose |
|---|---|
| `UserInfoTable` | Single-row user profile (name, rank, stats) |
| `ChantSessionsTable` | Individual meditation sessions |
| `BeadPlansTable` | Plan definitions (title, description, beads per round) |
| `PlanDaysTable` | Per-day targets (gong/daw, target rounds) |
| `GongDawDetailsTable` | 9 Noble Qualities of the Buddha reference data |
| `UserPlanProgressTable` | User's plan subscriptions and progress |

## Build & Development

```bash
# Dependencies
flutter pub get

# Drift codegen (run after schema changes)
dart run build_runner build --delete-conflicting-outputs

# Run
flutter run --debug-artefacts

# Analyze
flutter analyze

# Format
dart format .

# Test
flutter test
flutter test --coverage
```

## Localization

Strings are in `lib/l10n/`. Supported locales:
- English (`en`) — `app_localizations_en.dart`
- Myanmar (`my`) — `app_localizations_my.dart`

## Wear OS Communication

The mobile app communicates with the watch companion via a `MethodChannel` (`com.example.meditation/communication`):
- **Receives** sync data (bead count, rounds, mode) from watch
- **Sends** counter mode changes to watch

## Version

1.0.0+1 (private, `publish_to: none`)
