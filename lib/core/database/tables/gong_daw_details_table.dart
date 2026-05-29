import 'package:drift/drift.dart';

@DataClassName('GongDawDetails')
class GongDawDetailsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get meaning => text()();

  @override
  Set<Column> get primaryKey => {id};
}
