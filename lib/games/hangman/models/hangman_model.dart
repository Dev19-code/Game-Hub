/// 1. The Category Model
/// Defines what a word group (like 'Animals' or 'Countries') contains.
class WordCategory {
  final String name;
  final List<String> words;
  final DifficultyLevel difficulty;

  const WordCategory({
    required this.name,
    required this.words,
    required this.difficulty,
  });
}

/// 2. Difficulty Levels
/// Used to label categories so the UI can show "Easy", "Medium", or "Hard".
enum DifficultyLevel { easy, medium, hard }

/// 3. The Session Model
/// This represents a single round of Hangman currently being played.
class HangmanSession {
  final String targetWord;
  final Set<String> guessedLetters;
  final int maxLives;

  HangmanSession({
    required this.targetWord,
    required this.guessedLetters,
    this.maxLives = 6,
  });

  // These "getters" calculate game status automatically based on the data above
  int get wrongGuessCount =>
      guessedLetters.where((letter) => !targetWord.contains(letter)).length;

  bool get isWon =>
      targetWord.split('').every((letter) => guessedLetters.contains(letter));

  bool get isLost => wrongGuessCount >= maxLives;
}
