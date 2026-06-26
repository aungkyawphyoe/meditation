import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../counter/providers/counter_provider.dart';

class CounterDisplay extends ConsumerWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beadCount = ref.watch(counterProvider.select((s) => s.beadCount));
    final isPlanActive = ref.watch(
      counterProvider.select((s) => s.isTodayPlanActive),
    );
    return Text(
      beadCount.toString().padLeft(3, '0'),
      style: TextStyle(
        fontFamily: 'JetBrains Mono',
        fontSize: isPlanActive ? 56 : 80,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF111111),
      ),
      textAlign: TextAlign.center,
    );
  }
}
