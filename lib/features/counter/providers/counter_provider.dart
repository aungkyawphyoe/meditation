import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CounterMode { standard, short, continuous }

extension CounterModeX on CounterMode {
  int get max {
    return switch (this) {
      CounterMode.standard => 108,
      CounterMode.short => 8,
      CounterMode.continuous => -1,
    };
  }

  String get label {
    return switch (this) {
      CounterMode.standard => 'Standard (108)',
      CounterMode.short => 'Short (8)',
      CounterMode.continuous => 'Continuous',
    };
  }
}

class CounterState {
  final int beadCount;
  final int roundsCompleted;
  final int sessionBeads;
  final CounterMode mode;
  final int? activeSessionId;
  final DateTime? sessionStartedAt;
  final bool isTodayPlanActive;
  final bool isTodayPlanComplete;
  final bool isCompletedThisSession;
  final String? planName;
  final int? planBeadsPerRound;
  final int? planTargetRounds;

  const CounterState({
    this.beadCount = 0,
    this.roundsCompleted = 0,
    this.sessionBeads = 0,
    this.mode = CounterMode.standard,
    this.activeSessionId,
    this.sessionStartedAt,
    this.isTodayPlanActive = false,
    this.isTodayPlanComplete = false,
    this.isCompletedThisSession = false,
    this.planName,
    this.planBeadsPerRound,
    this.planTargetRounds,
  });

  CounterState copyWith({
    int? beadCount,
    int? roundsCompleted,
    int? sessionBeads,
    CounterMode? mode,
    int? activeSessionId,
    DateTime? sessionStartedAt,
    bool? isTodayPlanActive,
    bool? isTodayPlanComplete,
    bool? isCompletedThisSession,
    String? planName,
    int? planBeadsPerRound,
    int? planTargetRounds,
  }) {
    return CounterState(
      beadCount: beadCount ?? this.beadCount,
      roundsCompleted: roundsCompleted ?? this.roundsCompleted,
      sessionBeads: sessionBeads ?? this.sessionBeads,
      mode: mode ?? this.mode,
      activeSessionId: activeSessionId ?? this.activeSessionId,
      sessionStartedAt: sessionStartedAt ?? this.sessionStartedAt,
      isTodayPlanActive: isTodayPlanActive ?? this.isTodayPlanActive,
      isTodayPlanComplete:
          isTodayPlanComplete ?? this.isTodayPlanComplete,
      isCompletedThisSession:
          isCompletedThisSession ?? this.isCompletedThisSession,
      planName: planName ?? this.planName,
      planBeadsPerRound: planBeadsPerRound ?? this.planBeadsPerRound,
      planTargetRounds: planTargetRounds ?? this.planTargetRounds,
    );
  }
}

class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier() : super(const CounterState());

  void increment() {
    final nextBead = state.beadCount + 1;

    if (state.planBeadsPerRound != null) {
      if (nextBead >= state.planBeadsPerRound!) {
        final newRounds = state.roundsCompleted + 1;
        state = state.copyWith(
          beadCount: 0,
          roundsCompleted: newRounds,
          sessionBeads: state.sessionBeads + 1,
          isTodayPlanComplete: newRounds >= state.planTargetRounds!,
        );
      } else {
        state = state.copyWith(
          beadCount: nextBead,
          sessionBeads: state.sessionBeads + 1,
        );
      }
      return;
    }

    if (state.mode == CounterMode.continuous) {
      state = state.copyWith(
        beadCount: nextBead,
        sessionBeads: state.sessionBeads + 1,
      );
      return;
    }

    if (nextBead >= state.mode.max) {
      state = state.copyWith(
        beadCount: 0,
        roundsCompleted: state.roundsCompleted + 1,
        sessionBeads: state.sessionBeads + 1,
      );
    } else {
      state = state.copyWith(
        beadCount: nextBead,
        sessionBeads: state.sessionBeads + 1,
      );
    }
  }

  void decrement() {
    if (state.beadCount <= 0) return;
    state = state.copyWith(
      beadCount: state.beadCount - 1,
      sessionBeads: (state.sessionBeads - 1).clamp(0, state.sessionBeads),
    );
  }

  void reset() {
    state = const CounterState(mode: CounterMode.standard);
  }

  void setMode(CounterMode mode) {
    if (state.mode == mode) return;
    state = CounterState(mode: mode);
  }

  void startTodayPlan(String planName, int beadsPerRound, int targetRounds) {
    state = state.copyWith(
      isTodayPlanActive: true,
      isTodayPlanComplete: false,
      isCompletedThisSession: false,
      planName: planName,
      planBeadsPerRound: beadsPerRound,
      planTargetRounds: targetRounds,
      beadCount: 0,
      roundsCompleted: 0,
      sessionBeads: 0,
    );
  }

  void exitTodayPlan() {
    state = state.copyWith(
      isTodayPlanActive: false,
      isTodayPlanComplete: false,
      planName: null,
      planBeadsPerRound: null,
      planTargetRounds: null,
    );
  }

  void completeTodayPlan() {
    state = state.copyWith(
      isTodayPlanActive: false,
      isTodayPlanComplete: false,
      isCompletedThisSession: true,
      planName: null,
      planBeadsPerRound: null,
      planTargetRounds: null,
    );
  }

  void startSession(int sessionId, DateTime startedAt) {
    state = state.copyWith(activeSessionId: sessionId, sessionStartedAt: startedAt);
  }

  void clearSession() {
    state = state.copyWith(activeSessionId: null, sessionStartedAt: null);
  }
}

final counterProvider =
    StateNotifierProvider<CounterNotifier, CounterState>((ref) {
  return CounterNotifier();
});
