import 'package:flutter/material.dart';
import '../../../../core/database/database.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/theme/app_theme.dart';

class DayListTile extends StatelessWidget {
  final int dayNumber;
  final PlanDay planDay;
  final String gongDawName;
  final bool isCurrentDay;
  final bool isCompleted;

  const DayListTile({
    super.key,
    required this.dayNumber,
    required this.planDay,
    required this.gongDawName,
    required this.isCurrentDay,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accentColor = isCompleted
        ? const Color(0xFF4CAF50)
        : isCurrentDay
        ? colors.primary
        : colors.secondary;

    return AppCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      backgroundColor: isCurrentDay
          ? colors.primary.withValues(alpha:0.08)
          : colors.card,
      border: Border.all(
        color: isCurrentDay
            ? colors.primary
            : colors.border,
        width: isCurrentDay ? 1.5 : 1,
      ),
      child: Row(
        children: [
          AppDayIndicator(
            number: dayNumber,
            size: 36,
            borderRadius: 8,
            backgroundColor: accentColor,
            textColor: (isCompleted || isCurrentDay)
                ? Colors.white
                : colors.mutedForeground,
          ),
          if (isCompleted)
            const Center(
              child: Icon(Icons.check, color: Colors.white, size: 18),
            ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day $dayNumber',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$gongDawName · ${planDay.targetRounds} rounds',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrentDay)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Now',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
