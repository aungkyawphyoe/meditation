import 'package:flutter_test/flutter_test.dart';
import 'package:meditation/features/counter/providers/counter_provider.dart';

void main() {
  group('CounterNotifier', () {
    group('Standard mode (108 beads/round)', () {
      test('roundsCompleted increments after 108 taps', () {
        final notifier = CounterNotifier();

        for (int i = 0; i < 108; i++) {
          notifier.increment();
        }

        expect(notifier.state.roundsCompleted, 1);
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.sessionBeads, 108);
      });

      test('beadCount wraps to 0 after 108 taps', () {
        final notifier = CounterNotifier();

        for (int i = 0; i < 107; i++) {
          notifier.increment();
        }
        expect(notifier.state.beadCount, 107);
        expect(notifier.state.roundsCompleted, 0);

        notifier.increment();
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.roundsCompleted, 1);
      });
    });

    group('Short mode (8 beads/round)', () {
      test('roundsCompleted increments after 8 taps', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 8; i++) {
          notifier.increment();
        }

        expect(notifier.state.roundsCompleted, 1);
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.sessionBeads, 8);
      });

      test('beadCount wraps to 0 after 8 taps', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 7; i++) {
          notifier.increment();
        }
        expect(notifier.state.beadCount, 7);
        expect(notifier.state.roundsCompleted, 0);

        notifier.increment();
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.roundsCompleted, 1);
      });

      test('roundsCompleted increments multiple times in Short mode', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 16; i++) {
          notifier.increment();
        }

        expect(notifier.state.roundsCompleted, 2);
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.sessionBeads, 16);
      });

      test('partial round does not increment roundsCompleted', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 5; i++) {
          notifier.increment();
        }

        expect(notifier.state.roundsCompleted, 0);
        expect(notifier.state.beadCount, 5);
        expect(notifier.state.sessionBeads, 5);
      });
    });

    group('Continuous mode', () {
      test('roundsCompleted never increments', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.continuous);

        for (int i = 0; i < 200; i++) {
          notifier.increment();
        }

        expect(notifier.state.roundsCompleted, 0);
        expect(notifier.state.beadCount, 200);
        expect(notifier.state.sessionBeads, 200);
      });
    });

    group('setMode', () {
      test('resets state when switching modes', () {
        final notifier = CounterNotifier();

        for (int i = 0; i < 50; i++) {
          notifier.increment();
        }
        expect(notifier.state.beadCount, 50);
        expect(notifier.state.sessionBeads, 50);

        notifier.setMode(CounterMode.short);

        expect(notifier.state.mode, CounterMode.short);
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.roundsCompleted, 0);
        expect(notifier.state.sessionBeads, 0);
      });

      test('does nothing if mode is already the same', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 3; i++) {
          notifier.increment();
        }

        notifier.setMode(CounterMode.short);
        expect(notifier.state.beadCount, 3);
        expect(notifier.state.sessionBeads, 3);
      });
    });

    group('loadMode', () {
      test('preserves session data while changing mode', () {
        final notifier = CounterNotifier();

        for (int i = 0; i < 10; i++) {
          notifier.increment();
        }
        expect(notifier.state.beadCount, 10);

        notifier.loadMode(CounterMode.short);

        expect(notifier.state.mode, CounterMode.short);
        expect(notifier.state.beadCount, 10);
        expect(notifier.state.sessionBeads, 10);
      });
    });

    group('decrement', () {
      test('decreases beadCount and sessionBeads', () {
        final notifier = CounterNotifier();
        notifier.setMode(CounterMode.short);

        for (int i = 0; i < 5; i++) {
          notifier.increment();
        }

        notifier.decrement();
        expect(notifier.state.beadCount, 4);
        expect(notifier.state.sessionBeads, 4);
      });

      test('does not go below 0', () {
        final notifier = CounterNotifier();

        notifier.decrement();
        expect(notifier.state.beadCount, 0);
        expect(notifier.state.sessionBeads, 0);
      });
    });
  });
}
