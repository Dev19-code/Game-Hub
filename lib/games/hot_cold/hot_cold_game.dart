import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/game.dart';
import '../../providers/audio_provider.dart';
import '../../providers/score_provider.dart';
import 'models/hot_cold_model.dart';
import 'widgets/temperature_display.dart';
import 'widgets/thermometer_progress.dart';

/// The info game file: HotorCold
class HotColdGameInfo implements MiniGame {
  @override
  String get id => 'hot_cold';
  @override
  String get title => 'Hot or Cold';
  @override
  String get description => 'Can you find the secret number?';
  @override
  IconData get icon => Icons.thermostat;
  @override
  String get imagePath => "assets/images/HotCold/HotCold_1.png";

  @override
  Widget createScreen() => const HotColdGameScreen();
}

/// The main game file: HotorCold
class HotColdGameScreen extends StatefulWidget {
  const HotColdGameScreen({super.key});

  @override
  State<HotColdGameScreen> createState() => _HotColdGameScreenState();
}

class _HotColdGameScreenState extends State<HotColdGameScreen> {
  late int _secretNumber;
  final TextEditingController _controller = TextEditingController();
  final List<GuessResult> _history = [];
  bool _hasWon = false;
  int? _lastDiff;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _secretNumber = Random().nextInt(100) + 1;
      _history.clear();
      _hasWon = false;
      _lastDiff = null;
      _controller.clear();
    });
  }

  void _submitGuess() {
    final int? guess = int.tryParse(_controller.text);
    if (guess == null || guess < 1 || guess > 100 || _hasWon) return;

    // 1. Grab the Audio Provider
    final audio = Provider.of<AudioProvider>(context, listen: false);

    setState(() {
      final result = HotColdEngine.getFeedback(guess, _secretNumber);
      final int currentDiff = (_secretNumber - guess)
          .abs(); // Calculate current distance

      // 2. Sound Logic: Compare current distance to the last distance
      if (guess == _secretNumber) {
        audio.playHotCold(isHot: true); // Winning is the "Hottest" you can be!
      } else if (_lastDiff != null) {
        // If the current difference is smaller than the last, play 'fire'
        bool isGettingWarmer = currentDiff < _lastDiff!;
        audio.playHotCold(isHot: isGettingWarmer);
      }

      _history.insert(0, result);
      _lastDiff = currentDiff; // Update our tracker for the NEXT guess

      if (guess == _secretNumber) {
        _hasWon = true;
        _processWin();
      }
      _controller.clear();
    });
  }

  void _processWin() {
    // Score Logic: Start with 100 points, subtract 5 for every wrong guess.
    // Minimum score of 10 points for eventually getting it.
    int attemptPenalty = (_history.length - 1) * 5;
    int finalScore = (100 - attemptPenalty).clamp(10, 100);

    Provider.of<ScoreProvider>(
      context,
      listen: false,
    ).updateScore('hot_cold', finalScore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hot or Cold')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TemperatureDisplay(
              lastGuess: _history.isNotEmpty ? _history.first : null,
            ),
            const SizedBox(height: 20),
            ThermometerProgress(lastDifference: _lastDiff),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    enabled: _hasWon ? false : true,
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter 1-100",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _submitGuess(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _hasWon ? null : _submitGuess,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 55),
                  ),
                  child: const Text("GUESS"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_hasWon)
              ElevatedButton.icon(
                onPressed: _startNewGame,
                icon: const Icon(Icons.refresh),
                label: const Text("Play Again"),
              ),
            const Divider(height: 40),
            const Text(
              "Guess History",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final res = _history[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: res.color,
                      child: Text(
                        "${res.value}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      res.feedback,
                      style: TextStyle(color: res.color),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
