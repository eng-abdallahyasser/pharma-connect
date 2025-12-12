import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors
  static const Color background = Color(0xFFF1F5F9);
  static const Color foreground = Color(0xFF000000);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF000000);
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF00C897);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFFececf0);
  static const Color mutedForeground = Color(0xFF717182);
  static const Color accent = Color(0xFF00C897);
  static const Color accentForeground = Color(0xFFFFFFFF);
  static const Color destructive = Color(0xFFFF5252);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0x1A000000);
  static const Color input = Colors.transparent;
  static const Color inputBackground = Color(0xFFf3f3f5);
  static const Color ring = Color(0xFF1A73E8);

  // Additional colors used in the app
  static const Color blue = Color(0xFF1A73E8);
  static const Color green = Color(0xFF00C897);
  static const Color orange = Color(0xFFFF9500);
  static const Color purple = Color(0xFF906398);
  static const Color red = Color(0xFFFF5252);
  static const Color yellow = Color(0xFFFFC107);
  static const Color gray = Color(0xFF717182);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkForeground = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF2A2A2A);
  static const Color darkCardForeground = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.primaryForeground,
      elevation: 0,
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );
}
