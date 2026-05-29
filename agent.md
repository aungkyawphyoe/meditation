# Agent.md — Master Coordination & Architecture

## Core Role
Expert Flutter & Dart Engineer specialized in responsive layout architecture and declarative state management.

## Tech Stack Profile
- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Riverpod (v2 — Providers/Notifiers/AsyncNotifiers)
- **Architecture:** Clean Architecture (Data → Domain → Presentation layers)
- **Code Generation:** build_runner (freezed, json_serializable, riverpod_generator)

## Project Context
- **Package Name:** meditation
- **Description:** A new Flutter project.
- **SDK Constraint:** ^3.11.5
- **Dependencies:** flutter, cupertino_icons, flutter_riverpod
- **Dev Dependencies:** flutter_test, flutter_lints
- **Publish To:** none (private)
- **State Management:** Riverpod StateNotifier + StateNotifierProvider
- **Architecture:** Feature-first Clean Architecture

## Flutter Coding Rules
1. **const constructors** — Use `const` wherever possible for widget optimization; never skip it.
2. **Responsive layouts** — Use `LayoutBuilder`, `MediaQuery`, `Flex`, or `Expanded` instead of hardcoded pixel values.
3. **Separation of concerns** — Business logic stays in Riverpod Providers/Notifiers; UI widgets are pure presentation.
4. **Build commands** — Run `flutter pub get` when dependencies change; run `dart run build_runner build --delete-conflicting-outputs` after code-generation edits.
5. **Naming conventions** — Files: `snake_case`. Classes/typedefs: `PascalCase`. Providers: `camelCase` prefixed with provider type (e.g. `final counterProvider = StateProvider<int>((ref) => 0);`).

## Memory / Roadmap

### Features
- [x] Initial scaffold & app entry point
- [x] Ralph Wiggum setup (constitution, scripts, AGENTS.md, CLAUDE.md)
- [x] Counter screen with 3 modes (Standard 108, Short 8, Continuous)
- [x] Mode selector segmented control
- [x] Tap-to-count circular area
- [x] Total rounds + session beads stats display
- [x] Plans screen placeholder
- [x] Profile screen with avatar, stats cards, session history
- [x] Bottom navigation tab bar
- [ ] Session persistence / history storage
- [ ] Haptic/vibration feedback on count

### Widgets to Build
- [x] CounterScreen
- [x] ModeSelector
- [x] CounterDisplay
- [x] TapToCount
- [x] StatsDisplay
- [x] PlansScreen
- [x] ProfileScreen
- [x] HomeShell (tab navigation)
- [x] TabItem

### Refactoring Targets
- [ ] Extract session history into a separate provider/model
- [ ] Add database persistence (drift or shared_preferences)

### Bugs / Issues
- [ ] TBD
