import 'dart:async';
import 'package:flutter/services.dart';
import '../features/counter/providers/counter_provider.dart';

class SyncData {
  final int beadCount;
  final int roundsCompleted;
  final CounterMode mode;

  const SyncData({
    required this.beadCount,
    required this.roundsCompleted,
    required this.mode,
  });
}

class WearCommunication {
  static const _channel = MethodChannel(
    'com.akp.meditation/communication',
  );

  static final StreamController<SyncData> _syncController =
      StreamController<SyncData>.broadcast();

  static Stream<SyncData> get syncDataStream => _syncController.stream;

  static Future<void> init() async {
    _channel.setMethodCallHandler(_handleMethodCall);
    await _channel.invokeMethod('init');
  }

  static Future<void> sendModeToWatch(CounterMode mode) async {
    await _channel.invokeMethod('sendMode', {'mode': mode.name});
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onSyncData':
        final args = call.arguments as Map<String, dynamic>;
        _syncController.add(
          SyncData(
            beadCount: args['beadCount'] as int,
            roundsCompleted: args['roundsCompleted'] as int,
            mode: CounterMode.values.firstWhere(
              (m) => m.name == args['mode'] as String,
            ),
          ),
        );
    }
  }
}
