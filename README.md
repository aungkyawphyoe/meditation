# Bead Counter

A Buddhist meditation bead counter with a mobile app and Wear OS companion watch app. Built with Flutter.

## Repository Structure

```
├── mobile/       # Meditation bead counter mobile app (phone/tablet)
└── watch/        # Wear OS companion app for counting on the wrist
```

## Projects

| Project | Platform | Description |
|---|---|---|
| **mobile** | Android, iOS | Full-featured bead counter with plans, profiles, and session tracking. Local SQLite database via Drift. |
| **watch** | Wear OS | Companion app that syncs bead counts and rounds to the mobile app via DataApi. Receives the current counter mode from the phone. |

## Tech Stack

- **Flutter** (SDK ^3.11.5)
- **Riverpod** for state management
- **Drift** (SQLite) for local persistence
- **Wear Plus** for Wear OS connectivity
- **Localization:** English & Myanmar (Burmese)

## Getting Started

```bash
# Mobile app
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

# Watch app
cd watch
flutter pub get
flutter run
```

## Requirements

- Flutter SDK ^3.11.5
- Dart SDK ^3.11.5
- For the watch app: Wear OS emulator or physical device
