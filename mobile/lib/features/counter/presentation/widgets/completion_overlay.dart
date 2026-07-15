import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_theme.dart';

class CompletionOverlay extends StatefulWidget {
  const CompletionOverlay({super.key});

  @override
  State<CompletionOverlay> createState() => _CompletionOverlayState();
}

class _CompletionOverlayState extends State<CompletionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        color: colors.foreground.withValues(alpha:0.54),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnim,
            child: AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: colors.primary,
                    size: 72,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.todayPlanComplete,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: colors.foreground,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppLabel(
                    text: AppLocalizations.of(context)!.allRoundsCompleted,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
