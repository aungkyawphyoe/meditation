# Dual Language Support (English / Burmese) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add English and Burmese language support with a language toggle on a new Settings screen, using Flutter's official ARB-based localization.

**Architecture:** Flutter's `flutter_localizations` + `intl` packages with ARB files for translations. A Riverpod `StateProvider<Locale>` manages the current locale, persisted via `shared_preferences`. The `MaterialApp` watches the locale provider and rebuilds with the new locale.

**Tech Stack:** Flutter SDK (`flutter_localizations`), `intl`, `shared_preferences`, `flutter_riverpod`, ARB files with `flutter gen-l10n`.

## Global Constraints

- Default language: English (`Locale('en')`)
- Supported locales: English (`en`) and Burmese/Myanmar (`my`)
- UI chrome strings only — database Buddhist content (gong/daw names, plan titles) remains as-is
- Language persists via `shared_preferences` key `selected_locale`
- Follow existing code patterns: hand-written Riverpod providers, white cards, orange accent (#FF8400)

## File Structure

### New Files

| File | Purpose |
|---|---|
| `l10n.yaml` | gen-l10n configuration |
| `lib/l10n/app_en.arb` | English translation strings (template) |
| `lib/l10n/app_my.arb` | Burmese translation strings |
| `lib/core/localization/providers/locale_provider.dart` | Locale Riverpod state + persistence |
| `lib/features/settings/presentation/screens/settings_screen.dart` | Language toggle UI |

### Modified Files

| File | Changes |
|---|---|
| `pubspec.yaml` | Add `flutter_localizations`, `intl`, `shared_preferences` deps; add `generate: true` |
| `lib/app.dart` | Add localization delegates, supported locales, watch locale provider |
| `lib/features/profile/presentation/screens/profile_screen.dart` | Add settings button, localize strings |
| `lib/features/home/presentation/screens/home_shell.dart` | Localize nav labels |
| `lib/features/counter/presentation/screens/counter_screen.dart` | Localize strings |
| `lib/features/counter/presentation/widgets/mode_selector.dart` | Localize mode labels |
| `lib/features/counter/presentation/widgets/tap_to_count.dart` | Localize "TAP TO COUNT" |
| `lib/features/counter/presentation/widgets/today_plan_detail.dart` | Localize strings |
| `lib/features/counter/presentation/widgets/stats_display.dart` | Localize "TOTAL ROUNDS", "beads" |
| `lib/features/counter/presentation/widgets/completion_overlay.dart` | Localize completion text |
| `lib/features/plans/presentation/screens/plans_screen.dart` | Localize strings |
| `lib/features/plans/presentation/screens/plan_detail_screen.dart` | Localize strings |
| `lib/features/plans/presentation/screens/add_plan_screen.dart` | Localize strings |
| `lib/features/plans/presentation/widgets/active_plan_card.dart` | Localize strings |
| `lib/features/onboarding/presentation/screens/onboarding_screen.dart` | Localize strings |
| `test/widget_test.dart` | Wrap test widgets with AppLocalizations |

---

### Task 1: Add Dependencies and gen-l10n Config

**Files:**
- Modify: `pubspec.yaml`
- Create: `l10n.yaml`

**Interfaces:**
- Consumes: none
- Produces: `flutter gen-l10n` generates `lib/core/localization/app_localizations.dart`

- [ ] **Step 1: Update pubspec.yaml**

Add `flutter_localizations`, `intl`, `shared_preferences` to dependencies and `generate: true` under `flutter:`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  cupertino_icons: ^1.0.8
  flutter_riverpod: ^2.6.1
  drift: ^2.26.0
  drift_flutter: ^0.2.4
  sqlite3_flutter_libs: ^0.5.28
  path_provider: ^2.1.5
  path: ^1.9.1
  intl: any
  shared_preferences: ^2.3.4
```

And under the `flutter:` section, add:

```yaml
flutter:
  generate: true
  uses-material-design: true
```

- [ ] **Step 2: Create l10n.yaml**

Create `l10n.yaml` at project root:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

- [ ] **Step 3: Run flutter pub get**

Run: `flutter pub get`
Expected: Success

- [ ] **Step 4: Commit**

```bash
git add pubspec.yaml l10n.yaml pubspec.lock
git commit -m "chore: add i18n dependencies and gen-l10n config"
```

---

### Task 2: Create ARB Translation Files

**Files:**
- Create: `lib/l10n/app_en.arb`
- Create: `lib/l10n/app_my.arb`

**Interfaces:**
- Consumes: none
- Produces: Translation keys used by `AppLocalizations.of(context)!.keyName` in all subsequent tasks

- [ ] **Step 1: Create lib/l10n/app_en.arb**

```json
{
  "@@locale": "en",
  "appTitle": "Meditation",
  "profile": "Profile",
  "plans": "Plans",
  "counter": "Counter",
  "settings": "Settings",
  "totalPlans": "Total Plans",
  "rounds": "Rounds",
  "myPlans": "My Plans",
  "noPlansYet": "No plans yet",
  "daysStreak": "{count} Days Streak",
  "@daysStreak": {
    "placeholders": {
      "count": "int"
    }
  },
  "active": "Active",
  "failed": "Failed",
  "success": "Success",
  "dayOfTotal": "Day {current} of {total}",
  "@dayOfTotal": {
    "placeholders": {
      "current": "int",
      "total": "int"
    }
  },
  "daysCount": "{count} Days",
  "@daysCount": {
    "placeholders": {
      "count": "int"
    }
  },
  "subscribed": "Subscribed",
  "list": "List",
  "noActivePlan": "No Active Plan",
  "noActivePlanSubtitle": "Browse the List tab to find\na plan that speaks to you",
  "noPlansYetTab": "No plans yet. Tap + to create one.",
  "stopPlan": "Stop Plan",
  "stopPlanConfirm": "Are you sure you want to stop this plan? It will be marked as failed.",
  "cancel": "Cancel",
  "stop": "Stop",
  "days": "Days",
  "beadsPerRound": "{count} beads per round · {days} days",
  "@beadsPerRound": {
    "placeholders": {
      "count": "int",
      "days": "int"
    }
  },
  "planDetails": "Plan Details",
  "editPlan": "Edit Plan",
  "edit": "Edit",
  "delete": "Delete",
  "deletePlan": "Delete Plan",
  "deletePlanConfirm": "Are you sure you want to delete this plan? This action cannot be undone.",
  "planNotFound": "Plan not found",
  "predefined": "PREDEFINED",
  "cannotEditActivePlan": "Cannot edit an active plan",
  "planUpdated": "Plan updated",
  "planMustHaveAtLeastOneDay": "Plan must have at least one day",
  "addDay": "Add Day",
  "day": "Day",
  "gongDawName": "Gong/Daw Name",
  "gongDawDetail": "Gong/Daw Detail",
  "targetRounds": "Target Rounds",
  "cancelEdit": "Cancel",
  "saveChanges": "Save Changes",
  "startThisPlan": "Start This Plan",
  "completePlan": "Complete Plan",
  "completed": "Completed",
  "completePlanConfirm": "Are you sure you want to mark this plan as complete?",
  "complete": "Complete",
  "planActivated": "Plan activated!",
  "planCompletedMsg": "Plan completed! Great work.",
  "dayCompleteMsg": "Day {count} complete!",
  "@dayCompleteMsg": {
    "placeholders": {
      "count": "int"
    }
  },
  "activePlan": "Active Plan",
  "todaysGongDaw": "Today's Gong/Daw",
  "roundsCount": "{count} rounds",
  "@roundsCount": {
    "placeholders": {
      "count": "int"
    }
  },
  "markDayComplete": "Mark Day Complete",
  "newPlan": "New Plan",
  "title": "Title",
  "titleHint": "e.g., 21-Day Challenge",
  "description": "Description",
  "descriptionHint": "Optional description",
  "beadsPerRoundLabel": "Beads per Round",
  "tapToAddDay": "Tap \"Add Day\" to create your plan schedule",
  "savePlan": "Save Plan",
  "requiredField": "Required",
  "addAtLeastOneDay": "Add at least one day",
  "planCreated": "Plan created!",
  "welcomeTo": "Welcome to",
  "enterNamePrompt": "Enter your name to get started",
  "nameHint": "Your name",
  "start": "Start",
  "standardMode": "Standard (108)",
  "shortMode": "Short (8)",
  "continuousMode": "Continuous",
  "tapToCount": "TAP TO COUNT",
  "totalRounds": "TOTAL ROUNDS",
  "beads": "+{count} beads",
  "@beads": {
    "placeholders": {
      "count": "int"
    }
  },
  "todayPlanComplete": "Today's Plan\nComplete!",
  "allRoundsCompleted": "All rounds completed",
  "exitTodayPlan": "Exit Today Plan",
  "startTodayPlan": "Start Today Plan",
  "saveSession": "Save Session?",
  "saveSessionContent": "You have {count} bead(s) in this session.",
  "@saveSessionContent": {
    "placeholders": {
      "count": "int"
    }
  },
  "discard": "Discard",
  "save": "Save",
  "errorLoadingApp": "Error loading app",
  "settingsSubtitle": "Language",
  "language": "Language",
  "english": "English",
  "burmese": "မြန်မာ",
  "youAlreadyHaveActivePlan": "You already have an active plan. Complete or pause it first."
}
```

- [ ] **Step 2: Create lib/l10n/app_my.arb**

```json
{
  "@@locale": "my",
  "appTitle": "တရားအားထုတ်ခြင်း",
  "profile": "ပရိုဖိုင်",
  "plans": "အစီအစဉ်များ",
  "counter": "ရေတွက်ခြင်း",
  "settings": "ဆက်ညှိနှိုင်းခြင်း",
  "totalPlans": "စုစုပေါင်း အစီအစဉ်",
  "rounds": "ပတ်လည်",
  "myPlans": "ကျွန်ုပ်၏ အစီအစဉ်များ",
  "noPlansYet": "အစီအစဉ် မရှိသေးပါ",
  "daysStreak": "ရက်ဆက် {count} ရက်",
  "@daysStreak": {
    "placeholders": {
      "count": "int"
    }
  },
  "active": "လက်ရှိ",
  "failed": "မအောင်မြင်",
  "success": "အောင်မြင်",
  "dayOfTotal": "နေ့ {current} / {total}",
  "@dayOfTotal": {
    "placeholders": {
      "current": "int",
      "total": "int"
    }
  },
  "daysCount": "ရက် {count}",
  "@daysCount": {
    "placeholders": {
      "count": "int"
    }
  },
  "subscribed": "စာရင်းသွင်းပြီး",
  "list": "စာရင်း",
  "noActivePlan": "လက်ရှိ အစီအစဉ် မရှိပါ",
  "noActivePlanSubtitle": "စာရင်း တစ်ခုရှာဖွေရန်\nList tab ကို ကြည့်ပါ",
  "noPlansYetTab": "အစီအစဉ် မရှိသေးပါ။ + ကိုနှိပ်ပြီး ဖန်တီးပါ။",
  "stopPlan": "အစီအစဉ် ရပ်ရန်",
  "stopPlanConfirm": "ဤအစီအစဉ်ကို ရပ်တန့်လိုပါသလား? ၎င်းကို မအောင်မြင်ဟု သတ်မှတ်မည်ဖြစ်ပါသည်။",
  "cancel": "ပယ်ဖျက်",
  "stop": "ရပ်",
  "days": "ရက်",
  "beadsPerRound": "ပတ်လည်တစ်ခုလျှင် များ {count} ခု · ရက် {days} ရက်",
  "@beadsPerRound": {
    "placeholders": {
      "count": "int",
      "days": "int"
    }
  },
  "planDetails": "အစီအစဉ် အသေးစိတ်",
  "editPlan": "အစီအစဉ် ပြင်ဆင်ရန်",
  "edit": "ပြင်ဆင်",
  "delete": "ဖျက်",
  "deletePlan": "အစီအစဉ် ဖျက်ရန်",
  "deletePlanConfirm": "ဤအစီအစဉ်ကို ဖျက်လိုပါသလား? ၎င်းလုပ်ဆောင်ချက်ကို ပြန်လည်ပြင်ဆင်၍ မရတော့ပါ။",
  "planNotFound": "အစီအစဉ် ရှာမတွေ့ပါ",
  "predefined": "ကြိုတင်သတ်မှတ်ထား",
  "cannotEditActivePlan": "လက်ရှိ အစီအစဉ်ကို ပြင်ဆင်၍ မရပါ",
  "planUpdated": "အစီအစဉ် ပြင်ဆင်ပြီးပါပြီ",
  "planMustHaveAtLeastOneDay": "အစီအစဉ်တွင် ရက်တစ်ရက်အနည်းဆုံး ရှိရပါမည်",
  "addDay": "ရက်ထည့်ရန်",
  "day": "ရက်",
  "gongDawName": "ဂုဏ်တော် အမည်",
  "gongDawDetail": "ဂုဏ်တော် အသေးစိတ်",
  "targetRounds": "ပတ်လည် ရည်မှန်းချက်",
  "cancelEdit": "ပယ်ဖျက်",
  "saveChanges": "ပြောင်းလဲမှုများ သိမ်းဆည်းရန်",
  "startThisPlan": "ဤအစီအစဉ်ကို စတင်ရန်",
  "completePlan": "အစီအစဉ် ပြီးဆုံးရန်",
  "completed": "ပြီးဆုံးပါပြီ",
  "completePlanConfirm": "ဤအစီအစဉ်ကို ပြီးဆုံးအောင် သတ်မှတ်လိုပါသလား?",
  "complete": "ပြီးဆုံး",
  "planActivated": "အစီအစဉ် ဖွင့်လှစ်ပြီးပါပြီ!",
  "planCompletedMsg": "အစီအစဉ် ပြီးဆုံးပါပြီ! ကောင်းပါတယ်။",
  "dayCompleteMsg": "နေ့ {count} ပြီးဆုံးပါပြီ!",
  "@dayCompleteMsg": {
    "placeholders": {
      "count": "int"
    }
  },
  "activePlan": "လက်ရှိ အစီအစဉ်",
  "todaysGongDaw": "ယနေ့၏ ဂုဏ်တော်",
  "roundsCount": "ပတ်လည် {count} ပတ်",
  "@roundsCount": {
    "placeholders": {
      "count": "int"
    }
  },
  "markDayComplete": "နေ့ကို ပြီးဆုံးအောင် သတ်မှတ်ရန်",
  "newPlan": "အစီအစဉ် အသစ်",
  "title": "ခေါင်းစဉ်",
  "titleHint": "ဥပမာ - ၂၁ ရက် စိန်ခေါ်မှု",
  "description": "ဖော်ပြချက်",
  "descriptionHint": "ဖော်ပြချက် (ရွေးချယ်စရာ)",
  "beadsPerRoundLabel": "ပတ်လည်တစ်ခုလျှင် များ",
  "tapToAddDay": "\"ရက်ထည့်ရန်\" ကို နှိပ်ပြီး သင်၏ အစီအစဉ်ကို ဖန်တီးပါ",
  "savePlan": "အစီအစဉ် သိမ်းဆည်းရန်",
  "requiredField": "ဖြည့်ရပါမည်",
  "addAtLeastOneDay": "ရက်တစ်ရက်အနည်းဆုံး ထည့်ပါ",
  "planCreated": "အစီအစဉ် ဖန်တီးပြီးပါပြီ!",
  "welcomeTo": "ကြိုဆိုပါတယ်",
  "enterNamePrompt": "စတင်ရန် သင်၏ အမည်ကို ထည့်ပါ",
  "nameHint": "သင်၏ အမည်",
  "start": "စတင်",
  "standardMode": "ပုံမှန် (108)",
  "shortMode": "တို (8)",
  "continuousMode": "ဆက်တိုက်",
  "tapToCount": "ရေတွက်ရန် နှိပ်ပါ",
  "totalRounds": "စုစုပေါင်း ပတ်လည်",
  "beads": "များ +{count} ခု",
  "@beads": {
    "placeholders": {
      "count": "int"
    }
  },
  "todayPlanComplete": "ယနေ့၏ အစီအစဉ်\nပြီးဆုံးပါပြီ!",
  "allRoundsCompleted": "ပတ်လည် အားလုံး ပြီးဆုံးပါပြီ",
  "exitTodayPlan": "ယနေ့၏ အစီအစဉ်မှ ထွက်ရန်",
  "startTodayPlan": "ယနေ့၏ အစီအစဉ် စတင်ရန်",
  "saveSession": "အပတ်ချင်းဆက် သိမ်းဆည်းမလား?",
  "saveSessionContent": "ဤအပတ်ချင်းဆက်တွင် များ {count} ခု ရှိပါသည်။",
  "discard": "ပယ်ဖျက်",
  "save": "သိမ်းဆည်း",
  "errorLoadingApp": "အက်ပ် ဖွင့်ရာတွင် အမှား",
  "settingsSubtitle": "ဘာသာစကား",
  "language": "ဘာသာစကား",
  "english": "English",
  "burmese": "မြန်မာ",
  "youAlreadyHaveActivePlan": "လက်ရှိ အစီအစဉ် ရှိပြီးသားဖြစ်ပါသည်။ ပြီးဆုံးအောင် သို့မဟုတ် ရပ်တန့်အောင် ဆောင်ရွက်ပါ။"
}
```

- [ ] **Step 3: Run flutter gen-l10n**

Run: `flutter gen-l10n`
Expected: Generates `lib/core/localization/app_localizations.dart` and related files without errors

- [ ] **Step 4: Commit**

```bash
git add lib/l10n/
git commit -m "feat: add English and Burmese ARB translation files"
```

---

### Task 3: Create Locale Provider

**Files:**
- Create: `lib/core/localization/providers/locale_provider.dart`

**Interfaces:**
- Consumes: `shared_preferences` package
- Produces: `localeProvider` (`StateProvider<Locale>`) used by `MaterialApp` and `SettingsScreen`

- [ ] **Step 1: Create locale_provider.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _localeKey = 'selected_locale';

final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) => LocaleNotifier());

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadPersistedLocale();
  }

  Future<void> _loadPersistedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code != null) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/localization/providers/locale_provider.dart
git commit -m "feat: add locale provider with shared_preferences persistence"
```

---

### Task 4: Update MaterialApp with Localization

**Files:**
- Modify: `lib/app.dart`

**Interfaces:**
- Consumes: `localeProvider` from Task 3, generated `AppLocalizations` from Task 2
- Produces: Localized MaterialApp used by all screens

- [ ] **Step 1: Update app.dart**

Replace the entire file content with:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/providers/app_database_providers.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/providers/locale_provider.dart';
import 'features/home/presentation/screens/home_shell.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Meditation',
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F3F0),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF8400),
          surface: Color(0xFFF2F3F0),
          onSurface: Color(0xFF111111),
        ),
        fontFamily: 'Geist',
      ),
      home: userAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => Scaffold(
          body: Center(
            child: Text(
              'Error loading app',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ),
        data: (user) {
          if (user == null) return const OnboardingScreen();
          if (user.name == 'Meditator' && user.totalLifetimeBeads == 0) {
            return const OnboardingScreen();
          }
          return const HomeShell();
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/app.dart
git commit -m "feat: integrate localization into MaterialApp"
```

---

### Task 5: Create Settings Screen

**Files:**
- Create: `lib/features/settings/presentation/screens/settings_screen.dart`

**Interfaces:**
- Consumes: `localeProvider` from Task 3
- Produces: `SettingsScreen` widget navigated to from ProfileScreen

- [ ] **Step 1: Create settings_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
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
```

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/settings/
git commit -m "feat: add Settings screen with language toggle"
```

---

### Task 6: Update Profile Screen

**Files:**
- Modify: `lib/features/profile/presentation/screens/profile_screen.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2, `SettingsScreen` from Task 5
- Produces: Localized profile screen with settings navigation

- [ ] **Step 1: Update profile_screen.dart**

Add imports and replace all hardcoded strings with `AppLocalizations.of(context)!.key` calls. Add a settings icon button in the header row.

Key changes:
1. Add imports for `AppLocalizations` and `SettingsScreen`
2. Replace `'Profile'` header with `AppLocalizations.of(context)!.profile`
3. Add settings icon button next to "Profile" title
4. Replace `'Total Plans'`, `'Rounds'`, `'My Plans'`, `'No plans yet'`
5. Replace `'${user.rankTitle} • ${user.streakDays} Days Streak'` with localized version
6. Replace status labels `'Active'`, `'Failed'`, `'Success'`
7. Replace `'Day ${plan.currentDay} of ${plan.totalDays}'` and `'${plan.totalDays} Days'`

Full replacement for the header Row (lines 51-64):

```dart
Row(
  children: [
    Text(
      AppLocalizations.of(context)!.profile,
      style: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Color(0xFF111111),
      ),
    ),
    const Spacer(),
    IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        );
      },
      icon: const Icon(
        Icons.settings_outlined,
        color: Color(0xFF666666),
        size: 24,
      ),
    ),
  ],
),
```

For the rank/streak text (line 103):

```dart
Text(
  '${user.rankTitle} • ${AppLocalizations.of(context)!.daysStreak(user.streakDays)}',
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    color: Color(0xFF666666),
  ),
),
```

For stat cards (lines 122, 128):

```dart
Expanded(
  child: _StatCard(
    label: AppLocalizations.of(context)!.totalPlans,
    value: formatNumber(plans),
  ),
),
const SizedBox(width: 12),
Expanded(
  child: _StatCard(
    label: AppLocalizations.of(context)!.rounds,
    value: formatNumber(rounds),
  ),
),
```

For "My Plans" section (line 137):

```dart
Text(
  AppLocalizations.of(context)!.myPlans,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF111111),
  ),
),
```

For empty state (line 151):

```dart
Text(
  AppLocalizations.of(context)!.noPlansYet,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    color: Color(0xFF666666),
  ),
),
```

For `_PlanCard` status labels (lines 237-244):

```dart
if (isActive) {
  statusLabel = AppLocalizations.of(context)!.active;
  statusColor = const Color(0xFFFF8400);
} else if (isFailed) {
  statusLabel = AppLocalizations.of(context)!.failed;
  statusColor = const Color(0xFFEF4444);
} else {
  statusLabel = AppLocalizations.of(context)!.success;
  statusColor = const Color(0xFF22C55E);
}
```

Note: `_PlanCard` needs to become `ConsumerWidget` to access `AppLocalizations`. Change `class _PlanCard extends StatelessWidget` to `class _PlanCard extends ConsumerWidget` and update the `build` method signature to include `WidgetRef ref`.

For days text (lines 246-248):

```dart
final daysText = isActive
    ? AppLocalizations.of(context)!.dayOfTotal(plan.currentDay, plan.totalDays)
    : AppLocalizations.of(context)!.daysCount(plan.totalDays);
```

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/profile/presentation/screens/profile_screen.dart
git commit -m "feat: localize Profile screen and add settings button"
```

---

### Task 7: Update Home Shell (Bottom Nav)

**Files:**
- Modify: `lib/features/home/presentation/screens/home_shell.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2
- Produces: Localized bottom navigation labels

- [ ] **Step 1: Update home_shell.dart**

Add import for `AppLocalizations`:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Change `HomeShell` from `ConsumerWidget` stays the same, but the `_TabItem` labels need to be passed from the parent. Since `_TabItem` is a `StatelessWidget` that receives labels as constructor params, we need to pass localized labels from `HomeShell.build`.

Replace the three `_TabItem` instances (lines 36-56) with:

```dart
_TabItem(
  icon: Icons.circle_outlined,
  activeIcon: Icons.circle,
  label: AppLocalizations.of(context)!.counter,
  isActive: currentTab == 0,
  onTap: () => ref.read(currentTabProvider.notifier).state = 0,
),
_TabItem(
  icon: Icons.calendar_today_outlined,
  activeIcon: Icons.calendar_today,
  label: AppLocalizations.of(context)!.plans,
  isActive: currentTab == 1,
  onTap: () => ref.read(currentTabProvider.notifier).state = 1,
),
_TabItem(
  icon: Icons.person_outline,
  activeIcon: Icons.person,
  label: AppLocalizations.of(context)!.profile,
  isActive: currentTab == 2,
  onTap: () => ref.read(currentTabProvider.notifier).state = 2,
),
```

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/home/presentation/screens/home_shell.dart
git commit -m "feat: localize bottom navigation labels"
```

---

### Task 8: Update Counter Screen and Widgets

**Files:**
- Modify: `lib/features/counter/presentation/screens/counter_screen.dart`
- Modify: `lib/features/counter/presentation/widgets/mode_selector.dart`
- Modify: `lib/features/counter/presentation/widgets/tap_to_count.dart`
- Modify: `lib/features/counter/presentation/widgets/today_plan_detail.dart`
- Modify: `lib/features/counter/presentation/widgets/stats_display.dart`
- Modify: `lib/features/counter/presentation/widgets/completion_overlay.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2
- Produces: Localized counter UI

- [ ] **Step 1: Update counter_screen.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace hardcoded strings:

Line 98 `'Exit Today Plan'` → `AppLocalizations.of(context)!.exitTodayPlan`
Line 98 `'Start Today Plan'` → `AppLocalizations.of(context)!.startTodayPlan`
Line 159 `'Save Session?'` → `AppLocalizations.of(context)!.saveSession`
Line 168 `'You have ${state.sessionBeads} bead(s) in this session.'` → `AppLocalizations.of(context)!.saveSessionContent(state.sessionBeads)`
Line 179 `'Discard'` → `AppLocalizations.of(context)!.discard`
Line 190 `'Save'` → `AppLocalizations.of(context)!.save`
Line 246 `'Meditation'` → `AppLocalizations.of(context)!.appTitle`

Note: The `_Header` class is a `StatelessWidget` — it needs to become `ConsumerWidget` or receive the title as a parameter. Simplest approach: pass the title from the parent `CounterScreen.build`:

Change `_Header()` to `_Header(title: AppLocalizations.of(context)!.appTitle)` and update `_Header` to accept a `title` parameter.

- [ ] **Step 2: Update mode_selector.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace mode labels (lines 24, 30, 35):

```dart
_ModeTab(
  label: AppLocalizations.of(context)!.standardMode,
  isActive: mode == CounterMode.standard,
  onTap: () => _handleModeChange(context, ref, CounterMode.standard),
),
_ModeTab(
  label: AppLocalizations.of(context)!.shortMode,
  isActive: mode == CounterMode.short,
  onTap: () => _handleModeChange(context, ref, CounterMode.short),
),
_ModeTab(
  label: AppLocalizations.of(context)!.continuousMode,
  isActive: mode == CounterMode.continuous,
  onTap: () => _handleModeChange(context, ref, CounterMode.continuous),
),
```

- [ ] **Step 3: Update tap_to_count.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace `'TAP TO COUNT'` (line 29):

```dart
Text(
  AppLocalizations.of(context)!.tapToCount,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: Color(0xFF666666),
  ),
),
```

- [ ] **Step 4: Update today_plan_detail.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace the beads/rounds text (line 35):

```dart
Text(
  AppLocalizations.of(context)!.beadsPerRound(beadsPerRound, targetRounds),
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 13,
    color: Color(0xFF666666),
  ),
),
```

- [ ] **Step 5: Update stats_display.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace `'TOTAL ROUNDS'` (line 27) and `'+$sessionBeads beads'` (line 37):

```dart
Text(
  AppLocalizations.of(context)!.totalRounds,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: Color(0xFF666666),
  ),
),
Text(
  AppLocalizations.of(context)!.beads(sessionBeads),
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 10,
    color: Color(0xFFFF8400),
  ),
),
```

- [ ] **Step 6: Update completion_overlay.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace `"Today's Plan\nComplete!"` (line 65) and `'All rounds completed'` (line 77):

```dart
Text(
  AppLocalizations.of(context)!.todayPlanComplete,
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Color(0xFF111111),
    height: 1.3,
  ),
),
const SizedBox(height: 8),
Text(
  AppLocalizations.of(context)!.allRoundsCompleted,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    color: Color(0xFF666666),
  ),
),
```

Note: `CompletionOverlay` is a `StatefulWidget` — it stays as-is since `AppLocalizations.of(context)` works in `State.build`.

- [ ] **Step 7: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 8: Commit**

```bash
git add lib/features/counter/
git commit -m "feat: localize Counter screen and all widgets"
```

---

### Task 9: Update Plans Screens and Widgets

**Files:**
- Modify: `lib/features/plans/presentation/screens/plans_screen.dart`
- Modify: `lib/features/plans/presentation/screens/plan_detail_screen.dart`
- Modify: `lib/features/plans/presentation/screens/add_plan_screen.dart`
- Modify: `lib/features/plans/presentation/widgets/active_plan_card.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2
- Produces: Localized plans UI

- [ ] **Step 1: Update plans_screen.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace hardcoded strings:
- Line 24 `'Plans'` → `AppLocalizations.of(context)!.plans`
- Line 67 `Tab(text: 'Subscribed')` → `Tab(text: AppLocalizations.of(context)!.subscribed)`
- Line 68 `Tab(text: 'List')` → `Tab(text: AppLocalizations.of(context)!.list)`
- Line 242 `'No Active Plan'` → `AppLocalizations.of(context)!.noActivePlan`
- Line 252 `'Browse the List tab to find\na plan that speaks to you'` → `AppLocalizations.of(context)!.noActivePlanSubtitle`
- Line 282 `'No plans yet. Tap + to create one.'` → `AppLocalizations.of(context)!.noPlansYetTab`

For the stop plan dialog (lines 197-215):

```dart
title: Text(AppLocalizations.of(context)!.stopPlan),
content: Text(AppLocalizations.of(context)!.stopPlanConfirm),
actions: [
  TextButton(
    onPressed: () => Navigator.of(ctx).pop(false),
    child: Text(AppLocalizations.of(context)!.cancel),
  ),
  TextButton(
    onPressed: () => Navigator.of(ctx).pop(true),
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFFEF4444),
    ),
    child: Text(AppLocalizations.of(context)!.stop),
  ),
],
```

Note: `_SubscribedTab`, `_ActivePlanView`, `_ListTab` need to become `ConsumerWidget` (they already are) and the context needs to be available. Since they are `ConsumerWidget`, `AppLocalizations.of(context)` works in their `build` methods.

- [ ] **Step 2: Update plan_detail_screen.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace hardcoded strings:
- Line 45 `'Cannot edit an active plan'` → `AppLocalizations.of(context)!.cannotEditActivePlan`
- Line 166 `'Plan updated'` → `AppLocalizations.of(context)!.planUpdated`
- Line 174 `'Delete Plan'` → `AppLocalizations.of(context)!.deletePlan`
- Line 176 `'Are you sure you want to delete this plan? This action cannot be undone.'` → `AppLocalizations.of(context)!.deletePlanConfirm`
- Line 181 `'Cancel'` → `AppLocalizations.of(context)!.cancel`
- Line 187 `'Delete'` → `AppLocalizations.of(context)!.delete`
- Line 215 `'Edit Plan'` / `'Plan Details'` → `AppLocalizations.of(context)!.editPlan` / `AppLocalizations.of(context)!.planDetails`
- Line 251 `'Edit'` → `AppLocalizations.of(context)!.edit`
- Line 261 `'Delete'` → `AppLocalizations.of(context)!.delete`
- Line 279 `'Plan not found'` → `AppLocalizations.of(context)!.planNotFound`
- Line 377 `'PREDEFINED'` → `AppLocalizations.of(context)!.predefined`
- Line 399 `'$beadsPerRound beads per round · ${planDays.length} days'` → `AppLocalizations.of(context)!.beadsPerRound(plan.beadsPerRound, planDays.length)`
- Line 425 `'Days'` → `AppLocalizations.of(context)!.days`
- Line 464 `'Days'` → `AppLocalizations.of(context)!.days`
- Line 477 `'Add Day'` → `AppLocalizations.of(context)!.addDay`
- Line 656 `'Cancel'` → `AppLocalizations.of(context)!.cancelEdit`
- Line 688 `'Save Changes'` → `AppLocalizations.of(context)!.saveChanges`
- Line 672 `'Plan must have at least one day'` → `AppLocalizations.of(context)!.planMustHaveAtLeastOneDay`
- Line 710 `'You already have an active plan. Complete or pause it first.'` → `AppLocalizations.of(context)!.youAlreadyHaveActivePlan`
- Line 721 `'Plan activated!'` → `AppLocalizations.of(context)!.planActivated`
- Line 737 `'Day ${progress.currentDay} complete!'` → `AppLocalizations.of(context)!.dayCompleteMsg(progress.currentDay)`
- Line 751 `'Complete Plan'` → `AppLocalizations.of(context)!.completePlan`
- Line 753 `'Are you sure you want to mark this plan as complete?'` → `AppLocalizations.of(context)!.completePlanConfirm`
- Line 759 `'Cancel'` → `AppLocalizations.of(context)!.cancel`
- Line 762 `'Complete'` → `AppLocalizations.of(context)!.complete`
- Line 772 `'Plan completed! Great work.'` → `AppLocalizations.of(context)!.planCompletedMsg`
- Line 855 `'Completed'` → `AppLocalizations.of(context)!.completed`
- Line 857 `'Complete Plan'` → `AppLocalizations.of(context)!.completePlan`
- Line 858 `'Start This Plan'` → `AppLocalizations.of(context)!.startThisPlan`
- Line 939 `'Day'` → `AppLocalizations.of(context)!.day`
- Line 983 `'Gong/Daw Name'` → `AppLocalizations.of(context)!.gongDawName`
- Line 1025 `'Target Rounds'` → `AppLocalizations.of(context)!.targetRounds`
- Line 1099 `'Gong/Daw Detail'` → `AppLocalizations.of(context)!.gongDawDetail`

- [ ] **Step 3: Update add_plan_screen.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace hardcoded strings:
- Line 53 `'Add at least one day'` → `AppLocalizations.of(context)!.addAtLeastOneDay`
- Line 108 `'Plan created!'` → `AppLocalizations.of(context)!.planCreated`
- Line 125 `'New Plan'` → `AppLocalizations.of(context)!.newPlan`
- Line 139 `'Title'` → `AppLocalizations.of(context)!.title`
- Line 144 `'Required'` → `AppLocalizations.of(context)!.requiredField`
- Line 146 `'e.g., 21-Day Challenge'` → `AppLocalizations.of(context)!.titleHint`
- Line 149 `'Description'` → `AppLocalizations.of(context)!.description`
- Line 155 `'Optional description'` → `AppLocalizations.of(context)!.descriptionHint`
- Line 158 `'Beads per Round'` → `AppLocalizations.of(context)!.beadsPerRoundLabel`
- Line 173 `'Days'` → `AppLocalizations.of(context)!.days`
- Line 186 `'Add Day'` → `AppLocalizations.of(context)!.addDay`
- Line 201 `'Tap "Add Day" to create your plan schedule'` → `AppLocalizations.of(context)!.tapToAddDay`
- Line 249 `'Save Plan'` → `AppLocalizations.of(context)!.savePlan`
- Line 383 `'Day'` → `AppLocalizations.of(context)!.day`
- Line 411 `'Gong/Daw Name'` → `AppLocalizations.of(context)!.gongDawName`
- Line 423 `'Required'` → `AppLocalizations.of(context)!.requiredField`
- Line 455 `'Target Rounds'` → `AppLocalizations.of(context)!.targetRounds`
- Line 480 `'Required'` → `AppLocalizations.of(context)!.requiredField`
- Line 532 `'Gong/Daw Detail'` → `AppLocalizations.of(context)!.gongDawDetail`

- [ ] **Step 4: Update active_plan_card.dart**

Add import:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
```

Change `ActivePlanCard` from `StatelessWidget` to `ConsumerWidget` (add `WidgetRef ref` parameter to `build`).

Replace hardcoded strings:
- Line 61 `'Active Plan'` → `AppLocalizations.of(context)!.activePlan`
- Line 152 `'Today\'s Gong/Daw'` → `AppLocalizations.of(context)!.todaysGongDaw`
- Line 201 `'Day $dayIndex / $totalDays'` → `AppLocalizations.of(context)!.dayOfTotal(dayIndex, totalDays)`
- Line 212 `'${currentDayDetail!.targetRounds} rounds'` → `AppLocalizations.of(context)!.roundsCount(currentDayDetail!.targetRounds)`
- Line 240 `'Complete Plan'` / `'Mark Day Complete'` → `AppLocalizations.of(context)!.completePlan` / `AppLocalizations.of(context)!.markDayComplete`
- Line 256 `'Stop Plan'` → `AppLocalizations.of(context)!.stopPlan`

- [ ] **Step 5: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 6: Commit**

```bash
git add lib/features/plans/
git commit -m "feat: localize Plans screens and widgets"
```

---

### Task 10: Update Onboarding Screen

**Files:**
- Modify: `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2
- Produces: Localized onboarding screen

- [ ] **Step 1: Update onboarding_screen.dart**

Add import:

```dart
import '../../../../core/localization/app_localizations.dart';
```

Replace hardcoded strings:
- Line 57 `'Welcome to'` → `AppLocalizations.of(context)!.welcomeTo`
- Line 66 `'Meditation'` → `AppLocalizations.of(context)!.appTitle`
- Line 76 `'Enter your name to get started'` → `AppLocalizations.of(context)!.enterNamePrompt`
- Line 89 `'Your name'` → `AppLocalizations.of(context)!.nameHint`
- Line 134 `'Start'` → `AppLocalizations.of(context)!.start`

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/onboarding/presentation/screens/onboarding_screen.dart
git commit -m "feat: localize Onboarding screen"
```

---

### Task 11: Update Tests

**Files:**
- Modify: `test/widget_test.dart`
- Modify: `test/test_helpers.dart`

**Interfaces:**
- Consumes: `AppLocalizations` from Task 2, `localeProvider` from Task 3
- Produces: Passing tests with localized widgets

- [ ] **Step 1: Update test_helpers.dart**

Add a helper to wrap widgets with localization:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meditation/core/localization/app_localizations.dart';

Widget wrapWithLocalization(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}
```

- [ ] **Step 2: Update widget_test.dart**

Wrap any `MaterialApp(home: ...)` test boilerplate with `wrapWithLocalization()` or add `localizationsDelegates` and `supportedLocales` to existing `MaterialApp` wrappers.

Look for patterns like:

```dart
MaterialApp(home: SomeScreen())
```

And replace with:

```dart
MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: SomeScreen(),
)
```

Or use the `wrapWithLocalization` helper.

- [ ] **Step 3: Run tests**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 4: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add test/
git commit -m "feat: update tests for localized widgets"
```

---

### Task 12: Final Verification

**Files:** None (verification only)

- [ ] **Step 1: Run flutter gen-l10n**

Run: `flutter gen-l10n`
Expected: No errors

- [ ] **Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No errors or warnings related to our changes

- [ ] **Step 3: Run flutter test**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 4: Verify all string keys match between ARB files**

Check that every key in `app_en.arb` exists in `app_my.arb` and vice versa. Run:

```bash
diff <(python3 -c "import json; print('\n'.join(sorted(json.load(open('lib/l10n/app_en.arb')).keys())))") <(python3 -c "import json; print('\n'.join(sorted(json.load(open('lib/l10n/app_my.arb')).keys())))")
```

Expected: No differences (all keys match)

- [ ] **Step 5: Final commit if any fixes were needed**

```bash
git add -A
git commit -m "chore: final i18n verification fixes"
```
