import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.backgroundLight, // Fixed: Moved into ColorScheme
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColorDark: AppColors.primary.withBlue(200),
    primaryColor: AppColors.primary,
    highlightColor: Colors.black54,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark, // Fixed: Moved into ColorScheme
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColorDark: AppColors.primary.withBlue(200),
    primaryColor: AppColors.primary,
    highlightColor: Colors.white54,
  );
}
