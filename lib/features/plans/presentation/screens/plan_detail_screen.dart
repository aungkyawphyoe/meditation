import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../widgets/day_list_tile.dart';

class PlanDetailScreen extends ConsumerWidget {
  final int planId;

  const PlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(planProvider(planId));
    final planDaysAsync = ref.watch(planDaysProvider(planId));
    final userAsync = ref.watch(userInfoProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F0),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Plan Details',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111111),
          ),
        ),
      ),
      body: planAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) {
          if (plan == null) {
            return const Center(child: Text('Plan not found'));
          }
          return planDaysAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (planDays) {
              return userAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (user) {
                  return _PlanDetailContent(
                    plan: plan,
                    planDays: planDays,
                    userId: user?.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PlanDetailContent extends ConsumerWidget {
  final BeadPlan plan;
  final List<PlanDay> planDays;
  final int? userId;

  const _PlanDetailContent({
    required this.plan,
    required this.planDays,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePlanAsync = ref.watch(activePlanProvider(userId ?? -1));

    return activePlanAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (activeProgress) {
        final isThisPlanActive = activeProgress?.planId == plan.id;
        final isCompleted = !isThisPlanActive &&
            (activeProgress?.status == 'completed');

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (plan.isPredefined)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8400).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'PREDEFINED',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF8400),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          plan.title,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${plan.beadsPerRound} beads per round · ${planDays.length} days',
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        if (plan.description.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            plan.description,
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF666666),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Days',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...planDays.asMap().entries.map((entry) {
                    final day = entry.value;
                    final dayNum = entry.key + 1;
                    final isCurrent = isThisPlanActive && activeProgress!.currentDay == dayNum;
                    final isCompletedDay = isThisPlanActive && activeProgress!.currentDay > dayNum;

                    return DayListTile(
                      dayNumber: dayNum,
                      planDay: day,
                      gongDawName: 'Gong/Daw #${day.gongDawId}',
                      isCurrentDay: isCurrent,
                      isCompleted: isCompletedDay,
                    );
                  }),
                ],
              ),
            ),
            _BottomAction(
              isThisPlanActive: isThisPlanActive,
              isCompleted: isCompleted,
              onStart: userId != null
                  ? () => _startPlan(context, ref, userId!)
                  : null,
              onCompleteDay: isThisPlanActive && activeProgress != null
                  ? () => _advanceDay(context, ref, activeProgress, planDays.length)
                  : null,
              onCompletePlan: isThisPlanActive && activeProgress != null
                  ? () => _finishPlan(context, ref, activeProgress)
                  : null,
            ),
          ],
        );
      },
    );
  }

  Future<void> _startPlan(BuildContext context, WidgetRef ref, int uid) async {
    final dao = ref.read(planDaoProvider);
    final existingProgress = await dao.getActivePlan(uid);
    if (existingProgress != null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You already have an active plan. Complete or pause it first.')),
      );
      return;
    }
    await dao.activatePlan(uid, plan.id);
    ref.invalidate(activePlanProvider(uid));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan activated!')),
      );
    }
  }

  Future<void> _advanceDay(
    BuildContext context, WidgetRef ref,
    UserPlanProgress progress, int totalDays,
  ) async {
    if (progress.currentDay >= totalDays) return;
    final dao = ref.read(planDaoProvider);
    await dao.advanceDay(progress.id);
    ref.invalidate(activePlanProvider(userId!));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Day ${progress.currentDay} complete!')),
      );
    }
  }

  Future<void> _finishPlan(
    BuildContext context, WidgetRef ref,
    UserPlanProgress progress,
  ) async {
    final dao = ref.read(planDaoProvider);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Complete Plan'),
        content: const Text('Are you sure you want to mark this plan as complete?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await dao.completePlan(progress.id);
    ref.invalidate(activePlanProvider(userId!));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan completed! Great work.')),
      );
      Navigator.pop(context);
    }
  }
}

class _BottomAction extends StatelessWidget {
  final bool isThisPlanActive;
  final bool isCompleted;
  final VoidCallback? onStart;
  final VoidCallback? onCompleteDay;
  final VoidCallback? onCompletePlan;

  const _BottomAction({
    required this.isThisPlanActive,
    required this.isCompleted,
    this.onStart,
    this.onCompleteDay,
    this.onCompletePlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: isCompleted
              ? null
              : isThisPlanActive
                  ? onCompletePlan ?? onCompleteDay
                  : onStart,
          style: TextButton.styleFrom(
            backgroundColor: isCompleted
                ? const Color(0xFFE0E0E0)
                : const Color(0xFFFF8400),
            foregroundColor: isCompleted
                ? const Color(0xFF999999)
                : Colors.white,
            disabledBackgroundColor: const Color(0xFFE0E0E0),
            disabledForegroundColor: const Color(0xFF999999),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isCompleted
                ? 'Completed'
                : isThisPlanActive
                    ? 'Complete Plan'
                    : 'Start This Plan',
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
