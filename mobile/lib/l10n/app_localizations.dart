import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get appTitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @plans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get plans;

  /// No description provided for @counter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counter;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @totalPlans.
  ///
  /// In en, this message translates to:
  /// **'Total Plans'**
  String get totalPlans;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @myPlans.
  ///
  /// In en, this message translates to:
  /// **'My Plans'**
  String get myPlans;

  /// No description provided for @noPlansYet.
  ///
  /// In en, this message translates to:
  /// **'No plans yet'**
  String get noPlansYet;

  /// No description provided for @daysStreak.
  ///
  /// In en, this message translates to:
  /// **'{count} Days Streak'**
  String daysStreak(int count);

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @dayOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Day {current} of {total}'**
  String dayOfTotal(int current, int total);

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String daysCount(int count);

  /// No description provided for @subscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get subscribed;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @noActivePlan.
  ///
  /// In en, this message translates to:
  /// **'No Active Plan'**
  String get noActivePlan;

  /// No description provided for @noActivePlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse the List tab to find\na plan that speaks to you'**
  String get noActivePlanSubtitle;

  /// No description provided for @noPlansYetTab.
  ///
  /// In en, this message translates to:
  /// **'No plans yet. Tap + to create one.'**
  String get noPlansYetTab;

  /// No description provided for @stopPlan.
  ///
  /// In en, this message translates to:
  /// **'Stop Plan'**
  String get stopPlan;

  /// No description provided for @stopPlanConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop this plan? It will be marked as failed.'**
  String get stopPlanConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @beadsPerRound.
  ///
  /// In en, this message translates to:
  /// **'{count} beads per round · {days} days'**
  String beadsPerRound(int count, int days);

  /// No description provided for @planDetails.
  ///
  /// In en, this message translates to:
  /// **'Plan Details'**
  String get planDetails;

  /// No description provided for @editPlan.
  ///
  /// In en, this message translates to:
  /// **'Edit Plan'**
  String get editPlan;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deletePlan.
  ///
  /// In en, this message translates to:
  /// **'Delete Plan'**
  String get deletePlan;

  /// No description provided for @deletePlanConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this plan? This action cannot be undone.'**
  String get deletePlanConfirm;

  /// No description provided for @planNotFound.
  ///
  /// In en, this message translates to:
  /// **'Plan not found'**
  String get planNotFound;

  /// No description provided for @predefined.
  ///
  /// In en, this message translates to:
  /// **'PREDEFINED'**
  String get predefined;

  /// No description provided for @cannotEditActivePlan.
  ///
  /// In en, this message translates to:
  /// **'Cannot edit an active plan'**
  String get cannotEditActivePlan;

  /// No description provided for @planUpdated.
  ///
  /// In en, this message translates to:
  /// **'Plan updated'**
  String get planUpdated;

  /// No description provided for @planMustHaveAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Plan must have at least one day'**
  String get planMustHaveAtLeastOneDay;

  /// No description provided for @addDay.
  ///
  /// In en, this message translates to:
  /// **'Add Day'**
  String get addDay;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @gongDawName.
  ///
  /// In en, this message translates to:
  /// **'Gong/Daw Name'**
  String get gongDawName;

  /// No description provided for @gongDawDetail.
  ///
  /// In en, this message translates to:
  /// **'Gong/Daw Detail'**
  String get gongDawDetail;

  /// No description provided for @targetRounds.
  ///
  /// In en, this message translates to:
  /// **'Target Rounds'**
  String get targetRounds;

  /// No description provided for @cancelEdit.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelEdit;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @startThisPlan.
  ///
  /// In en, this message translates to:
  /// **'Start This Plan'**
  String get startThisPlan;

  /// No description provided for @completePlan.
  ///
  /// In en, this message translates to:
  /// **'Complete Plan'**
  String get completePlan;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @completePlanConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this plan as complete?'**
  String get completePlanConfirm;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @planActivated.
  ///
  /// In en, this message translates to:
  /// **'Plan activated!'**
  String get planActivated;

  /// No description provided for @planCompletedMsg.
  ///
  /// In en, this message translates to:
  /// **'Plan completed! Great work.'**
  String get planCompletedMsg;

  /// No description provided for @dayCompleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Day {count} complete!'**
  String dayCompleteMsg(int count);

  /// No description provided for @activePlan.
  ///
  /// In en, this message translates to:
  /// **'Active Plan'**
  String get activePlan;

  /// No description provided for @todaysGongDaw.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Gong/Daw'**
  String get todaysGongDaw;

  /// No description provided for @roundsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} rounds'**
  String roundsCount(int count);

  /// No description provided for @markDayComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Day Complete'**
  String get markDayComplete;

  /// No description provided for @newPlan.
  ///
  /// In en, this message translates to:
  /// **'New Plan'**
  String get newPlan;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 21-Day Challenge'**
  String get titleHint;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional description'**
  String get descriptionHint;

  /// No description provided for @beadsPerRoundLabel.
  ///
  /// In en, this message translates to:
  /// **'Beads per Round'**
  String get beadsPerRoundLabel;

  /// No description provided for @tapToAddDay.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add Day\" to create your plan schedule'**
  String get tapToAddDay;

  /// No description provided for @savePlan.
  ///
  /// In en, this message translates to:
  /// **'Save Plan'**
  String get savePlan;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @addAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Add at least one day'**
  String get addAtLeastOneDay;

  /// No description provided for @planCreated.
  ///
  /// In en, this message translates to:
  /// **'Plan created!'**
  String get planCreated;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @enterNamePrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your name to get started'**
  String get enterNamePrompt;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get nameHint;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @standardMode.
  ///
  /// In en, this message translates to:
  /// **'Standard (108)'**
  String get standardMode;

  /// No description provided for @shortMode.
  ///
  /// In en, this message translates to:
  /// **'Short (8)'**
  String get shortMode;

  /// No description provided for @continuousMode.
  ///
  /// In en, this message translates to:
  /// **'Continuous'**
  String get continuousMode;

  /// No description provided for @tapToCount.
  ///
  /// In en, this message translates to:
  /// **'TAP TO COUNT'**
  String get tapToCount;

  /// No description provided for @totalRounds.
  ///
  /// In en, this message translates to:
  /// **'TOTAL ROUNDS'**
  String get totalRounds;

  /// No description provided for @beads.
  ///
  /// In en, this message translates to:
  /// **'+{count} beads'**
  String beads(int count);

  /// No description provided for @todayPlanComplete.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Plan\nComplete!'**
  String get todayPlanComplete;

  /// No description provided for @allRoundsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All rounds completed'**
  String get allRoundsCompleted;

  /// No description provided for @exitTodayPlan.
  ///
  /// In en, this message translates to:
  /// **'Exit Today Plan'**
  String get exitTodayPlan;

  /// No description provided for @startTodayPlan.
  ///
  /// In en, this message translates to:
  /// **'Start Today Plan'**
  String get startTodayPlan;

  /// No description provided for @saveSession.
  ///
  /// In en, this message translates to:
  /// **'Save Session?'**
  String get saveSession;

  /// No description provided for @saveSessionContent.
  ///
  /// In en, this message translates to:
  /// **'You have {count} bead(s) in this session.'**
  String saveSessionContent(int count);

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @errorLoadingApp.
  ///
  /// In en, this message translates to:
  /// **'Error loading app'**
  String get errorLoadingApp;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @burmese.
  ///
  /// In en, this message translates to:
  /// **'Myanmar'**
  String get burmese;

  /// No description provided for @youAlreadyHaveActivePlan.
  ///
  /// In en, this message translates to:
  /// **'You already have an active plan. Complete or pause it first.'**
  String get youAlreadyHaveActivePlan;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get notificationTitle;

  /// No description provided for @notificationBodyGeneric.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to pray and find peace today.'**
  String get notificationBodyGeneric;

  /// No description provided for @notificationBodyPlan.
  ///
  /// In en, this message translates to:
  /// **'You have a plan to continue. Open the app to start today\'s practice.'**
  String get notificationBodyPlan;

  /// No description provided for @rankNoviceChanter.
  ///
  /// In en, this message translates to:
  /// **'Novice Chanter'**
  String get rankNoviceChanter;

  /// No description provided for @rankAspiringDevotee.
  ///
  /// In en, this message translates to:
  /// **'Aspiring Devotee'**
  String get rankAspiringDevotee;

  /// No description provided for @rankSteadyPractitioner.
  ///
  /// In en, this message translates to:
  /// **'Steady Practitioner'**
  String get rankSteadyPractitioner;

  /// No description provided for @rankDevotedChanter.
  ///
  /// In en, this message translates to:
  /// **'Devoted Chanter'**
  String get rankDevotedChanter;

  /// No description provided for @rankFaithfulReciter.
  ///
  /// In en, this message translates to:
  /// **'Faithful Reciter'**
  String get rankFaithfulReciter;

  /// No description provided for @rankVenerableChanter.
  ///
  /// In en, this message translates to:
  /// **'Venerable Chanter'**
  String get rankVenerableChanter;

  /// No description provided for @rankSeniorDevotee.
  ///
  /// In en, this message translates to:
  /// **'Senior Devotee'**
  String get rankSeniorDevotee;

  /// No description provided for @rankNobleChanter.
  ///
  /// In en, this message translates to:
  /// **'Noble Chanter'**
  String get rankNobleChanter;

  /// No description provided for @rankElderDevotee.
  ///
  /// In en, this message translates to:
  /// **'Elder Devotee'**
  String get rankElderDevotee;

  /// No description provided for @rankMasterChanter.
  ///
  /// In en, this message translates to:
  /// **'Master Chanter'**
  String get rankMasterChanter;

  /// No description provided for @selectMode.
  ///
  /// In en, this message translates to:
  /// **'Select your counting mode'**
  String get selectMode;

  /// No description provided for @selectModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to count beads'**
  String get selectModeSubtitle;

  /// No description provided for @modeStandardDescription.
  ///
  /// In en, this message translates to:
  /// **'Count 108 beads per round'**
  String get modeStandardDescription;

  /// No description provided for @modeShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Count 8 beads per round'**
  String get modeShortDescription;

  /// No description provided for @modeContinuousDescription.
  ///
  /// In en, this message translates to:
  /// **'Count without rounds'**
  String get modeContinuousDescription;

  /// No description provided for @currentMode.
  ///
  /// In en, this message translates to:
  /// **'Counting Mode'**
  String get currentMode;

  /// No description provided for @changeMode.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeMode;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @nameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Name should not be empty'**
  String get nameEmptyError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
