import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreProvider extends ChangeNotifier {
  // A map to store high scores by game ID: {'hangman': 150, 'hot_cold': 10}
  Map<String, int> _highScores = {};

  Map<String, int> get highScores => _highScores;

  ScoreProvider() {
    _loadScores(); // Load scores as soon as the provider is created
  }

  // Get high score for a specific game
  int getHighScore(String gameId) => _highScores[gameId] ?? 0;

  // Attempt to update a score
  Future<void> updateScore(String gameId, int newScore) async {
    final currentHigh = getHighScore(gameId);

    // Only update if the new score is actually higher
    if (newScore > currentHigh) {
      _highScores[gameId] = newScore;
      notifyListeners();
      await _saveScores();
    }
  }

  // --- PERSISTENCE LOGIC ---

  Future<void> _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? scoresJson = prefs.getString('high_scores');

    if (scoresJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(scoresJson);
      _highScores = decoded.map((key, value) => MapEntry(key, value as int));
      notifyListeners();
    }
  }

  Future<void> _saveScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_highScores);
    await prefs.setString('high_scores', encoded);
  }

  Future<void> clearAllScores() async {
    _highScores.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('high_scores');
  }
}
