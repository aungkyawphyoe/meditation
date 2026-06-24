import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditation/core/database/database.dart';
import 'package:meditation/core/database/providers/app_database_providers.dart';
import 'package:meditation/l10n/app_localizations.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.fromExecutor(NativeDatabase.memory());
}

ProviderScope createTestProviderScope({
  required Widget child,
  AppDatabase? database,
}) {
  final db = database ?? createTestDatabase();
  return ProviderScope(
    overrides: [databaseProvider.overrideWithValue(db)],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

Future<void> seedTestUser(AppDatabase db) async {
  // Delete default user first, then insert test user
  await db.delete(db.userInfoTable).go();
  await db
      .into(db.userInfoTable)
      .insert(
        UserInfo(
          id: 1,
          name: 'Alex Practitioner',
          rankTitle: 'Novice Chanter',
          streakDays: 12,
          totalLifetimeBeads: 0,
          totalLifetimeRounds: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
}

Future<void> seedTestPlan(AppDatabase db) async {
  await db
      .into(db.beadPlansTable)
      .insert(
        BeadPlan(
          id: 99,
          title: 'Test Plan',
          description: '3 beads/round, 2 rounds today',
          isPredefined: false,
          beadsPerRound: 3,
          createdAt: DateTime.now(),
        ),
      );
  await db
      .into(db.planDaysTable)
      .insert(
        PlanDay(
          id: 99,
          planId: 99,
          dayNumber: 1,
          gongDawId: 1,
          targetRounds: 2,
          gongDawName: 'အရဟံ',
        ),
      );
  await db
      .into(db.userPlanProgressTable)
      .insert(
        UserPlanProgress(
          id: 1,
          userId: 1,
          planId: 99,
          currentDay: 1,
          status: 'active',
          startDate: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
}
