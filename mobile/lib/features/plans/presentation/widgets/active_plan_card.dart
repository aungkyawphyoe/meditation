import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';

class ActivePlanCard extends ConsumerWidget {
  final BeadPlan plan;
  final UserPlanProgress progress;
  final int totalDays;
  final PlanDay? currentDayDetail;
  final String currentGongDawName;
  final String? gongDawMeaning;
  final VoidCallback onCompleteDay;
  final VoidCallback onCompletePlan;
  final VoidCallback? onStopPlan;

  const ActivePlanCard({
    super.key,
    required this.plan,
    required this.progress,
    required this.totalDays,
    required this.currentDayDetail,
    required this.currentGongDawName,
    this.gongDawMeaning,
    required this.onCompleteDay,
    required this.onCompletePlan,
    this.onStopPlan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    if (totalDays == 0) return const SizedBox.shrink();
    final isLastDay = progress.currentDay > totalDays;
    final dayIndex = isLastDay ? totalDays : progress.currentDay;

    return AppCard(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      gradient: const LinearGradient(
        colors: [Color(0xFFFF8400), Color(0xFFFFB347)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: colors.primary.withValues(alpha:0.3),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.activePlan,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              _badge('${plan.beadsPerRound} beads'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            plan.title,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.dayOfTotal(dayIndex, totalDays),
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '${((dayIndex / totalDays) * 100).toInt()}%',
                style: const TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: dayIndex / totalDays,
              backgroundColor: Colors.white.withValues(alpha:0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          if (currentDayDetail != null && !isLastDay) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.todaysGongDaw,
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha:0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentGongDawName,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        if (gongDawMeaning != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            gongDawMeaning!,
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha:0.6),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _badge(
                        AppLocalizations.of(context)!.dayOfTotal(
                          dayIndex,
                          totalDays,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.roundsCount(
                          currentDayDetail!.targetRounds,
                        ),
                        style: TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha:0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: isLastDay ? onCompletePlan : onCompleteDay,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                isLastDay
                    ? AppLocalizations.of(context)!.completePlan
                    : AppLocalizations.of(context)!.markDayComplete,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (onStopPlan != null) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: onStopPlan,
                icon: const Icon(Icons.stop_rounded, size: 18),
                label: Text(AppLocalizations.of(context)!.stopPlan),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withValues(alpha:0.8),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white.withValues(alpha:0.3)),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
