import 'package:flutter/material.dart';
import '../utils/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // 1. Keep track of the mode
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // 2. Return the correct theme based on the boolean
  ThemeData get currentTheme =>
      _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  // 3. The method to switch it
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // This tells the whole app to rebuild with new colors!
  }
}
