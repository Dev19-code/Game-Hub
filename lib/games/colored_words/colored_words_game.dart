import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/game.dart';
import '../../providers/audio_provider.dart';
import '../../providers/score_provider.dart';
import 'models/stroop_model.dart';
import 'widgets/color_word_display.dart';
import 'widgets/color_buttons.dart';

/// The game info file: ColoredWords
class ColoredWordsGameInfo implements MiniGame {
  @override
  String get id => 'colored_words';
  @override
  String get title => 'Stroop Test';
  @override
  String get description => 'Dont let your brain trick you!';
  @override
  IconData get icon => Icons.palette;
  @override
  String get imagePath => "assets/images/ColouredWords/Stroop_1.png";

  @override
  Widget createScreen() => const ColoredWordsGameScreen();
}

/// The main game file: ColoredWords
class ColoredWordsGameScreen extends StatefulWidget {
  const ColoredWordsGameScreen({super.key});

  @override
  State<ColoredWordsGameScreen> createState() => _ColoredWordsGameScreenState();
}

class _ColoredWordsGameScreenState extends State<ColoredWordsGameScreen> {
  final Map<String, Color> _colors = {
    'RED': Colors.red,
    'BLUE': Colors.blue,
    'GREEN': Colors.green,
    'YELLOW': Colors.amber,
    'PURPLE': Colors.purple,
    'ORANGE': Colors.brown,
  };

  late StroopSession _session;
  StroopTrial? _currentTrial;
  int _timeLeft = 30;
  Timer? _timer;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _session = StroopSession();
  }

  void _startGame() {
    setState(() {
      _session = StroopSession();
      _timeLeft = 30;
      _isActive = true;
      _generateTrial();
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
        _handleGameOver(); // Trigger score saving when time runs out
      }
    });
  }

  void _handleGameOver() {
    setState(() {
      _isActive = false;
    });

    // Save the score from the StroopSession model
    Provider.of<ScoreProvider>(
      context,
      listen: false,
    ).updateScore('colored_words', _session.score);
  }

  void _generateTrial() {
    final random = Random();
    final keys = _colors.keys.toList();

    String text = keys[random.nextInt(keys.length)];
    // Ink color is often different from the text to create the Stroop effect
    String colorName = keys[random.nextInt(keys.length)];

    setState(() {
      _currentTrial = StroopTrial(
        text: text,
        inkColor: _colors[colorName]!,
        colorName: colorName,
      );
    });
  }

  void _handleChoice(String chosenColorName) {
    if (!_isActive) return;

    // 1. Grab the Audio Provider
    final audio = Provider.of<AudioProvider>(context, listen: false);

    setState(() {
      bool isCorrect = chosenColorName == _currentTrial!.colorName;

      // 2. Play the correct or wrong sound immediately
      audio.playStroop(isCorrect: isCorrect);

      _session.recordAnswer(isCorrect);
      _generateTrial();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stroop Test')),
      body: Center(child: _isActive ? _buildPlayArea() : _buildStartScreen()),
    );
  }

  Widget _buildStartScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.psychology, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        const Text(
          "Tap the color of the ink,\nnot the word!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        if (_session.totalAttempts > 0) ...[
          const SizedBox(height: 30),
          Text(
            "Last Score: ${_session.score}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("Accuracy: ${_session.accuracy.toStringAsFixed(1)}%"),
        ],
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _startGame, child: const Text("START GAME")),
      ],
    );
  }

  Widget _buildPlayArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Score: ${_session.score}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Time: $_timeLeft",
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
        if (_currentTrial != null) ColorWordDisplay(trial: _currentTrial!),
        ColorButtons(colorOptions: _colors, onColorSelected: _handleChoice),
      ],
    );
  }
}
