import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../daos/plan_dao.dart';
import '../database.dart';
import '../models/plan_progress_summary.dart';
import 'app_database_providers.dart';

final planDaoProvider = Provider<PlanDao>((ref) {
  return ref.watch(databaseProvider).planDao;
});

final allGongDawDetailsProvider = FutureProvider<List<GongDawDetails>>((
  ref,
) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getAllGongDawDetails();
});

final allPlansProvider = FutureProvider<List<BeadPlan>>((ref) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getAllPlans();
});

final planProvider = FutureProvider.family<BeadPlan?, int>((ref, id) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getPlanById(id);
});

final planDaysProvider = FutureProvider.family<List<PlanDay>, int>((
  ref,
  planId,
) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getPlanDays(planId);
});

final activePlanProvider = FutureProvider.family<UserPlanProgress?, int>((
  ref,
  userId,
) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getActivePlan(userId);
});

final userPlanHistoryProvider =
    FutureProvider.family<List<UserPlanProgress>, int>((ref, userId) async {
      final dao = ref.watch(planDaoProvider);
      return dao.getAllUserProgress(userId);
    });

final hasActivePlanProvider = Provider<bool>((ref) {
  final user = ref.watch(userInfoProvider).valueOrNull;
  if (user == null) return false;
  final activePlan = ref.watch(activePlanProvider(user.id)).valueOrNull;
  return activePlan != null;
});

final completedPlansProvider = FutureProvider<int>((ref) async {
  final user = await ref.watch(userInfoProvider.future);
  if (user == null) return 0;
  final dao = ref.watch(planDaoProvider);
  return dao.getCompletedPlansCount(user.id);
});

final recentPlansProvider = FutureProvider<List<PlanProgressSummary>>((
  ref,
) async {
  final user = await ref.watch(userInfoProvider.future);
  if (user == null) return [];
  final dao = ref.watch(planDaoProvider);
  return dao.getRecentPlans(user.id);
});
