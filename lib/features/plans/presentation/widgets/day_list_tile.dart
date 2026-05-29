import 'package:flutter/material.dart';
import '../../../../core/database/database.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrentDay
            ? const Color(0xFFFF8400).withOpacity(0.08)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrentDay
              ? const Color(0xFFFF8400)
              : const Color(0xFFEEEEEE),
          width: isCurrentDay ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xFF4CAF50)
                    : isCurrentDay
                        ? const Color(0xFFFF8400)
                        : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isCurrentDay
                              ? Colors.white
                              : const Color(0xFF666666),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day $dayNumber',
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$gongDawName · ${planDay.targetRounds} rounds',
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrentDay)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8400),
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
      ),
    );
  }
}
