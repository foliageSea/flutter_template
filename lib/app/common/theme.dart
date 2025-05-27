import 'package:flutter/material.dart';

class AppTheme {
  static const Color color = Colors.blue;

  static ThemeData getThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: color),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
