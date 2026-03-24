import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/game.dart';
import '../../providers/audio_provider.dart';
import '../../providers/score_provider.dart';
import 'models/hangman_model.dart';
import 'data/word_database.dart';
import 'widgets/hangman_drawing.dart';
import 'widgets/word_display.dart';
import 'widgets/letter_keyboard.dart';

/// The game info file: Hangman
class HangmanGameInfo implements MiniGame {
  @override
  String get id => 'hangman';
  @override
  String get title => 'Hangman';
  @override
  String get description => 'Save the man by guessing the word!';
  @override
  IconData get icon => Icons.sentiment_very_dissatisfied;
  @override
  String get imagePath => "assets/images/Hangman/Hangman_1.jpg";

  @override
  Widget createScreen() => const HangmanGameScreen();
}

/// The main game file: Hangman
class HangmanGameScreen extends StatefulWidget {
  const HangmanGameScreen({super.key});

  @override
  State<HangmanGameScreen> createState() => _HangmanGameScreenState();
}

class _HangmanGameScreenState extends State<HangmanGameScreen> {
  // We use the Model to hold all the game data in one place
  late HangmanSession _currentSession;
  late WordCategory _currentCategory;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    // 1. Pick a random category from our Database
    _currentCategory = WordDatabase
        .categories[Random().nextInt(WordDatabase.categories.length)];

    // 2. Pick a random word from that category
    String randomWord =
        _currentCategory.words[Random().nextInt(_currentCategory.words.length)];

    setState(() {
      // 3. Create a NEW session model
      _currentSession = HangmanSession(
        targetWord: randomWord,
        guessedLetters: {},
      );
      _isInitialized = true;
    });
  }

  void _handleGuess(String letter) {
    if (_currentSession.isWon || _currentSession.isLost) return;

    // For adding sound effects
    final audio = Provider.of<AudioProvider>(context, listen: false);

    setState(() {
      _currentSession.guessedLetters.add(letter);

      if (_currentSession.isWon) {
        _processWin();
        audio.playHangman('win');
      } else if (_currentSession.isLost) {
        audio.playHangman('lose');
      } else if (!_currentSession.targetWord.contains(letter)) {
        audio.playHangman('wrong'); // The "pluh" sound!
      } else {
        audio.playHangman('click');
      }
    });
  }

  void _processWin() {
    // 1. Calculate the score
    // Example: 100 points base + 20 points for every life left
    int livesLeft = 6 - _currentSession.wrongGuessCount;
    int finalScore = 100 + (livesLeft * 20);

    // 2. Send it to the Provider
    // Use listen: false because we are inside a function, not the build method
    Provider.of<ScoreProvider>(
      context,
      listen: false,
    ).updateScore('hangman', finalScore);

    // 3. Optional: Show a little snackbar or celebration
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("New High Score: $finalScore!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Check game status using the logic built into our Model
    bool won = _currentSession.isWon;
    bool lost = _currentSession.isLost;
    bool gameOver = won || lost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _startNewGame),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Display category info from our WordCategory Model
          Text(
            "${_currentCategory.name} (${_currentCategory.difficulty.name.toUpperCase()})",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          // 1. Visual Drawing
          Expanded(
            flex: 3,
            child: Center(
              child: HangmanDrawing(
                wrongGuesses: _currentSession.wrongGuessCount,
              ),
            ),
          ),

          // 2. Word Display (The underscores)
          WordDisplay(
            targetWord: _currentSession.targetWord,
            guessedLetters: _currentSession.guessedLetters,
          ),

          const SizedBox(height: 20),

          // Game Status Message
          if (won)
            const Text(
              "🎉 YOU WON!",
              style: TextStyle(
                fontSize: 28,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (lost)
            Text(
              "💀 GAME OVER\nWord was: ${_currentSession.targetWord}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

          const Spacer(),

          // 3. Letter Keyboard
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: LetterKeyboard(
              guessedLetters: _currentSession.guessedLetters,
              onLetterGuessed: _handleGuess,
              isDisabled: gameOver,
            ),
          ),
        ],
      ),
    );
  }
}
