import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../counter/presentation/screens/counter_screen.dart';
import '../../../plans/presentation/screens/plans_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

final currentTabProvider = StateProvider<int>((ref) => 0);

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  static const _screens = [CounterScreen(), PlansScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(currentTabProvider);
    return Scaffold(
      body: _screens[currentTab],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withAlpha(26),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TabItem(
              icon: Icons.circle_outlined,
              activeIcon: Icons.circle,
              label: 'Counter',
              isActive: currentTab == 0,
              onTap: () => ref.read(currentTabProvider.notifier).state = 0,
            ),
            _TabItem(
              icon: Icons.calendar_today_outlined,
              activeIcon: Icons.calendar_today,
              label: 'Plans',
              isActive: currentTab == 1,
              onTap: () => ref.read(currentTabProvider.notifier).state = 1,
            ),
            _TabItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
              isActive: currentTab == 2,
              onTap: () => ref.read(currentTabProvider.notifier).state = 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? const Color(0xFFFF8400)
                  : const Color(0xFF666666),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? const Color(0xFFFF8400)
                    : const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
