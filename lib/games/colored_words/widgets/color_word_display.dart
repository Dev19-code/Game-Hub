import 'package:flutter/material.dart';
import '../models/stroop_model.dart';

class ColorWordDisplay extends StatelessWidget {
  final StroopTrial trial;

  const ColorWordDisplay({super.key, required this.trial});

  @override
  Widget build(BuildContext context) {
    return Text(
      trial.text,
      style: TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
        color: trial.inkColor,
        letterSpacing: 4,
      ),
    );
  }
}
