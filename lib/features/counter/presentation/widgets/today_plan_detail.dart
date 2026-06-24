import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class TodayPlanDetail extends ConsumerWidget {
  const TodayPlanDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);
    final planName = state.planName ?? '';
    final beadsPerRound = state.planBeadsPerRound ?? 0;
    final targetRounds = state.planTargetRounds ?? 0;
    final completedRounds = state.roundsCompleted;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7E8E5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(
            planName,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!
                .beadsPerRound(beadsPerRound, targetRounds),
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedRounds / $targetRounds',
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8400),
            ),
          ),
        ],
      ),
    );
  }
}
