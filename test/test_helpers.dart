import 'package:flutter/widgets.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditation/core/database/database.dart';
import 'package:meditation/core/database/providers/app_database_providers.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.fromExecutor(NativeDatabase.memory());
}

ProviderScope createTestProviderScope({
  required Widget child,
  AppDatabase? database,
}) {
  final db = database ?? createTestDatabase();
  return ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(db),
    ],
    child: child,
  );
}

Future<void> seedTestUser(AppDatabase db) async {
  // Delete default user first, then insert test user
  await db.delete(db.userInfoTable).go();
  await db.into(db.userInfoTable).insert(UserInfo(
        id: 1,
        name: 'Alex Practitioner',
        rankTitle: 'Novice Chanter',
        streakDays: 12,
        totalLifetimeBeads: 0,
        totalLifetimeRounds: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
}
