import 'package:drift/drift.dart';
import '../../utils/rank_utils.dart';
import '../database.dart';
import '../tables/user_info_table.dart';

part 'user_info_dao.g.dart';

@DriftAccessor(tables: [UserInfoTable])
class UserInfoDao extends DatabaseAccessor<AppDatabase>
    with _$UserInfoDaoMixin {
  UserInfoDao(super.db);

  Future<UserInfo?> getUser() {
    return (select(userInfoTable)..limit(1)).getSingleOrNull();
  }

  Future<void> upsertUser(UserInfo user) {
    return into(userInfoTable).insertOnConflictUpdate(user);
  }

  Future<void> updateLifetimeStats({
    required int totalBeads,
    required int totalRounds,
  }) async {
    final user = await getUser();
    if (user == null) return;
    await upsertUser(
      user.copyWith(
        totalLifetimeBeads: totalBeads,
        totalLifetimeRounds: totalRounds,
        rankTitle: rankForRounds(totalRounds),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> updateDefaultMode(String mode) async {
    final user = await getUser();
    if (user == null) return;
    await upsertUser(
      user.copyWith(defaultMode: mode, updatedAt: DateTime.now()),
    );
  }

  Future<int> getCounterRounds() async {
    final user = await getUser();
    return user?.counterRounds ?? 0;
  }

  Future<void> saveCompletedRound() async {
    final user = await getUser();
    if (user == null) return;
    final newCounterRounds = user.counterRounds + 1;
    final newLifetimeRounds = user.totalLifetimeRounds + 1;
    await upsertUser(
      user.copyWith(
        counterRounds: newCounterRounds,
        totalLifetimeRounds: newLifetimeRounds,
        rankTitle: rankForRounds(newLifetimeRounds),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> resetCounterRounds() async {
    final user = await getUser();
    if (user == null) return;
    await upsertUser(
      user.copyWith(
        counterRounds: 0,
        updatedAt: DateTime.now(),
      ),
    );
  }
}
