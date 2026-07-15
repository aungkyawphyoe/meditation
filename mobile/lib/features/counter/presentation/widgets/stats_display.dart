import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';

class StatsDisplay extends ConsumerWidget {
  const StatsDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rounds = ref.watch(counterProvider.select((s) => s.roundsCompleted));
    final sessionBeads = ref.watch(
      counterProvider.select((s) => s.sessionBeads),
    );
    final colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatNumber(rounds + (sessionBeads > 0 ? 0 : 0)),
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 24,
            color: colors.foreground,
          ),
        ),
        const SizedBox(height: 4),
        AppLabel(text: AppLocalizations.of(context)!.totalRounds, fontSize: 10, fontWeight: FontWeight.w600),
        AppLabel(text: AppLocalizations.of(context)!.beads(sessionBeads), fontSize: 10, color: colors.primary),
      ],
    );
  }

  String formatNumber(int n) {
    if (n >= 1000) {
      final rem = (n % 1000).toString().padLeft(3, '0');
      return '${n ~/ 1000},$rem';
    }
    return n.toString();
  }
}
