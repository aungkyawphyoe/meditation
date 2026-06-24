import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/localization/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F0),
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
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
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
                color: Color(0xFF111111),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: Color(0xFFFF8400),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
