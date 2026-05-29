import 'package:drift/drift.dart';

@DataClassName('ChantSession')
class ChantSessionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mode => text()();
  IntColumn get beadsCount => integer()();
  IntColumn get roundsCompleted => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}
