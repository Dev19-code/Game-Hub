import 'package:flutter/material.dart';
import '../models/game.dart';

/// APP-WIDE STATE: Manages the registry of available games
class GameRegistryProvider extends ChangeNotifier {
  final List<MiniGame> _games = [];
  MiniGame? _activeGame;

  void registerGame(MiniGame game) {
    _games.add(game);
    notifyListeners();
  }

  void setActiveGame(MiniGame? game) {
    _activeGame = game;
    notifyListeners();
  }

  List<MiniGame> get availableGames => _games;
  MiniGame? get activeGame => _activeGame;
}
