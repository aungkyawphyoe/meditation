import 'package:flutter/material.dart';
import 'services/wear_communication.dart';

void main() {
  runApp(const MeditationWatchApp());
}

class MeditationWatchApp extends StatelessWidget {
  const MeditationWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Watch',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MeditationHomePage(),
    );
  }
}

class MeditationHomePage extends StatefulWidget {
  const MeditationHomePage({super.key});

  @override
  State<MeditationHomePage> createState() => _MeditationHomePageState();
}

class _MeditationHomePageState extends State<MeditationHomePage> {
  CounterMode _mode = CounterMode.standard;
  int _beadCount = 0;
  int _roundCount = 0;

  int get _beadsPerRound {
    return switch (_mode) {
      CounterMode.standard => 108,
      CounterMode.short => 8,
      CounterMode.continuous => -1,
    };
  }

  @override
  void initState() {
    super.initState();
    _initCommunication();
  }

  Future<void> _initCommunication() async {
    await WearCommunication.init();
    WearCommunication.modeStream.listen((mode) {
      if (!mounted) return;
      setState(() {
        _mode = mode;
        _beadCount = 0;
        _roundCount = 0;
      });
    });
  }

  void _incrementBead() {
    setState(() {
      _beadCount++;
      if (_beadsPerRound > 0 && _beadCount >= _beadsPerRound) {
        _beadCount = 0;
        _roundCount++;
      }
    });
  }

  void _reset() {
    setState(() {
      _beadCount = 0;
      _roundCount = 0;
    });
  }

  Future<void> _syncWithMobile() async {
    if (!mounted) return;

    final modeName = _mode.name;
    try {
      await WearCommunication.sendSyncData(
        beadCount: _beadCount,
        roundsCompleted: _roundCount,
        mode: modeName,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Synced: $_beadCount beads, $_roundCount rounds'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sync failed. Make sure phone app is running.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size.shortestSide;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: size * 0.75,
              height: size * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: _incrementBead,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$_beadCount',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_beadsPerRound > 0)
                      Text(
                        '/ $_beadsPerRound',
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Rounds: $_roundCount',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: FloatingActionButton.small(
              heroTag: 'reset',
              onPressed: _reset,
              child: const Icon(Icons.refresh),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: FloatingActionButton.small(
              heroTag: 'sync',
              onPressed: _syncWithMobile,
              child: const Icon(Icons.sync),
            ),
          ),
        ],
      ),
    );
  }
}
