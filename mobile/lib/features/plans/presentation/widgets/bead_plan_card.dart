import 'package:flutter/material.dart';
import '../../../../core/database/database.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';

class BeadPlanCard extends StatelessWidget {
  final BeadPlan plan;
  final VoidCallback onTap;

  const BeadPlanCard({super.key, required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard.white(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.isPredefined ? 'Predefined' : 'Custom',
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            plan.title,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${plan.beadsPerRound} beads/round',
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.mutedForeground,
            ),
          ),
          const Spacer(),
          if (plan.description.isNotEmpty)
            Text(
              plan.description,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF888888),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
