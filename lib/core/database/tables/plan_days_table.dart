import 'package:drift/drift.dart';

@DataClassName('PlanDay')
class PlanDaysTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer().references(BeadPlansTable, #id, onDelete: ForeignKeyAction.cascade)();
  IntColumn get dayNumber => integer()();
  IntColumn get gongDawId => integer().references(GongDawDetailsTable, #id)();
  IntColumn get targetRounds => integer()();
}
