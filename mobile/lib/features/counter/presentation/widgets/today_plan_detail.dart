import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';

class TodayPlanDetail extends ConsumerWidget {
  const TodayPlanDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);
    final planName = state.planName ?? '';
    final beadsPerRound = state.planBeadsPerRound ?? 0;
    final targetRounds = state.planTargetRounds ?? 0;
    final completedRounds = state.roundsCompleted;
    final colors = context.colors;

    return AppCard(
      backgroundColor: colors.secondary,
      boxShadow: const [],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            planName,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.foreground,
            ),
          ),
          const SizedBox(height: 2),
          AppLabel(
            text: AppLocalizations.of(context)!.beadsPerRound(
              beadsPerRound,
              targetRounds,
            ),
            fontSize: 11,
          ),
          const SizedBox(height: 4),
          Text(
            '$completedRounds / $targetRounds',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
