import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../counter/providers/counter_provider.dart';

class ActionButtons extends ConsumerWidget {
  final VoidCallback? onSave;
  final VoidCallback onReset;

  const ActionButtons({super.key, required this.onSave, required this.onReset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final isPlanActive = counterState.isTodayPlanActive;
    final canSave = counterState.sessionBeads > 0 && !isPlanActive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isPlanActive)
          _ActionButton(
            icon: Icons.check,
            label: AppLocalizations.of(context)!.save,
            enabled: canSave,
            onTap: canSave ? onSave : null,
          ),
        if (!isPlanActive) const SizedBox(height: 12),
        _ActionButton(
          icon: Icons.refresh,
          label: AppLocalizations.of(context)!.reset,
          enabled: true,
          onTap: onReset,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled ? const Color(0xFF111111) : const Color(0xFFBBBBBB);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF000000).withAlpha(13),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
