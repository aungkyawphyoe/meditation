import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class TapToCount extends ConsumerWidget {
  const TapToCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(counterProvider.select((s) => s.mode));
    final isCompact = ref.watch(
      counterProvider.select((s) => s.isTodayPlanActive),
    );
    final circleSize = isCompact ? 150.0 : 200.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => ref.read(counterProvider.notifier).increment(),
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withAlpha(13),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.tapToCount,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8400).withAlpha(25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            mode.label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFF8400),
            ),
          ),
        ),
      ],
    );
  }
}
