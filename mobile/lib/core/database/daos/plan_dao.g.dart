// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_dao.dart';

// ignore_for_file: type=lint
mixin _$PlanDaoMixin on DatabaseAccessor<AppDatabase> {
  $BeadPlansTableTable get beadPlansTable => attachedDatabase.beadPlansTable;
  $GongDawDetailsTableTable get gongDawDetailsTable =>
      attachedDatabase.gongDawDetailsTable;
  $PlanDaysTableTable get planDaysTable => attachedDatabase.planDaysTable;
  $UserInfoTableTable get userInfoTable => attachedDatabase.userInfoTable;
  $UserPlanProgressTableTable get userPlanProgressTable =>
      attachedDatabase.userPlanProgressTable;
  PlanDaoManager get managers => PlanDaoManager(this);
}

class PlanDaoManager {
  final _$PlanDaoMixin _db;
  PlanDaoManager(this._db);
  $$BeadPlansTableTableTableManager get beadPlansTable =>
      $$BeadPlansTableTableTableManager(
        _db.attachedDatabase,
        _db.beadPlansTable,
      );
  $$GongDawDetailsTableTableTableManager get gongDawDetailsTable =>
      $$GongDawDetailsTableTableTableManager(
        _db.attachedDatabase,
        _db.gongDawDetailsTable,
      );
  $$PlanDaysTableTableTableManager get planDaysTable =>
      $$PlanDaysTableTableTableManager(_db.attachedDatabase, _db.planDaysTable);
  $$UserInfoTableTableTableManager get userInfoTable =>
      $$UserInfoTableTableTableManager(_db.attachedDatabase, _db.userInfoTable);
  $$UserPlanProgressTableTableTableManager get userPlanProgressTable =>
      $$UserPlanProgressTableTableTableManager(
        _db.attachedDatabase,
        _db.userPlanProgressTable,
      );
}
