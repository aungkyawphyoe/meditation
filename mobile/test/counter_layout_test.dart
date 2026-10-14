import 'package:flutter/material.dart';
import 'package:meditation/features/counter/presentation/widgets/completion_overlay.dart';
import 'package:meditation/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meditation/core/database/providers/app_database_providers.dart';
import 'package:meditation/core/database/providers/plan_providers.dart';
import 'package:meditation/features/counter/providers/counter_provider.dart';
import 'package:meditation/features/counter/presentation/widgets/tap_to_count.dart';
import 'package:meditation/features/counter/presentation/widgets/action_buttons.dart';
import 'package:meditation/features/home/presentation/screens/home_shell.dart';
import 'package:meditation/l10n/app_localizations.dart';

void main() {
  testWidgets('Completion fits compact landscape with larger text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(568, 320);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.5)),
          child: child!,
        ),
        home: const Scaffold(body: CompletionOverlay()),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final message = tester.getRect(find.byIcon(Icons.check_circle));
    expect(
      (Offset.zero & const Size(568, 320)).contains(message.center),
      isTrue,
    );
    expect(find.byType(Scrollable), findsNothing);
  });

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(568, 320),
    const Size(844, 390),
    const Size(768, 1024),
    const Size(1366, 768),
  ]) {
    for (final inPlan in [false, true]) {
      testWidgets('Counter fits $size, plan: $inPlan', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final counter = CounterNotifier();
        if (inPlan) {
          counter.startTodayPlan(
            'A longer meditation plan name that wraps on compact screens',
            108,
            3,
          );
        }
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              counterProvider.overrideWith((ref) => counter),
              hasActivePlanProvider.overrideWithValue(true),
              counterRoundsProvider.overrideWith((ref) async => 0),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(inPlan ? 1.5 : 1)),
                child: child!,
              ),
              home: const HomeShell(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(Scrollable), findsNothing);
        final tap = find.descendant(
          of: find.byType(TapToCount),
          matching: find.byType(GestureDetector),
        );
        final tapRect = tester.getRect(tap);
        expect(
          tapRect.overlaps(tester.getRect(find.byType(ActionButtons))),
          isFalse,
        );
        expect(tapRect.width, greaterThanOrEqualTo(48));
        expect(tapRect.height, greaterThanOrEqualTo(48));
        final planButton = find.byType(ElevatedButton);
        expect(tapRect.overlaps(tester.getRect(planButton)), isFalse);
        expect(find.byType(ActionButtons).hitTestable(), findsOneWidget);
        expect(planButton.hitTestable(), findsOneWidget);
        await tester.tap(tap);
        await tester.pump();
        expect(counter.state.beadCount, 1);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
