import 'package:flutter/material.dart';

/// Represents a single guess and its proximity feedback
class GuessResult {
  final int value;
  final String feedback;
  final Color color;

  const GuessResult({
    required this.value,
    required this.feedback,
    required this.color,
  });
}

/// Helper to calculate the "Temperature" logic
class HotColdEngine {
  static GuessResult getFeedback(int guess, int secret) {
    // Calculate the absolute difference using math logic
    final int difference = (secret - guess).abs();

    if (difference == 0) {
      return const GuessResult(
        value: 0,
        feedback: "🎉 PERFECT!",
        color: Colors.green,
      );
    } else if (difference >= 50) {
      return const GuessResult(
        value: 50,
        feedback: "❄️ Freezing Cold",
        color: Color(0xFF0D47A1),
      );
    } else if (difference >= 30) {
      return const GuessResult(
        value: 30,
        feedback: "🥶 Cold",
        color: Colors.blue,
      );
    } else if (difference >= 20) {
      return const GuessResult(
        value: 20,
        feedback: "😐 Cool",
        color: Colors.teal,
      );
    } else if (difference >= 10) {
      return const GuessResult(
        value: 10,
        feedback: "🙂 Warm",
        color: Colors.orangeAccent,
      );
    } else if (difference >= 5) {
      return const GuessResult(
        value: 5,
        feedback: "🔥 Hot",
        color: Colors.orange,
      );
    } else {
      return const GuessResult(
        value: 1,
        feedback: "🥵 Very Hot!",
        color: Colors.red,
      );
    }
  }
}
