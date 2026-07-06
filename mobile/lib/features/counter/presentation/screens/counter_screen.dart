import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/counter_provider.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/counter_display.dart';
import '../widgets/tap_to_count.dart';
import '../widgets/stats_display.dart';
import '../widgets/today_plan_detail.dart';
import '../widgets/completion_overlay.dart';
import '../widgets/action_buttons.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(counterProvider.select((s) => s.isTodayPlanComplete), (
      prev,
      next,
    ) {
      if (next && prev == false) {
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(counterProvider.notifier).completeTodayPlan();
        });
      }
    });

    ref.listen<AsyncValue<int>>(counterRoundsProvider, (prev, next) {
      if (prev == null || prev.isLoading) {
        next.whenData((rounds) {
          ref.read(counterProvider.notifier).setInitialRounds(rounds);
        });
      }
    });

    ref.listen<int>(counterProvider.select((s) => s.roundsCompleted), (
      prev,
      next,
    ) {
      if (prev != null && next == prev + 1) {
        final mode = ref.read(counterProvider.select((s) => s.mode));
        if (mode != CounterMode.continuous) {
          ref.read(userInfoDaoProvider).saveCompletedRound().then((_) {
            ref.invalidate(counterRoundsProvider);
            ref.invalidate(lifetimeRoundsProvider);
            ref.invalidate(userInfoProvider);
          });
        }
      }
    });

    final counterState = ref.watch(counterProvider);
    final hasActivePlan = ref.watch(hasActivePlanProvider);

    final showPlanButton =
        hasActivePlan && !counterState.isCompletedThisSession;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _Header(title: AppLocalizations.of(context)!.appTitle),
                if (counterState.isTodayPlanActive) ...[
                  const TodayPlanDetail(),
                ] else ...[
                  const Spacer(),
                ],
                const CounterDisplay(),
                const SizedBox(height: 8),
                const TapToCount(),
                const SizedBox(height: 8),
                const StatsDisplay(),
                const Spacer(),
              ],
            ),
          ),
          if (counterState.isTodayPlanComplete) const CompletionOverlay(),
          Positioned(
            left: 24,
            bottom: 24,
            child: ActionButtons(
              onReset: () => _handleReset(context, ref),
            ),
          ),
          if (showPlanButton)
            Positioned(
              right: 24,
              bottom: 24,
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => _handlePlanButton(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8400),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFFF8400).withOpacity(0.4),
                  ),
                  icon: Icon(
                    counterState.isTodayPlanActive
                        ? Icons.close
                        : Icons.play_arrow,
                    size: 20,
                  ),
                  label: Text(
                    counterState.isTodayPlanActive
                        ? AppLocalizations.of(context)!.exitTodayPlan
                        : AppLocalizations.of(context)!.startTodayPlan,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handlePlanButton(BuildContext context, WidgetRef ref) async {
    final state = ref.read(counterProvider);

    if (state.isTodayPlanActive) {
      ref.read(counterProvider.notifier).exitTodayPlan();
      return;
    }

    final user = await ref.read(userInfoProvider.future);
    if (user == null) return;

    final dao = ref.read(planDaoProvider);
    final activePlan = await dao.getActivePlan(user.id);
    if (activePlan == null) return;

    final plan = await dao.getPlanById(activePlan.planId);
    if (plan == null) return;

    final todayDay = await dao.getPlanDay(
      activePlan.planId,
      activePlan.currentDay,
    );
    if (todayDay == null) return;

    ref
        .read(counterProvider.notifier)
        .startTodayPlan(plan.title, plan.beadsPerRound, todayDay.targetRounds);
  }

  Future<void> _handleReset(BuildContext context, WidgetRef ref) async {
    ref.read(counterProvider.notifier).resetSession();
    await ref.read(userInfoDaoProvider).resetCounterRounds();
    ref.invalidate(counterRoundsProvider);
    ref.invalidate(lifetimeRoundsProvider);
    ref.invalidate(userInfoProvider);
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}
