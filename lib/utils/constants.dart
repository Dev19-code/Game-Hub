class AppConstants {
  // Spacing & Layout
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // List Specific Layout
  static const double listSpacing = 12.0;
  static const double cardElevation = 0.0; // Flat look is modern for lists
  static const double listIconSize = 32.0;

  // Design Elements
  static const double borderRadius = 16.0;

  // Audio Asset Paths (The "Something Else" you needed!)
  static const String audioPath =
      'sounds/'; // AssetSource usually starts inside assets/

  // Hangman
  static const String sfxHangmanClick = 'hangman_click.mp3';
  static const String sfxHangmanFail = 'hangman_fail.mp3';
  static const String sfxHangmanPluh = 'hangman_pluh.mp3';
  static const String sfxHangmanSuccess = 'hangman_success.mp3';

  // Hot or Cold
  static const String sfxHotColdFire = 'hotCold_fire.mp3';
  static const String sfxHotColdFreez = 'hotCold_freez.mp3';

  // Colored Words (Stroop)
  static const String sfxStroopCorrect = 'streep_correct.wav'; // Note the .wav!
  static const String sfxStroopWrong = 'streep_wrong.mp3';

  // Animation
  static const Duration fastDuration = Duration(milliseconds: 200);
  static const Duration normalDuration = Duration(milliseconds: 400);
}
