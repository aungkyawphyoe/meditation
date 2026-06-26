// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'တရားအားထုတ်ခြင်း';

  @override
  String get profile => 'ပရိုဖိုင်';

  @override
  String get plans => 'အစီအစဉ်များ';

  @override
  String get counter => 'ကောင်တာ';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get totalPlans => 'အစီအစဉ်စုစုပေါင်း';

  @override
  String get rounds => 'ပတ်ရေ';

  @override
  String get myPlans => 'ကျွန်ုပ်၏ အစီအစဉ်များ';

  @override
  String get noPlansYet => 'အစီအစဉ်မရှိသေးပါ';

  @override
  String daysStreak(int count) {
    return '$count ရက် ဆက်တိုက်';
  }

  @override
  String get active => 'လုပ်ဆောင်ဆဲ';

  @override
  String get failed => 'မအောင်မြင်ပါ';

  @override
  String get success => 'အောင်မြင်ပါသည်';

  @override
  String dayOfTotal(int current, int total) {
    return 'ရက်မြောက် $current / စုစုပေါင်း $total ရက်';
  }

  @override
  String daysCount(int count) {
    return '$count ရက်';
  }

  @override
  String get subscribed => 'စာရင်းသွင်းထားပြီး';

  @override
  String get list => 'စာရင်း';

  @override
  String get noActivePlan => 'လုပ်ဆောင်နေသော အစီအစဉ်မရှိပါ';

  @override
  String get noActivePlanSubtitle =>
      'သင့်အတွက် သင့်တော်မည့် အစီအစဉ်တစ်ခုကို\nရှာဖွေရန် \'စာရင်း\' တက်ဘ်ကို ကြည့်ပါ';

  @override
  String get noPlansYetTab => 'အစီအစဉ်မရှိသေးပါ။ အသစ်ပြုလုပ်ရန် + ကို နှိပ်ပါ။';

  @override
  String get stopPlan => 'အစီအစဉ် ရပ်တန့်ရန်';

  @override
  String get stopPlanConfirm =>
      'ဤအစီအစဉ်ကို ရပ်တန့်ရန် သေချာပါသလား။ ၎င်းကို မအောင်မြင်သော အစီအစဉ်အဖြစ် သတ်မှတ်ပါလိမ့်မည်။';

  @override
  String get cancel => 'ပယ်ဖျက်ရန်';

  @override
  String get stop => 'ရပ်ရန်';

  @override
  String get days => 'ရက်များ';

  @override
  String beadsPerRound(int count, int days) {
    return 'တစ်ပတ်လျှင် $count လုံး · $days ရက်';
  }

  @override
  String get planDetails => 'အစီအစဉ် အသေးစိတ်';

  @override
  String get editPlan => 'အစီအစဉ် ပြင်ဆင်ရန်';

  @override
  String get edit => 'ပြင်ဆင်ရန်';

  @override
  String get delete => 'ဖျက်ရန်';

  @override
  String get deletePlan => 'အစီအစဉ် ဖျက်ရန်';

  @override
  String get deletePlanConfirm =>
      'ဤအစီအစဉ်ကို ဖျက်ရန် သေချာပါသလား။ ဤလုပ်ဆောင်ချက်ကို ပြန်ပြင်၍မရပါ။';

  @override
  String get planNotFound => 'အစီအစဉ် ရှာမတွေ့ပါ';

  @override
  String get predefined => 'သတ်မှတ်ပြီးသား';

  @override
  String get cannotEditActivePlan => 'လုပ်ဆောင်နေသော အစီအစဉ်ကို ပြင်ဆင်၍မရပါ';

  @override
  String get planUpdated => 'အစီအစဉ်ကို အပ်ဒိတ်လုပ်ပြီးပါပြီ';

  @override
  String get planMustHaveAtLeastOneDay =>
      'အစီအစဉ်တွင် အနည်းဆုံး တစ်ရက် ရှိရပါမည်';

  @override
  String get addDay => 'ရက်ပေါင်းထည့်ရန်';

  @override
  String get day => 'ရက်';

  @override
  String get gongDawName => 'ဂုဏ်တော် အမည်';

  @override
  String get gongDawDetail => 'ဂုဏ်တော် အသေးစိတ်';

  @override
  String get targetRounds => 'ရည်မှန်းချက် ပတ်ရေ';

  @override
  String get cancelEdit => 'ပယ်ဖျက်ရန်';

  @override
  String get saveChanges => 'အပြောင်းအလဲများ သိမ်းဆည်းရန်';

  @override
  String get startThisPlan => 'ဤအစီအစဉ် စတင်ရန်';

  @override
  String get completePlan => 'အစီအစဉ် အောင်မြင်စွာ အဆုံးသတ်ရန်';

  @override
  String get completed => 'ပြီးမြောက်သည်';

  @override
  String get completePlanConfirm =>
      'ဤအစီအစဉ်ကို ပြီးမြောက်ကြောင်း သတ်မှတ်ရန် သေချာပါသလား။';

  @override
  String get complete => 'ပြီးမြောက်ရန်';

  @override
  String get planActivated => 'အစီအစဉ်ကို စတင်လိုက်ပါပြီ။';

  @override
  String get planCompletedMsg =>
      'အစီအစဉ် ပြီးမြောက်သွားပါပြီ။ သာဓုခေါ်ဆိုပါသည်၊၊';

  @override
  String dayCompleteMsg(int count) {
    return 'ရက်မြောက် $count ပြီးမြောက်ပါပြီ။';
  }

  @override
  String get activePlan => 'လုပ်ဆောင်နေသော အစီအစဉ်';

  @override
  String get todaysGongDaw => 'ယနေ့အတွက် ဂုဏ်တော်';

  @override
  String roundsCount(int count) {
    return '$count ပတ်';
  }

  @override
  String get markDayComplete => 'ယနေ့အတွက် ပြီးမြောက်ကြောင်း မှတ်သားရန်';

  @override
  String get newPlan => 'အစီအစဉ်အသစ်';

  @override
  String get title => 'ခေါင်းစဉ်';

  @override
  String get titleHint => 'ဥပမာ- ၂၁ ရက် စိန်ခေါ်မှု';

  @override
  String get description => 'အသေးစိတ် ဖော်ပြချက်';

  @override
  String get descriptionHint => 'စိတ်ကြိုက် ထည့်သွင်းရန် ဖော်ပြချက်';

  @override
  String get beadsPerRoundLabel => 'တစ်ပတ်လျှင် ရှိရမည့် ပုတီးလုံးရေ';

  @override
  String get tapToAddDay =>
      'သင့်အစီအစဉ်၏ အချိန်ဇယား ဖန်တီးရန် \'ရက်ပေါင်းထည့်ရန်\' ကို နှိပ်ပါ';

  @override
  String get savePlan => 'အစီအစဉ် သိမ်းဆည်းရန်';

  @override
  String get requiredField => 'ဖြည့်စွက်ရန် လိုအပ်သည်';

  @override
  String get addAtLeastOneDay => 'အနည်းဆုံး တစ်ရက် ထည့်သွင်းပါ';

  @override
  String get planCreated => 'အစီအစဉ် ဖန်တီးပြီးပါပြီ။';

  @override
  String get welcomeTo => 'မှ ကြိုဆိုပါသည်';

  @override
  String get enterNamePrompt => 'စတင်ရန် သင့်အမည်ကို ထည့်သွင်းပါ';

  @override
  String get nameHint => 'သင့်အမည်';

  @override
  String get start => 'စတင်ရန်';

  @override
  String get standardMode => 'ပုံမှန် (၁၀၈ လုံး)';

  @override
  String get shortMode => 'အမြန် (၈ လုံး)';

  @override
  String get continuousMode => 'အဆက်မပြတ်';

  @override
  String get tapToCount => 'ရေတွက်ရန် နှိပ်ပါ';

  @override
  String get totalRounds => 'စုစုပေါင်း ပတ်ရေ';

  @override
  String beads(int count) {
    return '+$count လုံး';
  }

  @override
  String get todayPlanComplete => 'ယနေ့အတွက် အစီအစဉ်\nပြီးမြောက်ပါပြီ။';

  @override
  String get allRoundsCompleted => 'ပတ်ရေအားလုံး ပြီးမြောက်ပါပြီ';

  @override
  String get exitTodayPlan => 'ယနေ့အစီအစဉ်မှ ထွက်ရန်';

  @override
  String get startTodayPlan => 'ယနေ့အစီအစဉ် စတင်ရန်';

  @override
  String get saveSession => 'လက်ရှိမှတ်တမ်းကို သိမ်းဆည်းမလား။';

  @override
  String saveSessionContent(int count) {
    return 'ဤမှတ်တမ်းတွင် ပုတီးစိပ်ပြီးသား $count လုံး ရှိနေပါသည်။';
  }

  @override
  String get discard => 'ပယ်ဖျက်ရန်';

  @override
  String get save => 'သိမ်းဆည်းရန်';

  @override
  String get reset => 'ပယ်ဖျက်ရန်';

  @override
  String get errorLoadingApp => 'အက်ပ်ဖွင့်ရာတွင် အမှားအယွင်းရှိနေပါသည်';

  @override
  String get language => 'ဘာသာစကား';

  @override
  String get english => 'English';

  @override
  String get burmese => 'မြန်မာ';

  @override
  String get youAlreadyHaveActivePlan =>
      'လုပ်ဆောင်နေဆဲ အစီအစဉ်တစ်ခု ရှိနှင့်ပြီးသား ဖြစ်သည်။ ကျေးဇူးပြု၍ ၎င်းကို အရင်ဆုံး ပြီးမြောက်အောင် ပြုလုပ်ပါ သို့မဟုတ် ခေတ္တရပ်ဆိုင်းထားပါ။';

  @override
  String get notificationTitle => 'နေ့စဉ် သတိပေးချက်';

  @override
  String get notificationBodyGeneric =>
      'တရားအားထုတ်ပြီး ငြိမ်သက်မှုကို ခံစားပါ။';

  @override
  String get notificationBodyPlan =>
      'ဆက်လက်ဆောင်ရွက်ရန် အစီအစဉ်ရှိနေပါသည်။ ယနေ့အတွက် လေ့ကျင့်ခန်းကို စတင်ရန် အက်ပ်ကို ဖွင့်ပါ။';

  @override
  String get rankNoviceChanter => 'ဝတ်ရွတ်သူအသစ်';

  @override
  String get rankAspiringDevotee => 'ကြိုးပမ်းဆဲသဒ္ဓါကြည်ညိုသူ';

  @override
  String get rankSteadyPractitioner => 'ပုံမှန်ကျင့်ကြံအားထုတ်သူ';

  @override
  String get rankDevotedChanter => 'စိတ်အားထက်သန်သောဝတ်ရွတ်သူ';

  @override
  String get rankFaithfulReciter => 'သဒ္ဓါတရားထက်သန်စွာရွတ်ဖတ်သူ';

  @override
  String get rankVenerableChanter => 'ရိုသေလေးမြတ်အပ်သောဝတ်ရွတ်သူ';

  @override
  String get rankSeniorDevotee => 'ဝါရင့်သဒ္ဓါကြည်ညိုသူ';

  @override
  String get rankNobleChanter => 'မွန်မြတ်သောဝတ်ရွတ်သူ';

  @override
  String get rankElderDevotee => 'အကြီးတန်းသဒ္ဓါကြည်ညိုသူ';

  @override
  String get rankMasterChanter => 'ဝတ်ရွတ်စဉ်ဓမ္မဆရာကြီး';

  @override
  String get selectMode => 'ရေတွက်နည်းကို ရွေးချယ်ပါ';

  @override
  String get selectModeSubtitle => 'ပုတီးစိပ်နည်းကို ရွေးချယ်ပါ';

  @override
  String get modeStandardDescription => 'တစ်ပတ်လျှင် ၁၀၈ လုံး ရေတွက်ပါ';

  @override
  String get modeShortDescription => 'တစ်ပတ်လျှင် ၈ လုံး ရေတွက်ပါ';

  @override
  String get modeContinuousDescription => 'ပတ်ရေမရှိဘဲ ဆက်တိုက်ရေတွက်ပါ';

  @override
  String get currentMode => 'ရေတွက်နည်း';

  @override
  String get changeMode => 'ပြောင်းရန်';
}
