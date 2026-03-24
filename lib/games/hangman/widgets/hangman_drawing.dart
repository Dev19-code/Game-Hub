import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  final int wrongGuesses;

  const HangmanDrawing({super.key, required this.wrongGuesses});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 250),
      painter: _HangmanPainter(wrongGuesses),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  final int wrongGuesses;
  _HangmanPainter(this.wrongGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    // For the basic shapes
    final paint = Paint()
      ..color = Colors.brown.shade600
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // For the Body of the Hangman
    final paintBody = Paint()
      ..color = Colors.green
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Base and Gallows (Always drawn)
    canvas.drawLine(
      Offset(size.width * 0.1, size.height),
      Offset(size.width * 0.9, size.height),
      paint,
    ); // Base
    canvas.drawLine(
      Offset(size.width * 0.3, size.height),
      Offset(size.width * 0.3, size.height * 0.1),
      paint,
    ); // Pole
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.1),
      Offset(size.width * 0.7, size.height * 0.1),
      paint,
    ); // Top beam
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.1),
      Offset(size.width * 0.7, size.height * 0.2),
      paint,
    ); // Rope

    // 1: Head
    if (wrongGuesses >= 1) {
      canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.3),
        size.height * 0.1,
        paintBody,
      );
    }
    // 2: Body
    if (wrongGuesses >= 2) {
      canvas.drawLine(
        Offset(size.width * 0.7, size.height * 0.4),
        Offset(size.width * 0.7, size.height * 0.7),
        paintBody,
      );
    }
    // 3: Left Arm
    if (wrongGuesses >= 3) {
      canvas.drawLine(
        Offset(size.width * 0.7, size.height * 0.45),
        Offset(size.width * 0.55, size.height * 0.6),
        paintBody,
      );
    }
    // 4: Right Arm
    if (wrongGuesses >= 4) {
      canvas.drawLine(
        Offset(size.width * 0.7, size.height * 0.45),
        Offset(size.width * 0.85, size.height * 0.6),
        paintBody,
      );
    }
    // 5: Left Leg
    if (wrongGuesses >= 5) {
      canvas.drawLine(
        Offset(size.width * 0.7, size.height * 0.7),
        Offset(size.width * 0.6, size.height * 0.9),
        paintBody,
      );
    }
    // 6: Right Leg
    if (wrongGuesses >= 6) {
      canvas.drawLine(
        Offset(size.width * 0.7, size.height * 0.7),
        Offset(size.width * 0.8, size.height * 0.9),
        paintBody,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
