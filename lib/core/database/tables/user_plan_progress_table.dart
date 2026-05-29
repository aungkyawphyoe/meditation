import 'package:drift/drift.dart';

@DataClassName('UserPlanProgress')
class UserPlanProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserInfoTable, #id, onDelete: ForeignKeyAction.cascade)();
  IntColumn get planId => integer().references(BeadPlansTable, #id, onDelete: ForeignKeyAction.cascade)();
  IntColumn get currentDay => integer().withDefault(const Constant(1))();
  TextColumn get status => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
