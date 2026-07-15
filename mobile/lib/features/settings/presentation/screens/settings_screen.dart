import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/localization/providers/locale_provider.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../counter/providers/counter_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentMode = ref.watch(counterProvider.select((s) => s.mode));
    final currentThemeMode = ref.watch(themeModeProvider);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.foreground,
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
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  currentMode.label,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    color: colors.foreground,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => _changeMode(context, ref),
                  child: Text(
                    AppLocalizations.of(context)!.changeMode,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Theme',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _ThemeOption(
                    label: 'Light',
                    icon: Icons.light_mode_rounded,
                    isSelected: currentThemeMode == ThemeMode.light,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _ThemeOption(
                    label: 'Dark',
                    icon: Icons.dark_mode_rounded,
                    isSelected: currentThemeMode == ThemeMode.dark,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _ThemeOption(
                    label: 'System default',
                    icon: Icons.settings_rounded,
                    isSelected: currentThemeMode == ThemeMode.system,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.mutedForeground,
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

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colors.foreground),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: colors.foreground,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_rounded,
                color: colors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _ModeBottomSheet extends StatelessWidget {
  final CounterMode currentMode;

  const _ModeBottomSheet({required this.currentMode});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectMode,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.foreground,
            ),
          ),
          const SizedBox(height: 16),
          ...CounterMode.values.map(
            (mode) => ListTile(
              title: Text(
                mode.label,
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  color: colors.foreground,
                ),
              ),
              trailing: mode == currentMode
                  ? Icon(
                      Icons.check_rounded,
                      color: colors.primary,
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
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: colors.foreground,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_rounded,
                color: colors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
