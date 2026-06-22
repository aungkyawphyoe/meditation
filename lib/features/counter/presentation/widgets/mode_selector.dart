import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../counter/providers/counter_provider.dart';

class ModeSelector extends ConsumerWidget {
  final void Function(CounterMode mode)? onModeChange;

  const ModeSelector({super.key, this.onModeChange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(counterProvider.select((s) => s.mode));
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE7E8E5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ModeTab(
              label: 'Standard (108)',
              isActive: mode == CounterMode.standard,
              onTap: () =>
                  _handleModeChange(context, ref, CounterMode.standard),
            ),
            _ModeTab(
              label: 'Short (8)',
              isActive: mode == CounterMode.short,
              onTap: () => _handleModeChange(context, ref, CounterMode.short),
            ),
            _ModeTab(
              label: 'Continuous',
              isActive: mode == CounterMode.continuous,
              onTap: () =>
                  _handleModeChange(context, ref, CounterMode.continuous),
            ),
          ],
        ),
      ),
    );
  }

  void _handleModeChange(
    BuildContext context,
    WidgetRef ref,
    CounterMode newMode,
  ) {
    final state = ref.read(counterProvider);
    if (state.mode == newMode) return;

    if (state.sessionBeads > 0) {
      onModeChange?.call(newMode);
      return;
    }

    ref.read(counterProvider.notifier).setMode(newMode);
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ModeTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF8400) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? const Color(0xFF111111) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}
