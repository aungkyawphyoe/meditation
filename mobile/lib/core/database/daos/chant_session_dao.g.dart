// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chant_session_dao.dart';

// ignore_for_file: type=lint
mixin _$ChantSessionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ChantSessionsTableTable get chantSessionsTable =>
      attachedDatabase.chantSessionsTable;
  ChantSessionDaoManager get managers => ChantSessionDaoManager(this);
}

class ChantSessionDaoManager {
  final _$ChantSessionDaoMixin _db;
  ChantSessionDaoManager(this._db);
  $$ChantSessionsTableTableTableManager get chantSessionsTable =>
      $$ChantSessionsTableTableTableManager(
        _db.attachedDatabase,
        _db.chantSessionsTable,
      );
}
