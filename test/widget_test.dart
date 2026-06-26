import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meditation/app.dart';
import 'test_helpers.dart';

void main() {
  testWidgets('App renders onboarding on first launch', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('Enter your name to get started'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('Onboarding saves name and navigates to counter', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump();

    // Step 1: Enter name and tap Start (goes to mode selection page)
    await tester.enterText(find.byType(TextField), 'Test User');
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    // Step 2: Mode selection page — keep Standard (default) and tap Start
    expect(find.text('Standard (108)'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pump();
    // Let async DB write + provider invalidation complete
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Meditation'), findsOneWidget);
    expect(find.text('000'), findsOneWidget);
    expect(find.text('TAP TO COUNT'), findsOneWidget);

    // Navigate to profile to verify name was saved
    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(find.text('Test User'), findsOneWidget);
  });

  testWidgets('App renders counter screen when user exists', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Meditation'), findsOneWidget);
    // Mode badge shows only the current mode (standard by default)
    expect(find.text('Standard (108)'), findsOneWidget);
    expect(find.text('000'), findsOneWidget);
    expect(find.text('TAP TO COUNT'), findsOneWidget);
    expect(find.text('TOTAL ROUNDS'), findsOneWidget);
    expect(find.text('Counter'), findsOneWidget);
    expect(find.text('Plans'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Tapping tap area increments counter', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('TAP TO COUNT'));
    await tester.pump();

    expect(find.text('001'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Plans'));
    await tester.pump();
    expect(find.text('Subscribed'), findsOneWidget);
    expect(find.text('List'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(find.text('Alex Practitioner'), findsOneWidget);
    expect(find.textContaining('Novice Chanter'), findsOneWidget);
    expect(find.textContaining('12 Days Streak'), findsOneWidget);

    await tester.tap(find.text('Counter'));
    await tester.pump();
    expect(find.text('Meditation'), findsOneWidget);
  });

  testWidgets('Mode switch via settings resets session state', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Tap some beads
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();
    expect(find.text('005'), findsOneWidget);

    // Navigate to Profile tab, then open Settings
    await tester.tap(find.text('Profile'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    // Tap Change Mode to open bottom sheet
    await tester.tap(find.text('Change'));
    await tester.pumpAndSettle();

    // Select Short mode
    await tester.tap(find.text('Short (8)'));
    await tester.pumpAndSettle();

    // Go back to counter via Navigator pop then counter tab
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Counter'));
    await tester.pumpAndSettle();

    // Mode badge should now show Short (8)
    expect(find.text('Short (8)'), findsOneWidget);
    // Session should be reset after mode switch
    expect(find.text('000'), findsOneWidget);
  });

  testWidgets('Subscribed user sees Start Today Plan button', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Start Today Plan'), findsOneWidget);
    expect(find.text('Standard (108)'), findsOneWidget);
  });

  testWidgets('Start Today Plan enters plan mode and shows plan details', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Start Today Plan'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Exit Today Plan'), findsOneWidget);
    expect(find.text('Test Plan'), findsAtLeast(1));
    expect(find.text('3 beads per round · 2 days'), findsOneWidget);
    // Mode badge is always visible in TapToCount (not hidden during plan mode)
    expect(find.text('Standard (108)'), findsOneWidget);
  });

  testWidgets('Exiting today plan returns to free mode', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Start Today Plan'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Exit Today Plan'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Start Today Plan'), findsOneWidget);
    expect(find.text('Standard (108)'), findsOneWidget);
    expect(find.text('Test Plan'), findsNothing);
  });

  testWidgets(
    'Completing all rounds shows completion overlay and hides button',
    (WidgetTester tester) async {
      final db = createTestDatabase();
      await seedTestUser(db);
      await seedTestPlan(db);
      await tester.pumpWidget(
        createTestProviderScope(child: const App(), database: db),
      );
      await tester.runAsync(
        () => Future.delayed(const Duration(milliseconds: 500)),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('Start Today Plan'));
      await tester.runAsync(
        () => Future.delayed(const Duration(milliseconds: 500)),
      );
      await tester.pump();
      await tester.pump();

      // Plan: 3 beads/round, 2 rounds target → 6 taps to complete
      for (int i = 0; i < 6; i++) {
        await tester.tap(find.text('TAP TO COUNT'));
      }
      await tester.pump();
      await tester.pump();

      expect(find.text("Today's Plan\nComplete!"), findsOneWidget);
      expect(find.text('All rounds completed'), findsOneWidget);

      // After 2 seconds, overlay dismisses and button is hidden
      await tester.runAsync(() => Future.delayed(const Duration(seconds: 3)));
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      expect(find.text('Start Today Plan'), findsNothing);
      expect(find.text('Standard (108)'), findsOneWidget);
    },
  );

  testWidgets('Unsubscribed user does not see Start Today Plan', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Start Today Plan'), findsNothing);
    expect(find.text('Standard (108)'), findsOneWidget);
  });

  testWidgets('Subscribed tab shows Stop Plan button', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Plans'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Active Plan'), findsOneWidget);
    expect(find.text('Stop Plan'), findsOneWidget);
  });

  testWidgets('Stop Plan with Cancel keeps plan active', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Plans'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Stop Plan'));
    await tester.pumpAndSettle();

    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Active Plan'), findsOneWidget);
    expect(find.text('Test Plan'), findsOneWidget);
  });

  testWidgets('Stop Plan with confirmation removes plan from Subscribed tab', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Plans'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Active Plan'), findsOneWidget);

    await tester.tap(find.text('Stop Plan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Stop'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.text('Active Plan'), findsNothing);
    expect(find.text('No Active Plan'), findsOneWidget);
  });

  testWidgets('Stopped plan shows as Failed in Profile', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Plans'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Stop Plan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Stop'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Profile'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.text('Test Plan'), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Rank updates after completing rounds and saving session', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Complete 1 full round in standard mode (108 beads)
    for (int i = 0; i < 108; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();

    // Save session
    await tester.tap(find.text('Save'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    // Check profile for rank update
    await tester.tap(find.text('Profile'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Novice Chanter'), findsOneWidget);
  });

  testWidgets('Free mode shows Save and Reset buttons', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('Plan mode shows only Reset button, not Save', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await seedTestPlan(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Start Today Plan'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Save'), findsNothing);
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('Save and Reset buttons render in free mode', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Save button text should exist in the widget tree
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('Reset button clears counters without saving', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Tap some beads
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();
    expect(find.text('005'), findsOneWidget);

    // Tap Reset
    await tester.tap(find.text('Reset'));
    await tester.pump();

    // Counter should reset to 000
    expect(find.text('000'), findsOneWidget);
  });

  testWidgets('Save button saves session and resets counters', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Tap some beads
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();
    expect(find.text('005'), findsOneWidget);

    // Tap Save
    await tester.tap(find.text('Save'));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump();

    // Counter should reset to 000 after save
    expect(find.text('000'), findsOneWidget);
  });

  testWidgets('Short mode rounds increment after 8 taps', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Switch to Short mode via settings
    await tester.tap(find.text('Profile'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Change'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Short (8)'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Counter'));
    await tester.pumpAndSettle();

    expect(find.text('Short (8)'), findsOneWidget);

    // Tap 7 times — should show 007 with 0 rounds
    for (int i = 0; i < 7; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();
    expect(find.text('007'), findsOneWidget);
    expect(find.text('0'), findsWidgets); // Total Rounds = 0

    // 8th tap — counter wraps to 000, rounds should be 1
    await tester.tap(find.text('TAP TO COUNT'));
    await tester.pump();
    expect(find.text('000'), findsOneWidget);

    // Total Rounds display should show 1
    expect(find.text('1'), findsWidgets);
  });

  testWidgets('Short mode rounds increment across multiple rounds', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    // Switch to Short mode via settings
    await tester.tap(find.text('Profile'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Change'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Short (8)'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Counter'));
    await tester.pumpAndSettle();

    // Tap 16 times — should complete 2 rounds
    for (int i = 0; i < 16; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();

    expect(find.text('000'), findsOneWidget);

    // Total Rounds display should show 2
    expect(find.text('2'), findsWidgets);
  });
}
