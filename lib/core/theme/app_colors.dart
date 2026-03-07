import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette from Stitch design (#681b98)
  static const Color primary = Color(0xFF681B98);
  static const Color primaryLight = Color(0xFF9C4DCC);
  static const Color primaryDark = Color(0xFF380066);
  static const Color secondary = Color(0xFF4A90D9);
  static const Color secondaryLight = Color(0xFF7BB8F5);

  // Surface
  static const Color surface = Color(0xFFF8F6FB);
  static const Color surfaceWhite = Colors.white;
  static const Color onSurface = Color(0xFF1C1B1F);

  // Text
  static const Color textPrimary = Color(0xFF1C1B1F);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textOnPrimary = Colors.white;

  // Gradients
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF681B98), Color(0xFF4A90D9)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF681B98), Color(0xFF9C4DCC)],
  );

  // Class card gradients
  static const List<LinearGradient> classGradients = [
    LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]),
    LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)]),
    LinearGradient(colors: [Color(0xFF4ECDC4), Color(0xFF44B09E)]),
    LinearGradient(colors: [Color(0xFFFFA726), Color(0xFFFF7043)]),
    LinearGradient(colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)]),
    LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF8E24AA)]),
    LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF43A047)]),
    LinearGradient(colors: [Color(0xFFEF5350), Color(0xFFE53935)]),
    LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)]),
  ];

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Quiz options
  static const Color optionDefault = Color(0xFFF3E5F5);
  static const Color optionSelected = Color(0xFF681B98);
  static const Color optionCorrect = Color(0xFF4CAF50);
}
