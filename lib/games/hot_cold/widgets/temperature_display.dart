import 'package:flutter/material.dart';
import '../models/hot_cold_model.dart';

class TemperatureDisplay extends StatelessWidget {
  final GuessResult? lastGuess;

  const TemperatureDisplay({super.key, this.lastGuess});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            lastGuess?.color.withValues(alpha: 0.2) ??
            Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lastGuess?.color ?? Colors.grey, width: 2),
      ),
      child: Column(
        children: [
          Text(
            lastGuess?.feedback ?? "Start Guessing!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: lastGuess?.color ?? Colors.grey,
            ),
          ),
          if (lastGuess != null) ...[
            const SizedBox(height: 10),
            Text(
              "Last Guess: ${lastGuess!.value}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ],
      ),
    );
  }
}
