import 'package:drift/drift.dart' hide Column;
import '../database.dart';
import '../tables/chant_sessions_table.dart';

part 'chant_session_dao.g.dart';

@DriftAccessor(tables: [ChantSessionsTable])
class ChantSessionDao extends DatabaseAccessor<AppDatabase>
    with _$ChantSessionDaoMixin {
  ChantSessionDao(super.db);

  Future<int> insertSession(ChantSessionsTableCompanion session) {
    return into(chantSessionsTable).insert(session);
  }

  Future<void> updateSession(int id, ChantSessionsTableCompanion session) {
    return (update(chantSessionsTable)..where((t) => t.id.equals(id))).write(session);
  }

  Future<void> deleteSession(int id) {
    return (delete(chantSessionsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ChantSession>> getRecentSessions({int limit = 20}) {
    return (select(chantSessionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(limit))
        .get();
  }

  Future<int> getTotalBeads() async {
    final count = await customSelect(
      'SELECT COALESCE(SUM(beads_count), 0) AS total FROM chant_sessions',
      readsFrom: {chantSessionsTable},
    ).getSingle();
    return count.data['total'] as int;
  }

  Future<int> getTotalRounds() async {
    final count = await customSelect(
      'SELECT COALESCE(SUM(rounds_completed), 0) AS total FROM chant_sessions',
      readsFrom: {chantSessionsTable},
    ).getSingle();
    return count.data['total'] as int;
  }
}
