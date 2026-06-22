import 'package:drift/drift.dart';
import 'bead_plans_table.dart';
import 'gong_daw_details_table.dart';

@DataClassName('PlanDay')
class PlanDaysTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId =>
      integer().references(BeadPlansTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get dayNumber => integer()();
  IntColumn get gongDawId => integer().references(GongDawDetailsTable, #id)();
  IntColumn get targetRounds => integer()();
  TextColumn get gongDawName => text().nullable()();
}
