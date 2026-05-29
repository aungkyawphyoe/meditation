import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditation/app.dart';
import 'package:meditation/core/database/database.dart';
import 'test_helpers.dart';

void main() {
  testWidgets('App renders onboarding on first launch', (WidgetTester tester) async {
    final db = createTestDatabase();
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('Enter your name to get started'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('Onboarding saves name and navigates to counter', (WidgetTester tester) async {
    final db = createTestDatabase();
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Test User');
    await tester.tap(find.text('Start'));
    await tester.pump();
    // Let async DB write + provider invalidation complete
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 500)));
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

  testWidgets('App renders counter screen when user exists', (WidgetTester tester) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
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

  testWidgets('Tapping tap area increments counter', (WidgetTester tester) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('TAP TO COUNT'));
    await tester.pump();

    expect(find.text('001'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Plans'));
    await tester.pump();
    expect(find.text('Plans - Coming Soon'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(find.text('Alex Practitioner'), findsOneWidget);
    expect(find.text('Novice Chanter • 12 Days Streak'), findsOneWidget);

    await tester.tap(find.text('Counter'));
    await tester.pump();
    expect(find.text('Meditation'), findsOneWidget);
  });

  testWidgets('Mode switch shows save dialog with session beads', (WidgetTester tester) async {
    final db = createTestDatabase();
    await seedTestUser(db);
    await tester.pumpWidget(createTestProviderScope(child: const App(), database: db));
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
}
