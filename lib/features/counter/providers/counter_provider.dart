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

  const CounterState({
    this.beadCount = 0,
    this.roundsCompleted = 0,
    this.sessionBeads = 0,
    this.mode = CounterMode.standard,
    this.activeSessionId,
    this.sessionStartedAt,
  });

  CounterState copyWith({
    int? beadCount,
    int? roundsCompleted,
    int? sessionBeads,
    CounterMode? mode,
    int? activeSessionId,
    DateTime? sessionStartedAt,
  }) {
    return CounterState(
      beadCount: beadCount ?? this.beadCount,
      roundsCompleted: roundsCompleted ?? this.roundsCompleted,
      sessionBeads: sessionBeads ?? this.sessionBeads,
      mode: mode ?? this.mode,
      activeSessionId: activeSessionId ?? this.activeSessionId,
      sessionStartedAt: sessionStartedAt ?? this.sessionStartedAt,
    );
  }
}

class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier() : super(const CounterState());

  void increment() {
    final nextBead = state.beadCount + 1;

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
