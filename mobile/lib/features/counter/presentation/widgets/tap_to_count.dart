import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/theme/app_theme.dart';

class TapToCount extends ConsumerWidget {
  const TapToCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(counterProvider.select((s) => s.mode));
    final colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => ref.read(counterProvider.notifier).increment(),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: colors.card,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors.foreground.withAlpha(13),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.tapToCount,
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: colors.mutedForeground,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AppBadge.mode(text: mode.label),
      ],
    );
  }
}
