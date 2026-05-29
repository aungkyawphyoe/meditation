import 'package:drift/drift.dart';
import 'bead_plans_table.dart';
import 'user_info_table.dart';

@DataClassName('UserPlanProgress')
class UserPlanProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserInfoTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get planId => integer().references(BeadPlansTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get currentDay => integer().withDefault(const Constant(1))();
  TextColumn get status => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
