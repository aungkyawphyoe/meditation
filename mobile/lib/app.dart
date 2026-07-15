import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import 'services/wear_communication.dart';
import 'core/database/providers/app_database_providers.dart';
import 'core/database/database.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/providers/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/home/presentation/screens/home_shell.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/counter/providers/counter_provider.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  StreamSubscription<SyncData>? _syncSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initSyncListener());
  }

  Future<void> _initSyncListener() async {
    _syncSubscription = WearCommunication.syncDataStream.listen(_handleSync);
  }

  Future<void> _handleSync(SyncData data) async {
    final chantDao = ref.read(chantSessionDaoProvider);
    final userDao = ref.read(userInfoDaoProvider);

    await chantDao.insertSession(
      ChantSessionsTableCompanion(
        mode: Value(data.mode.name),
        beadsCount: Value(data.beadCount),
        roundsCompleted: Value(data.roundsCompleted),
        startedAt: Value(DateTime.now()),
        completedAt: Value(null),
      ),
    );

    final user = await userDao.getUser();
    if (user != null) {
      await userDao.updateLifetimeStats(
        totalBeads: user.totalLifetimeBeads + data.beadCount,
        totalRounds: user.totalLifetimeRounds + data.roundsCompleted,
      );
    }

    ref.invalidate(userInfoProvider);
    ref.invalidate(lifetimeRoundsProvider);
    ref.invalidate(counterRoundsProvider);
  }

  @override
  void dispose() {
    _syncSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userInfoProvider);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    ref.listen<CounterMode>(
      counterProvider.select((s) => s.mode),
      (prev, next) {
        if (prev != null && next != prev) {
          WearCommunication.sendModeToWatch(next);
        }
      },
    );

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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: userAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => Scaffold(
          body: Center(
            child: Text(
              'Error loading app',
              style: const TextStyle(
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
            final modeName = user.defaultMode;
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
