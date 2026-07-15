import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/localization/providers/locale_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../counter/providers/counter_provider.dart';

enum LanguageOptions { english, burmese }

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _pageController = PageController();
  bool _saving = false;
  CounterMode _selectedMode = CounterMode.standard;
  LanguageOptions _selectedLanguage = LanguageOptions.english;

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToModeSelection() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final colors = context.colors;
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.nameEmptyError),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: TextStyle(color: colors.primary),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);

    final dao = ref.read(userInfoDaoProvider);
    final now = DateTime.now();
    await dao.upsertUser(
      UserInfo(
        id: 1,
        name: name,
        rankTitle: 'Novice Chanter',
        defaultMode: _selectedMode.name,
        streakDays: 0,
        totalLifetimeBeads: 0,
        totalLifetimeRounds: 0,
        counterRounds: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    ref.read(counterProvider.notifier).setMode(_selectedMode);
    ref.invalidate(userInfoProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [_buildNamePage(), _buildModePage()],
      ),
    );
  }

  Widget _buildNamePage() {
    final colors = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<LanguageOptions>(
                  value: _selectedLanguage,
                  onChanged: (LanguageOptions? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                      if (newValue == LanguageOptions.burmese) {
                        ref.read(localeProvider.notifier).setLocale(const Locale('my'));
                      } else {
                        ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                      }
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: LanguageOptions.english,
                      child: Text(AppLocalizations.of(context)!.english),
                    ),
                    DropdownMenuItem(
                      value: LanguageOptions.burmese,
                      child: Text(AppLocalizations.of(context)!.burmese),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.welcomeTo,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 20,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: colors.foreground,
              ),
            ),
            const SizedBox(height: 36),
            Text(
              AppLocalizations.of(context)!.enterNamePrompt,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.nameHint,
                filled: true,
                fillColor: colors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colors.primary,
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 18,
                color: colors.foreground,
              ),
              onSubmitted: (_) => _goToModeSelection(),
              maxLength: 50,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _goToModeSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.foreground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.start,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModePage() {
    final colors = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(flex: 4),
            Text(
              AppLocalizations.of(context)!.selectMode,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.selectModeSubtitle,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                color: colors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
            _ModeOption(
              label: AppLocalizations.of(context)!.standardMode,
              description: AppLocalizations.of(
                context,
              )!.modeStandardDescription,
              isSelected: _selectedMode == CounterMode.standard,
              onTap: () => setState(() => _selectedMode = CounterMode.standard),
            ),
            const SizedBox(height: 12),
            _ModeOption(
              label: AppLocalizations.of(context)!.shortMode,
              description: AppLocalizations.of(context)!.modeShortDescription,
              isSelected: _selectedMode == CounterMode.short,
              onTap: () => setState(() => _selectedMode = CounterMode.short),
            ),
            const SizedBox(height: 12),
            _ModeOption(
              label: AppLocalizations.of(context)!.continuousMode,
              description: AppLocalizations.of(
                context,
              )!.modeContinuousDescription,
              isSelected: _selectedMode == CounterMode.continuous,
              onTap: () =>
                  setState(() => _selectedMode = CounterMode.continuous),
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.foreground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.foreground,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.start,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeOption({
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? colors.primary
                      : colors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.circle,
                        size: 10,
                        color: colors.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colors.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      color: colors.mutedForeground,
                    ),
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
