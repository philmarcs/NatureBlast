import 'package:flutter/material.dart';

class AppTheme {
  static const Color woodlandBackground = Color(0xFFF6EFE3);
  static const Color woodlandSurface = Color(0xFFFCF7EB);
  static const Color woodlandAccent = Color(0xFF5D7A42);
  static const Color woodlandAccentDark = Color(0xFF3D5A2E);
  static const Color woodlandBoard = Color(0xFFE5D4A7);
  static const Color woodlandCell = Color(0xFFF9F0D7);
  static const Color woodlandCellBorder = Color(0xFFB69C6D);
  static const Color woodlandHighlight = Color(0xFFA2C96B);

  static const double cardRadius = 20;
  static const double chipRadius = 14;
  static const double tileRadius = 8;
  static const double minBoardSide = 220;
  static const double maxBoardSide = 360;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;

  static ThemeData buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: woodlandAccent,
        brightness: Brightness.light,
        primary: woodlandAccent,
        secondary: woodlandHighlight,
        surface: woodlandSurface,
      ),
      scaffoldBackgroundColor: woodlandBackground,
      cardColor: woodlandSurface,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: woodlandAccentDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: woodlandAccentDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: woodlandAccentDark,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: woodlandAccentDark,
        ),
      ),
    );
  }
}
