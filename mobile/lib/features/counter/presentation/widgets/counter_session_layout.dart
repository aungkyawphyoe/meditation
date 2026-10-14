import 'package:flutter/material.dart';

/// Presentation-only layout; counting and plan state belong to the caller.
class CounterSessionLayout extends StatelessWidget {
  const CounterSessionLayout({
    super.key,
    required this.title,
    required this.counter,
    required this.tapTarget,
    required this.stats,
    required this.reset,
    this.plan,
    this.planAction,
  });

  final Widget title;
  final Widget counter;
  final Widget tapTarget;
  final Widget stats;
  final Widget reset;
  final Widget? plan;
  final Widget? planAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide =
                  constraints.maxWidth >= 600 ||
                  (constraints.maxWidth >= 480 &&
                      constraints.maxWidth > constraints.maxHeight);
              final gap = constraints.maxHeight < 500 ? 8.0 : 16.0;
              final summary = Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (plan != null) ...[plan!, SizedBox(height: gap)],
                  counter,
                  SizedBox(height: gap),
                  if (!wide) ...[tapTarget, SizedBox(height: gap)],
                  stats,
                ],
              );

              return Column(
                children: [
                  // Scale only when a long translation cannot fit the header.
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: title,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: gap),
                      child: wide
                          ? Row(
                              children: [
                                Expanded(child: _fit(summary, 360)),
                                SizedBox(width: gap),
                                Expanded(child: _fit(tapTarget, 320)),
                              ],
                            )
                          : _fit(summary, constraints.maxWidth - gap * 2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(gap),
                    child: Row(
                      children: [
                        reset,
                        const SizedBox(width: 12),
                        if (planAction != null)
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: planAction,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Bound natural text wrapping before fitting to the available body height.
  // Actions stay outside this region, preserving their touch target sizes.
  Widget _fit(Widget child, double width) => Center(
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(width: width, child: child),
    ),
  );
}
