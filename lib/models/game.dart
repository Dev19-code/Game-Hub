import 'package:flutter/material.dart';

// ==========================================
// MODELS (lib/models/game.dart)
// ==========================================

/// Abstract base class that all mini-games must implement.
/// This ensures our modular architecture is strictly followed.
abstract class MiniGame {
  String get id;
  String get title;
  String get description;
  IconData get icon;
  String get imagePath; // New field!

  // Each game returns its own isolated StatefulWidget
  Widget createScreen();

  // Now every game is forced to report its status using our shared Enum
  // --- BUT LET THIS FOR LATER :) ---
  // GameStatus getStatus();
}
