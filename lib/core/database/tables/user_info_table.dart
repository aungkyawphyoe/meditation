import 'package:drift/drift.dart';

@DataClassName('UserInfo')
class UserInfoTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get rankTitle => text()();
  TextColumn get defaultMode => text().withDefault(const Constant('standard'))();
  IntColumn get streakDays => integer()();
  IntColumn get totalLifetimeBeads => integer()();
  IntColumn get totalLifetimeRounds => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
