import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../daos/chant_session_dao.dart';
import '../daos/user_info_dao.dart';
import '../database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final userInfoDaoProvider = Provider<UserInfoDao>((ref) {
  return ref.watch(databaseProvider).userInfoDao;
});

final chantSessionDaoProvider = Provider<ChantSessionDao>((ref) {
  return ref.watch(databaseProvider).chantSessionDao;
});

final userInfoProvider = FutureProvider<UserInfo?>((ref) async {
  final dao = ref.watch(userInfoDaoProvider);
  return dao.getUser();
});

final recentSessionsProvider = FutureProvider<List<ChantSession>>((ref) async {
  final dao = ref.watch(chantSessionDaoProvider);
  return dao.getRecentSessions();
});

final lifetimeBeadsProvider = FutureProvider<int>((ref) async {
  final dao = ref.watch(chantSessionDaoProvider);
  return dao.getTotalBeads();
});

final lifetimeRoundsProvider = FutureProvider<int>((ref) async {
  final dao = ref.watch(chantSessionDaoProvider);
  return dao.getTotalRounds();
});
