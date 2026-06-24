import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class TapToCount extends ConsumerWidget {
  const TapToCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(counterProvider.notifier).increment(),
      child: Container(
        width: 240,
        height: 240,
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
    );
  }
}
