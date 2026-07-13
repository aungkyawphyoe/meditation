import 'dart:async';
import 'package:flutter/services.dart';

enum CounterMode { standard, short, continuous }

class WearCommunication {
  static const _channel = MethodChannel(
    'com.akp.meditation.wear/communication',
  );

  static final StreamController<CounterMode> _modeController =
      StreamController<CounterMode>.broadcast();

  static Stream<CounterMode> get modeStream => _modeController.stream;

  static Future<void> init() async {
    _channel.setMethodCallHandler(_handleMethodCall);
    await _channel.invokeMethod('init');
  }

  static Future<void> sendSyncData({
    required int beadCount,
    required int roundsCompleted,
    required String mode,
  }) async {
    await _channel.invokeMethod('sendSyncData', {
      'beadCount': beadCount,
      'roundsCompleted': roundsCompleted,
      'mode': mode,
    });
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onModeUpdate':
        final mode = call.arguments as String;
        _modeController.add(
          CounterMode.values.firstWhere((m) => m.name == mode),
        );
    }
  }
}
