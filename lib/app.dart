import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/providers/app_database_providers.dart';
import 'features/home/presentation/screens/home_shell.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);

    return MaterialApp(
      title: 'Meditation',
      debugShowCheckedModeBanner: false,
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
          return const HomeShell();
        },
      ),
    );
  }
}
