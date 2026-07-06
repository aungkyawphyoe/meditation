// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dao.dart';

// ignore_for_file: type=lint
mixin _$UserInfoDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserInfoTableTable get userInfoTable => attachedDatabase.userInfoTable;
  UserInfoDaoManager get managers => UserInfoDaoManager(this);
}

class UserInfoDaoManager {
  final _$UserInfoDaoMixin _db;
  UserInfoDaoManager(this._db);
  $$UserInfoTableTableTableManager get userInfoTable =>
      $$UserInfoTableTableTableManager(_db.attachedDatabase, _db.userInfoTable);
}
