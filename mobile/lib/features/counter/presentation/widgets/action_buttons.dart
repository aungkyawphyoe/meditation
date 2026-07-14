import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/app_button.dart';

class ActionButtons extends ConsumerWidget {
  final VoidCallback onReset;

  const ActionButtons({super.key, required this.onReset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppIconCircleButton(
      icon: Icons.refresh,
      label: AppLocalizations.of(context)!.reset,
      enabled: true,
      onTap: onReset,
    );
  }
}
