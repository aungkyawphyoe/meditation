import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../daos/plan_dao.dart';
import '../database.dart';
import 'app_database_providers.dart';

final planDaoProvider = Provider<PlanDao>((ref) {
  return ref.watch(databaseProvider).planDao;
});

final allPlansProvider = FutureProvider<List<BeadPlan>>((ref) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getAllPlans();
});

final planProvider = FutureProvider.family<BeadPlan?, int>((ref, id) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getPlanById(id);
});

final planDaysProvider =
    FutureProvider.family<List<PlanDay>, int>((ref, planId) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getPlanDays(planId);
});

final activePlanProvider =
    FutureProvider.family<UserPlanProgress?, int>((ref, userId) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getActivePlan(userId);
});

final userPlanHistoryProvider =
    FutureProvider.family<List<UserPlanProgress>, int>((ref, userId) async {
  final dao = ref.watch(planDaoProvider);
  return dao.getAllUserProgress(userId);
});
