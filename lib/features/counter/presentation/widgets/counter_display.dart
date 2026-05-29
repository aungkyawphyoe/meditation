import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../counter/providers/counter_provider.dart';

class CounterDisplay extends ConsumerWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beadCount = ref.watch(counterProvider.select((s) => s.beadCount));
    return Text(
      beadCount.toString().padLeft(3, '0'),
      style: const TextStyle(
        fontFamily: 'JetBrains Mono',
        fontSize: 80,
        fontWeight: FontWeight.w700,
        color: Color(0xFF111111),
      ),
      textAlign: TextAlign.center,
    );
  }
}
