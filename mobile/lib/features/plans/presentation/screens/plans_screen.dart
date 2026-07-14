import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/active_plan_card.dart';
import '../widgets/bead_plan_card.dart';
import 'add_plan_screen.dart';
import 'plan_detail_screen.dart';

class PlansScreen extends ConsumerWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          scrolledUnderElevation: 0,
          title: const Text(
            'Plans',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E9E6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.foreground,
                unselectedLabelColor: const Color(0xFF888888),
                labelStyle: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.subscribed),
                  Tab(text: AppLocalizations.of(context)!.list),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [_SubscribedTab(), _ListTab()]),
      ),
    );
  }
}

class _SubscribedTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);
    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (user) {
        if (user == null) return const _EmptyState();
        final activePlanAsync = ref.watch(activePlanProvider(user.id));
        return activePlanAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (progress) {
            if (progress == null) {
              return const _EmptyState();
            }
            return _ActivePlanView(userId: user.id, progress: progress);
          },
        );
      },
    );
  }
}

class _ActivePlanView extends ConsumerWidget {
  final int userId;
  final UserPlanProgress progress;

  const _ActivePlanView({required this.userId, required this.progress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(planProvider(progress.planId));
    final planDaysAsync = ref.watch(planDaysProvider(progress.planId));
    final allDetailsAsync = ref.watch(allGongDawDetailsProvider);

    return planAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plan) {
        if (plan == null) return const _EmptyState();
        return planDaysAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (planDays) {
            final totalDays = planDays.length;
            final isLastDay = progress.currentDay > totalDays;
            final currentDayDetail = isLastDay
                ? null
                : planDays
                      .where((d) => d.dayNumber == progress.currentDay)
                      .firstOrNull;
            final gongDawName =
                currentDayDetail?.gongDawName ?? 'Day ${progress.currentDay}';
            final allDetails = allDetailsAsync.valueOrNull ?? [];
            final gongDawMeaning = currentDayDetail != null
                ? allDetails
                      .where((d) => d.id == currentDayDetail.gongDawId)
                      .firstOrNull
                      ?.meaning
                : null;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ActivePlanCard(
                    plan: plan,
                    progress: progress,
                    totalDays: totalDays,
                    currentDayDetail: currentDayDetail,
                    currentGongDawName: gongDawName,
                    gongDawMeaning: gongDawMeaning,
                    onCompleteDay: () =>
                        _handleCompleteDay(ref, progress, totalDays),
                    onCompletePlan: () =>
                        _handleCompletePlan(context, ref, progress),
                    onStopPlan: () => _handleStopPlan(context, ref, progress),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleCompleteDay(
    WidgetRef ref,
    UserPlanProgress progress,
    int totalDays,
  ) async {
    if (progress.currentDay > totalDays) return;
    final dao = ref.read(planDaoProvider);
    await dao.advanceDay(progress.id);
    ref.invalidate(activePlanProvider(userId));
  }

  Future<void> _handleCompletePlan(
    BuildContext context,
    WidgetRef ref,
    UserPlanProgress progress,
  ) async {
    final dao = ref.read(planDaoProvider);
    await dao.completePlan(progress.id);
    ref.invalidate(activePlanProvider(userId));
  }

  Future<void> _handleStopPlan(
    BuildContext context,
    WidgetRef ref,
    UserPlanProgress progress,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.stopPlan),
        content: Text(AppLocalizations.of(context)!.stopPlanConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
            ),
            child: Text(AppLocalizations.of(context)!.stop),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final dao = ref.read(planDaoProvider);
    await dao.failPlan(progress.id);
    ref.invalidate(activePlanProvider(userId));
    ref.invalidate(recentPlansProvider);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 64,
              color: AppColors.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.noActivePlan,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.noActivePlanSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(allPlansProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plans) {
          if (plans.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noPlansYetTab,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  color: Color(0xFF888888),
                ),
              ),
            );
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              final childAspectRatio = constraints.maxWidth > 600 ? 1.0 : 0.85;

              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return BeadPlanCard(
                    plan: plan,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlanDetailScreen(planId: plan.id),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPlanScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
