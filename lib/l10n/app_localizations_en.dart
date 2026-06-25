// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Meditation';

  @override
  String get profile => 'Profile';

  @override
  String get plans => 'Plans';

  @override
  String get counter => 'Counter';

  @override
  String get settings => 'Settings';

  @override
  String get totalPlans => 'Total Plans';

  @override
  String get rounds => 'Rounds';

  @override
  String get myPlans => 'My Plans';

  @override
  String get noPlansYet => 'No plans yet';

  @override
  String daysStreak(int count) {
    return '$count Days Streak';
  }

  @override
  String get active => 'Active';

  @override
  String get failed => 'Failed';

  @override
  String get success => 'Success';

  @override
  String dayOfTotal(int current, int total) {
    return 'Day $current of $total';
  }

  @override
  String daysCount(int count) {
    return '$count Days';
  }

  @override
  String get subscribed => 'Subscribed';

  @override
  String get list => 'List';

  @override
  String get noActivePlan => 'No Active Plan';

  @override
  String get noActivePlanSubtitle =>
      'Browse the List tab to find\na plan that speaks to you';

  @override
  String get noPlansYetTab => 'No plans yet. Tap + to create one.';

  @override
  String get stopPlan => 'Stop Plan';

  @override
  String get stopPlanConfirm =>
      'Are you sure you want to stop this plan? It will be marked as failed.';

  @override
  String get cancel => 'Cancel';

  @override
  String get stop => 'Stop';

  @override
  String get days => 'Days';

  @override
  String beadsPerRound(int count, int days) {
    return '$count beads per round · $days days';
  }

  @override
  String get planDetails => 'Plan Details';

  @override
  String get editPlan => 'Edit Plan';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deletePlan => 'Delete Plan';

  @override
  String get deletePlanConfirm =>
      'Are you sure you want to delete this plan? This action cannot be undone.';

  @override
  String get planNotFound => 'Plan not found';

  @override
  String get predefined => 'PREDEFINED';

  @override
  String get cannotEditActivePlan => 'Cannot edit an active plan';

  @override
  String get planUpdated => 'Plan updated';

  @override
  String get planMustHaveAtLeastOneDay => 'Plan must have at least one day';

  @override
  String get addDay => 'Add Day';

  @override
  String get day => 'Day';

  @override
  String get gongDawName => 'Gong/Daw Name';

  @override
  String get gongDawDetail => 'Gong/Daw Detail';

  @override
  String get targetRounds => 'Target Rounds';

  @override
  String get cancelEdit => 'Cancel';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get startThisPlan => 'Start This Plan';

  @override
  String get completePlan => 'Complete Plan';

  @override
  String get completed => 'Completed';

  @override
  String get completePlanConfirm =>
      'Are you sure you want to mark this plan as complete?';

  @override
  String get complete => 'Complete';

  @override
  String get planActivated => 'Plan activated!';

  @override
  String get planCompletedMsg => 'Plan completed! Great work.';

  @override
  String dayCompleteMsg(int count) {
    return 'Day $count complete!';
  }

  @override
  String get activePlan => 'Active Plan';

  @override
  String get todaysGongDaw => 'Today\'s Gong/Daw';

  @override
  String roundsCount(int count) {
    return '$count rounds';
  }

  @override
  String get markDayComplete => 'Mark Day Complete';

  @override
  String get newPlan => 'New Plan';

  @override
  String get title => 'Title';

  @override
  String get titleHint => 'e.g., 21-Day Challenge';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Optional description';

  @override
  String get beadsPerRoundLabel => 'Beads per Round';

  @override
  String get tapToAddDay => 'Tap \"Add Day\" to create your plan schedule';

  @override
  String get savePlan => 'Save Plan';

  @override
  String get requiredField => 'Required';

  @override
  String get addAtLeastOneDay => 'Add at least one day';

  @override
  String get planCreated => 'Plan created!';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get enterNamePrompt => 'Enter your name to get started';

  @override
  String get nameHint => 'Your name';

  @override
  String get start => 'Start';

  @override
  String get standardMode => 'Standard (108)';

  @override
  String get shortMode => 'Short (8)';

  @override
  String get continuousMode => 'Continuous';

  @override
  String get tapToCount => 'TAP TO COUNT';

  @override
  String get totalRounds => 'TOTAL ROUNDS';

  @override
  String beads(int count) {
    return '+$count beads';
  }

  @override
  String get todayPlanComplete => 'Today\'s Plan\nComplete!';

  @override
  String get allRoundsCompleted => 'All rounds completed';

  @override
  String get exitTodayPlan => 'Exit Today Plan';

  @override
  String get startTodayPlan => 'Start Today Plan';

  @override
  String get saveSession => 'Save Session?';

  @override
  String saveSessionContent(int count) {
    return 'You have $count bead(s) in this session.';
  }

  @override
  String get discard => 'Discard';

  @override
  String get save => 'Save';

  @override
  String get reset => 'Reset';

  @override
  String get errorLoadingApp => 'Error loading app';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get burmese => 'Myanmar';

  @override
  String get youAlreadyHaveActivePlan =>
      'You already have an active plan. Complete or pause it first.';

  @override
  String get notificationTitle => 'Daily Reminder';

  @override
  String get notificationBodyGeneric =>
      'Take a moment to pray and find peace today.';

  @override
  String get notificationBodyPlan =>
      'You have a plan to continue. Open the app to start today\'s practice.';

  @override
  String get rankNoviceChanter => 'Novice Chanter';

  @override
  String get rankAspiringDevotee => 'Aspiring Devotee';

  @override
  String get rankSteadyPractitioner => 'Steady Practitioner';

  @override
  String get rankDevotedChanter => 'Devoted Chanter';

  @override
  String get rankFaithfulReciter => 'Faithful Reciter';

  @override
  String get rankVenerableChanter => 'Venerable Chanter';

  @override
  String get rankSeniorDevotee => 'Senior Devotee';

  @override
  String get rankNobleChanter => 'Noble Chanter';

  @override
  String get rankElderDevotee => 'Elder Devotee';

  @override
  String get rankMasterChanter => 'Master Chanter';
}
