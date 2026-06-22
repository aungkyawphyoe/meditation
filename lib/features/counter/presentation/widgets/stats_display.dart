import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../counter/providers/counter_provider.dart';

class StatsDisplay extends ConsumerWidget {
  const StatsDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rounds = ref.watch(counterProvider.select((s) => s.roundsCompleted));
    final sessionBeads = ref.watch(
      counterProvider.select((s) => s.sessionBeads),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatNumber(rounds + (sessionBeads > 0 ? 0 : 0)),
          style: const TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 24,
            color: Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'TOTAL ROUNDS',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Color(0xFF666666),
          ),
        ),
        Text(
          '+$sessionBeads beads',
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 10,
            color: Color(0xFFFF8400),
          ),
        ),
      ],
    );
  }

  String formatNumber(int n) {
    if (n >= 1000) {
      final rem = (n % 1000).toString().padLeft(3, '0');
      return '${n ~/ 1000},$rem';
    }
    return n.toString();
  }
}
