import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
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
        backgroundColor: const Color(0xFFF2F3F0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F3F0),
          scrolledUnderElevation: 0,
          title: const Text(
            'Plans',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
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
                labelColor: const Color(0xFF111111),
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
                tabs: const [
                  Tab(text: 'Subscribed'),
                  Tab(text: 'List'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _SubscribedTab(),
            _ListTab(),
          ],
        ),
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
                : planDays.where((d) => d.dayNumber == progress.currentDay).firstOrNull;
            final gongDawName = currentDayDetail?.gongDawName ?? 'Day ${progress.currentDay}';

            return SingleChildScrollView(
              child: Column(
                children: [
                  ActivePlanCard(
                    plan: plan,
                    progress: progress,
                    totalDays: totalDays,
                    currentDayDetail: currentDayDetail,
                    currentGongDawName: gongDawName,
                    onCompleteDay: () => _handleCompleteDay(ref, progress, totalDays),
                    onCompletePlan: () => _handleCompletePlan(context, ref, progress),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleCompleteDay(WidgetRef ref, UserPlanProgress progress, int totalDays) async {
    if (progress.currentDay > totalDays) return;
    final dao = ref.read(planDaoProvider);
    await dao.advanceDay(progress.id);
    ref.invalidate(activePlanProvider(userId));
  }

  Future<void> _handleCompletePlan(BuildContext context, WidgetRef ref, UserPlanProgress progress) async {
    final dao = ref.read(planDaoProvider);
    await dao.completePlan(progress.id);
    ref.invalidate(activePlanProvider(userId));
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
              color: const Color(0xFFFF8400).withOpacity(0.3),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Active Plan',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Browse the List tab to find\na plan that speaks to you',
              textAlign: TextAlign.center,
              style: TextStyle(
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
      backgroundColor: const Color(0xFFF2F3F0),
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plans) {
          if (plans.isEmpty) {
            return const Center(
              child: Text(
                'No plans yet. Tap + to create one.',
                style: TextStyle(
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
        backgroundColor: const Color(0xFFFF8400),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
