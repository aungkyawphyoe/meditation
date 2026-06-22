import 'package:flutter/material.dart';
import '../../../../core/database/database.dart';

class BeadPlanCard extends StatelessWidget {
  final BeadPlan plan;
  final VoidCallback onTap;

  const BeadPlanCard({super.key, required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.isPredefined ? 'Predefined' : 'Custom',
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFF8400),
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
                  color: Color(0xFF111111),
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
                  color: Color(0xFF666666),
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
        ),
      ),
    );
  }
}
