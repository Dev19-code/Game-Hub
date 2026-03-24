import 'package:flutter/material.dart';

class ThermometerProgress extends StatelessWidget {
  final int? lastDifference;

  const ThermometerProgress({super.key, this.lastDifference});

  @override
  Widget build(BuildContext context) {
    // Logic: 0 difference = 100% full, 100 difference = 0% full
    double progress = lastDifference == null
        ? 0.0
        : (1.0 - (lastDifference! / 100)).clamp(0.0, 1.0);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 15,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 0.8
                  ? Colors.red
                  : (progress > 0.4 ? Colors.orange : Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Proximity Meter",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
