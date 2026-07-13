# Bead Counter (Wear OS)

Companion Wear OS app for the Bead Counter meditation app. Count beads and rounds directly from your wrist and sync to the mobile app.

## Features

- **Bead Counting** — Tap the circular button to increment bead count
- **Mode Support** — Receives the current counter mode from the phone (Standard 108, Short 8, Continuous)
- **Round Tracking** — Automatically tracks rounds completed based on the active mode
- **Sync** — Send bead counts and rounds to the phone app via Wear OS DataApi
- **Reset** — Clear current session and start fresh

## How It Works

The watch listens for mode changes sent from the phone. When the phone changes counter mode, the watch updates automatically and resets the current count.

| Mode | Beads Per Round | Behavior |
|---|---|---|
| Standard | 108 | Resets to 0 and increments round count every 108 beads |
| Short | 8 | Resets to 0 and increments round count every 8 beads |
| Continuous | Unlimited | Counts indefinitely without round tracking |

## Tech Stack

| Component | Technology |
|---|---|
| Framework | Flutter (SDK ^3.11.5) |
| Platform | Wear OS |
| Communication | MethodChannel (`com.example.meditation.wear/communication`) |
| Dependencies | wear_plus |

## Architecture

```
lib/
├── main.dart                          # App entry point, counter UI
└── services/
    └── wear_communication.dart        # MethodChannel for phone communication
```

### Communication Protocol

The watch uses `MethodChannel` to communicate with the phone:

- **Receives** `onModeUpdate` — phone sends the current `CounterMode` (standard/short/continuous)
- **Sends** `sendSyncData` — watch sends `{beadCount, roundsCompleted, mode}` to the phone

## Build & Development

```bash
cd watch
flutter pub get
flutter run
```

Requires a Wear OS emulator or physical device.

## Version

1.0.0+1 (private, `publish_to: none`)
