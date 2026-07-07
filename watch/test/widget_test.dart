import 'package:flutter_test/flutter_test.dart';

import 'package:bead_counter/main.dart';

void main() {
  testWidgets('Bead counter starts at 0 and increments on tap', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MeditationWatchApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.text('0'));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
