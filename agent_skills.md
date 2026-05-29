# Agent Skills — Reusable Blueprints & Commands

## Riverpod AsyncNotifierProvider Template

```dart
// --- Data Layer ---
class Model {
  final String id;
  const Model({required this.id});
}

// --- Domain/Repository ---
abstract class Repository {
  Future<Model> fetch();
}

// --- Presentation / Notifier ---
class MyNotifier extends AsyncNotifier<Model> {
  @override
  Future<Model> build() async {
    final repo = ref.read(repositoryProvider);
    return repo.fetch();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}

final myProvider = AsyncNotifierProvider<MyNotifier, Model>(MyNotifier.new);
```

## Responsive Stateless Widget Wrapper

```dart
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return isWide ? _buildWide(context) : _buildNarrow(context);
      },
    );
  }

  Widget _buildWide(BuildContext context) {
    // Tablet / desktop layout
    return const Placeholder();
  }

  Widget _buildNarrow(BuildContext context) {
    // Phone layout
    return const Placeholder();
  }
}
```

## Essential Terminal Commands

| Command | Description |
|---|---|
| `flutter pub get` | Resolve/install dependencies |
| `flutter pub upgrade` | Upgrade all packages to latest compatible |
| `dart run build_runner build --delete-conflicting-outputs` | Run code generation |
| `dart run build_runner watch --delete-conflicting-outputs` | Auto-generate on file changes |
| `flutter analyze` | Static analysis / lint checks |
| `flutter test` | Run all tests |
| `flutter test --coverage` | Run tests with coverage report |
| `flutter clean && flutter pub get` | Full clean rebuild |
| `dart format .` | Format all Dart files |
