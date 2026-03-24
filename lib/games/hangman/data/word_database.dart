import '../models/hangman_model.dart';

class WordDatabase {
  // Now, instead of a Map, we have a strictly typed List of WordCategory objects!
  static const List<WordCategory> categories = [
    WordCategory(
      name: 'Flutter',
      difficulty: DifficultyLevel.medium,
      words: ['WIDGET', 'STATE', 'PROVIDER', 'SCAFFOLD', 'MATERIAL'],
    ),
    WordCategory(
      name: 'Animals',
      difficulty: DifficultyLevel.easy,
      words: ['ELEPHANT', 'GIRAFFE', 'PENGUIN', 'KANGAROO', 'DOLPHIN'],
    ),
    WordCategory(
      name: 'Countries',
      difficulty: DifficultyLevel.hard,
      words: ['BRAZIL', 'JAPAN', 'CANADA', 'AUSTRALIA', 'EGYPT'],
    ),
  ];

  // A helper method to easily grab a random category
  static WordCategory getRandomCategory() {
    categories.shuffle();
    return categories.first;
  }
}
