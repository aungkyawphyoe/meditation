import 'package:flutter_test/flutter_test.dart';
import 'package:meditation/core/utils/rank_utils.dart';

void main() {
  group('rankForRounds', () {
    test('returns Novice Chanter for 0 rounds', () {
      expect(rankForRounds(0), 'Novice Chanter');
    });

    test('returns Novice Chanter for 9 rounds', () {
      expect(rankForRounds(9), 'Novice Chanter');
    });

    test('returns Aspiring Devotee at 10 rounds', () {
      expect(rankForRounds(10), 'Aspiring Devotee');
    });

    test('returns Steady Practitioner at 50 rounds', () {
      expect(rankForRounds(50), 'Steady Practitioner');
    });

    test('returns Devoted Chanter at 100 rounds', () {
      expect(rankForRounds(100), 'Devoted Chanter');
    });

    test('returns Faithful Reciter at 250 rounds', () {
      expect(rankForRounds(250), 'Faithful Reciter');
    });

    test('returns Venerable Chanter at 500 rounds', () {
      expect(rankForRounds(500), 'Venerable Chanter');
    });

    test('returns Senior Devotee at 1000 rounds', () {
      expect(rankForRounds(1000), 'Senior Devotee');
    });

    test('returns Noble Chanter at 2500 rounds', () {
      expect(rankForRounds(2500), 'Noble Chanter');
    });

    test('returns Elder Devotee at 5000 rounds', () {
      expect(rankForRounds(5000), 'Elder Devotee');
    });

    test('returns Master Chanter at 10000 rounds', () {
      expect(rankForRounds(10000), 'Master Chanter');
    });

    test('returns Master Chanter for very high round counts', () {
      expect(rankForRounds(50000), 'Master Chanter');
    });

    test('returns correct rank for boundary value 49', () {
      expect(rankForRounds(49), 'Aspiring Devotee');
    });

    test('returns correct rank for boundary value 99', () {
      expect(rankForRounds(99), 'Steady Practitioner');
    });
  });
}
