import 'package:flutter/material.dart';

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
  static const int beadsPerRound = 108;
  int _beadCount = 0;
  int _roundCount = 0;

  void _incrementBead() {
    setState(() {
      _beadCount++;
      if (_beadCount >= beadsPerRound) {
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

  void _syncWithMobile() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Syncing beads: $_beadCount, rounds: $_roundCount'),
        duration: const Duration(seconds: 2),
      ),
    );
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
                    Text(
                      '/ $beadsPerRound',
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
