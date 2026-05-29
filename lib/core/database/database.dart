import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/chant_session_dao.dart';
import 'daos/user_info_dao.dart';
import 'tables/chant_sessions_table.dart';
import 'tables/user_info_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserInfoTable,
    ChantSessionsTable,
  ],
  daos: [
    UserInfoDao,
    ChantSessionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.fromExecutor(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await into(userInfoTable).insert(UserInfo(
          id: 1,
          name: 'Meditator',
          rankTitle: 'Novice Chanter',
          streakDays: 0,
          totalLifetimeBeads: 0,
          totalLifetimeRounds: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      },
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      await Directory(dir.path).create(recursive: true);
      return driftDatabase(name: p.join(dir.path, 'meditation.db'));
    });
  }
}
