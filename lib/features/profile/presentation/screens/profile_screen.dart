import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userInfoProvider);
    final beadsAsync = ref.watch(lifetimeBeadsProvider);
    final roundsAsync = ref.watch(lifetimeRoundsProvider);
    final sessionsAsync = ref.watch(recentSessionsProvider);

    return Scaffold(
      body: SafeArea(
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (user) => _buildContent(context, user!, beadsAsync, roundsAsync, sessionsAsync),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    UserInfo user,
    AsyncValue<int> beadsAsync,
    AsyncValue<int> roundsAsync,
    AsyncValue<List<ChantSession>> sessionsAsync,
  ) {
    final beads = beadsAsync.asData?.value ?? 0;
    final rounds = roundsAsync.asData?.value ?? 0;
    final sessions = sessionsAsync.asData?.value ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
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
                    '${user.rankTitle} • ${user.streakDays} Days Streak',
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
                  label: 'Total Beads',
                  value: formatNumber(beads),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Rounds',
                  value: formatNumber(rounds),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Recent Sessions',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: sessions.isEmpty
              ? const Center(
                  child: Text(
                    'No sessions yet',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final date = _formatDate(session.startedAt);
                    final value = session.mode == 'Continuous'
                        ? '${session.beadsCount} Beads'
                        : '${session.roundsCompleted} Rounds';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _SessionCard(
                        date: date,
                        mode: session.mode,
                        value: value,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final day = DateTime(dt.year, dt.month, dt.day);

    final amPm = dt.hour < 12 ? 'AM' : 'PM';
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final time = '$hour:${dt.minute.toString().padLeft(2, '0')} $amPm';

    if (day == today) return 'Today, $time';
    if (day == yesterday) return 'Yesterday, $time';
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dt.month - 1]} ${dt.day}, $time';
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

class _SessionCard extends StatelessWidget {
  final String date;
  final String mode;
  final String value;

  const _SessionCard({
    required this.date,
    required this.mode,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                mode,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8400),
            ),
          ),
        ],
      ),
    );
  }
}
