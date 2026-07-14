import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/localization/providers/locale_provider.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../counter/providers/counter_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentMode = ref.watch(counterProvider.select((s) => s.mode));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.foreground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.currentMode,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedForeground,
              ),
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  currentMode.label,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    color: AppColors.foreground,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => _changeMode(context, ref),
                  child: Text(
                    AppLocalizations.of(context)!.changeMode,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedForeground,
              ),
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _LanguageOption(
                    label: AppLocalizations.of(context)!.english,
                    isSelected: currentLocale.languageCode == 'en',
                    onTap: () => ref
                        .read(localeProvider.notifier)
                        .setLocale(const Locale('en')),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _LanguageOption(
                    label: AppLocalizations.of(context)!.burmese,
                    isSelected: currentLocale.languageCode == 'my',
                    onTap: () => ref
                        .read(localeProvider.notifier)
                        .setLocale(const Locale('my')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeMode(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<CounterMode>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _ModeBottomSheet(
        currentMode: ref.read(counterProvider.select((s) => s.mode)),
      ),
    );
    if (result != null) {
      ref.read(counterProvider.notifier).setMode(result);
      final dao = ref.read(userInfoDaoProvider);
      await dao.updateDefaultMode(result.name);
    }
  }
}

class _ModeBottomSheet extends StatelessWidget {
  final CounterMode currentMode;

  const _ModeBottomSheet({required this.currentMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectMode,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 16),
          ...CounterMode.values.map(
            (mode) => ListTile(
              title: Text(
                mode.label,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  color: AppColors.foreground,
                ),
              ),
              trailing: mode == currentMode
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.primary,
                      size: 20,
                    )
                  : null,
              onTap: () => Navigator.pop(context, mode),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: AppColors.foreground,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
