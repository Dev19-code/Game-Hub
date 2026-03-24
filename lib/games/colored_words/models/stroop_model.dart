import 'package:flutter/material.dart';

/// Defines a single challenge in the game
class StroopTrial {
  final String text; // The word written (e.g., "RED")
  final Color inkColor; // The actual color of the ink
  final String colorName; // The name of the ink color (for comparison)

  const StroopTrial({
    required this.text,
    required this.inkColor,
    required this.colorName,
  });
}

/// Tracks the statistics of the current game session
class StroopSession {
  int score = 0;
  int totalAttempts = 0;
  int correctAnswers = 0;

  double get accuracy =>
      totalAttempts == 0 ? 0.0 : (correctAnswers / totalAttempts) * 100;

  void recordAnswer(bool isCorrect) {
    totalAttempts++;
    if (isCorrect) {
      correctAnswers++;
      score += 10;
    } else {
      score = (score - 5).clamp(0, 9999); // Don't go below 0
    }
  }
}
