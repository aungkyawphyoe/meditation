import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/chant_session_dao.dart';
import 'daos/plan_dao.dart';
import 'daos/user_info_dao.dart';
import 'tables/bead_plans_table.dart';
import 'tables/chant_sessions_table.dart';
import 'tables/gong_daw_details_table.dart';
import 'tables/plan_days_table.dart';
import 'tables/user_info_table.dart';
import 'tables/user_plan_progress_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserInfoTable,
    ChantSessionsTable,
    GongDawDetailsTable,
    BeadPlansTable,
    PlanDaysTable,
    UserPlanProgressTable,
  ],
  daos: [UserInfoDao, ChantSessionDao, PlanDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.fromExecutor(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await into(userInfoTable).insert(
          UserInfo(
            id: 1,
            name: 'Meditator',
            rankTitle: 'Novice Chanter',
            defaultMode: 'standard',
            streakDays: 0,
            totalLifetimeBeads: 0,
            totalLifetimeRounds: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        await _seedPredefinedData();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(gongDawDetailsTable);
          await m.createTable(beadPlansTable);
          await m.createTable(planDaysTable);
          await m.createTable(userPlanProgressTable);
          await _seedPredefinedData();
        }
        if (from < 3) {
          await m.addColumn(planDaysTable, planDaysTable.gongDawName);
        }
        if (from < 4) {
          await m.addColumn(userInfoTable, userInfoTable.defaultMode);
        }
      },
    );
  }

  Future<void> _seedPredefinedData() async {
    await batch((b) {
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 1,
          name: 'အရဟံ',
          meaning: 'ပူဇော်အထူးကို ခံတော်မူထိုက်သော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 2,
          name: 'သမ္မာသမ္ဗုဒ္ဓေါ',
          meaning: 'တရားအလုံးစုံကို ကိုယ်တိုင်မှန်ကန်စွာ သိတော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 3,
          name: 'ဝိဇ္ဇာစရဏသမ္ပန္နော',
          meaning: 'အသိဉာဏ်ပညာ အကျင့်စရဏနှင့် ပြည့်စုံတော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 4,
          name: 'သုဂတော',
          meaning: 'ကောင်းသောစကားကို ဆိုတော်မူတတ်သော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 5,
          name: 'လောကဝိဒူ',
          meaning: 'လောကသုံးပါးကို အကုန်အစင် သိတော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 6,
          name: 'အနုတ္တရော ပုရိသဒမ္မသာရထိ',
          meaning: 'ဆုံးမထိုက်သူတို့ကို အတုမရှိ ဆုံးမတော်မူတတ်သော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 7,
          name: 'သတ္တာဒေဝမနုဿာနံ',
          meaning: 'နတ်လူတို့၏ ဆရာတစ်ဆူ ဖြစ်တော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 8,
          name: 'ဗုဒ္ဓေါ',
          meaning: 'သစ္စာလေးပါးကို သိတော်မူပြီးသူ ဖြစ်တော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        gongDawDetailsTable,
        GongDawDetails(
          id: 9,
          name: 'ဘဂဝါ',
          meaning: 'ဘုန်းတော်ခြောက်ပါးနှင့် ပြည့်စုံတော်မူသော ဂုဏ်တော်',
        ),
      );
      b.insert(
        beadPlansTable,
        BeadPlan(
          id: 1,
          title: 'ကိုးနဝင်း အဓိဋ္ဌာန် (၉ ရက်)',
          description:
              '၉ ရက်တိုင်တိုင် တစ်ရက်လျှင် သတ်မှတ်ထားသော ဂုဏ်တော်နှင့် အပတ်ရေအတိုင်း တိုးမြှင့်စိတ်ရမည့် စနစ်တကျ အဓိဋ္ဌာန်စဉ် ဖြစ်သည်။',
          isPredefined: true,
          beadsPerRound: 108,
          createdAt: DateTime.now(),
        ),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 1, planId: 1, dayNumber: 1, gongDawId: 1, targetRounds: 1),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 2, planId: 1, dayNumber: 2, gongDawId: 2, targetRounds: 2),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 3, planId: 1, dayNumber: 3, gongDawId: 3, targetRounds: 3),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 4, planId: 1, dayNumber: 4, gongDawId: 4, targetRounds: 4),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 5, planId: 1, dayNumber: 5, gongDawId: 5, targetRounds: 5),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 6, planId: 1, dayNumber: 6, gongDawId: 6, targetRounds: 6),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 7, planId: 1, dayNumber: 7, gongDawId: 7, targetRounds: 7),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 8, planId: 1, dayNumber: 8, gongDawId: 8, targetRounds: 8),
      );
      b.insert(
        planDaysTable,
        PlanDay(id: 9, planId: 1, dayNumber: 9, gongDawId: 9, targetRounds: 9),
      );
    });
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      await Directory(dir.path).create(recursive: true);
      return driftDatabase(name: p.join(dir.path, 'meditation.db'));
    });
  }
}
