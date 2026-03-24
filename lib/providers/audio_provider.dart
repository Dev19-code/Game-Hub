import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AudioProvider extends ChangeNotifier {
  // We use two players so sounds can overlap (e.g., a "click" during music)
  final AudioPlayer _player = AudioPlayer();

  bool _isSoundEnabled = true;
  bool get isSoundEnabled => _isSoundEnabled;

  AudioProvider() {
    _loadSettings();
  }

  // A generic play method that handles any file we pass it
  Future<void> _playEffect(String fileName) async {
    if (!isSoundEnabled) return;
    try {
      // We use stop() first so if the user clicks fast, the sound restarts immediately
      await _player.stop();
      await _player.play(AssetSource('${AppConstants.audioPath}$fileName'));
    } catch (e) {
      debugPrint("Error playing sound $fileName: $e");
    }
  }

  // --- Specialized methods for readability ---

  // Hangman
  void playHangman(String type) {
    if (type == 'win') _playEffect(AppConstants.sfxHangmanSuccess);
    if (type == 'lose') _playEffect(AppConstants.sfxHangmanFail);
    if (type == 'wrong') _playEffect(AppConstants.sfxHangmanPluh);
    if (type == 'click') _playEffect(AppConstants.sfxHangmanClick);
  }

  // Hot Cold
  void playHotCold({required bool isHot}) {
    _playEffect(isHot ? AppConstants.sfxHotColdFire : AppConstants.sfxHotColdFreez);
  }

  // Colored Words
  void playStroop({required bool isCorrect}) {
    _playEffect(isCorrect ? AppConstants.sfxStroopCorrect : AppConstants.sfxStroopWrong);
  }


  // --- SETTINGS ---

  void toggleSound() async {
    _isSoundEnabled = !_isSoundEnabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', _isSoundEnabled);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isSoundEnabled = prefs.getBool('sound_enabled') ?? true;
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
