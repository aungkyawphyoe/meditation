import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bead_plans_table.dart';
import '../tables/gong_daw_details_table.dart';
import '../tables/plan_days_table.dart';
import '../tables/user_plan_progress_table.dart';

part 'plan_dao.g.dart';

@DriftAccessor(tables: [
  BeadPlansTable,
  GongDawDetailsTable,
  PlanDaysTable,
  UserPlanProgressTable,
])
class PlanDao extends DatabaseAccessor<AppDatabase> with _$PlanDaoMixin {
  PlanDao(super.db);

  Future<List<BeadPlan>> getAllPlans() {
    return select(beadPlansTable).get();
  }

  Future<BeadPlan?> getPlanById(int id) {
    return (select(beadPlansTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<PlanDay>> getPlanDays(int planId) {
    return (select(planDaysTable)..where((t) => t.planId.equals(planId)))
        .get();
  }

  Future<PlanDay?> getPlanDay(int planId, int dayNumber) {
    return (select(planDaysTable)
          ..where((t) => t.planId.equals(planId))
          ..where((t) => t.dayNumber.equals(dayNumber)))
        .getSingleOrNull();
  }

  Future<GongDawDetails?> getGongDawDetails(int id) {
    return (select(gongDawDetailsTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<GongDawDetails>> getAllGongDawDetails() {
    return select(gongDawDetailsTable).get();
  }

  Future<int> activatePlan(int userId, int planId) {
    return into(userPlanProgressTable).insert(UserPlanProgress(
      id: 0,
      userId: userId,
      planId: planId,
      currentDay: 1,
      status: 'active',
      startDate: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  }

  Future<UserPlanProgress?> getActivePlan(int userId) {
    return (select(userPlanProgressTable)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equals('active')))
        .getSingleOrNull();
  }

  Future<void> advanceDay(int progressId) async {
    final progress = await (select(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .getSingleOrNull();
    if (progress == null) return;
    await (update(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .write(UserPlanProgress(
      id: progress.id,
      userId: progress.userId,
      planId: progress.planId,
      currentDay: progress.currentDay + 1,
      status: progress.status,
      startDate: progress.startDate,
      updatedAt: DateTime.now(),
    ));
  }

  Future<void> completePlan(int progressId) async {
    final progress = await (select(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .getSingleOrNull();
    if (progress == null) return;
    await (update(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .write(UserPlanProgress(
      id: progress.id,
      userId: progress.userId,
      planId: progress.planId,
      currentDay: progress.currentDay,
      status: 'completed',
      startDate: progress.startDate,
      updatedAt: DateTime.now(),
    ));
  }

  Future<void> pausePlan(int progressId) async {
    final progress = await (select(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .getSingleOrNull();
    if (progress == null) return;
    await (update(userPlanProgressTable)
          ..where((t) => t.id.equals(progressId)))
        .write(UserPlanProgress(
      id: progress.id,
      userId: progress.userId,
      planId: progress.planId,
      currentDay: progress.currentDay,
      status: 'paused',
      startDate: progress.startDate,
      updatedAt: DateTime.now(),
    ));
  }

  Future<List<UserPlanProgress>> getAllUserProgress(int userId) {
    return (select(userPlanProgressTable)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }

  Future<int> addPlan(Insertable<BeadPlan> plan) async {
    return into(beadPlansTable).insert(plan);
  }

  Future<void> addPlanDay(Insertable<PlanDay> day) async {
    await into(planDaysTable).insert(day);
  }

  Future<int> addGongDawDetail(Insertable<GongDawDetails> detail) async {
    return into(gongDawDetailsTable).insert(detail);
  }

  Future<void> deletePlan(int planId) async {
    await (delete(beadPlansTable)..where((t) => t.id.equals(planId))).go();
  }

  Future<void> deletePlanDay(int dayId) async {
    await (delete(planDaysTable)..where((t) => t.id.equals(dayId))).go();
  }

  Future<void> updatePlanDayDayNumber(int dayId, int dayNumber) async {
    await (update(planDaysTable)..where((t) => t.id.equals(dayId)))
        .write(PlanDaysTableCompanion(
      dayNumber: Value(dayNumber),
    ));
  }
}
