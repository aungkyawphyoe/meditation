import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/models/plan_progress_summary.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../../../../core/utils/rank_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);
    final plansAsync = ref.watch(completedPlansProvider);
    final recentPlansAsync = ref.watch(recentPlansProvider);

    return Scaffold(
      body: SafeArea(
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (user) => _buildContent(
            context,
            user!,
            plansAsync,
            recentPlansAsync,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    UserInfo user,
    AsyncValue<int> plansAsync,
    AsyncValue<List<PlanProgressSummary>> recentPlansAsync,
  ) {
    final plans = plansAsync.asData?.value ?? 0;
    final rounds = user.totalLifetimeRounds;
    final recentPlans = recentPlansAsync.asData?.value ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.profile,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFF666666),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8400),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (user.name.isNotEmpty ? user.name[0] : 'M').toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${localizedRankTitle(AppLocalizations.of(context)!, user.rankTitle)}',
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppLocalizations.of(context)!.daysStreak(user.streakDays)}',
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: AppLocalizations.of(context)!.totalPlans,
                  value: formatNumber(plans),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: AppLocalizations.of(context)!.rounds,
                  value: formatNumber(rounds),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppLocalizations.of(context)!.myPlans,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: recentPlans.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noPlansYet,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: recentPlans.length,
                  itemBuilder: (context, index) {
                    final plan = recentPlans[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _PlanCard(plan: plan),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String formatNumber(int n) {
    if (n >= 1000) {
      final rem = (n % 1000).toString().padLeft(3, '0');
      return '${n ~/ 1000},$rem';
    }
    return n.toString();
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF8400),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends ConsumerWidget {
  final PlanProgressSummary plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = plan.status == 'active';
    final isFailed = plan.status == 'failed';
    String statusLabel;
    Color statusColor;
    if (isActive) {
      statusLabel = AppLocalizations.of(context)!.active;
      statusColor = const Color(0xFFFF8400);
    } else if (isFailed) {
      statusLabel = AppLocalizations.of(context)!.failed;
      statusColor = const Color(0xFFEF4444);
    } else {
      statusLabel = AppLocalizations.of(context)!.success;
      statusColor = const Color(0xFF22C55E);
    }
    final daysText = isActive
        ? AppLocalizations.of(
            context,
          )!.dayOfTotal(plan.currentDay, plan.totalDays)
        : AppLocalizations.of(context)!.daysCount(plan.totalDays);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plan.title,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            plan.description,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              color: Color(0xFF666666),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            daysText,
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}
