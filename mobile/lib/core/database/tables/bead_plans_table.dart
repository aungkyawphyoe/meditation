import 'package:drift/drift.dart';

@DataClassName('BeadPlan')
class BeadPlansTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  BoolColumn get isPredefined => boolean().withDefault(const Constant(false))();
  IntColumn get beadsPerRound => integer().withDefault(const Constant(108))();
  DateTimeColumn get createdAt => dateTime()();
}
