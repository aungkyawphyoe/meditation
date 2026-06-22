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

    await tester.enterText(find.byType(TextField), 'Test User');
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
    expect(find.text('Standard (108)'), findsOneWidget);
    expect(find.text('Short (8)'), findsOneWidget);
    expect(find.text('Continuous'), findsOneWidget);
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
    expect(find.text('Novice Chanter • 12 Days Streak'), findsOneWidget);

    await tester.tap(find.text('Counter'));
    await tester.pump();
    expect(find.text('Meditation'), findsOneWidget);
  });

  testWidgets('Mode switch shows save dialog with session beads', (
    WidgetTester tester,
  ) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(
      createTestProviderScope(child: const App(), database: db),
    );
    await tester.pump(const Duration(milliseconds: 100));

    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('TAP TO COUNT'));
    }
    await tester.pump();
    expect(find.text('005'), findsOneWidget);

    await tester.tap(find.text('Short (8)'));
    await tester.pump();

    expect(find.text('Save Session?'), findsOneWidget);
    expect(find.text('Discard'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
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

  testWidgets('Start Today Plan enters plan mode and hides mode selector', (
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
    expect(find.text('Standard (108)'), findsNothing);
    expect(find.text('Short (8)'), findsNothing);
    expect(find.text('Continuous'), findsNothing);
    expect(find.text('Test Plan'), findsAtLeast(1));
    expect(find.text('3 beads per round — 2 rounds today'), findsOneWidget);
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
}
