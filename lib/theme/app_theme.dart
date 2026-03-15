import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Slate Signal palette
  static const Color primary = Color(0xFF4A5568);     // Slate
  static const Color secondary = Color(0xFF2B9E9E);   // Teal
  static const Color accent = Color(0xFFE8A838);       // Amber
  static const Color surface = Color(0xFFF7F8FA);     // Light gray
  static const Color sentBubble = Color(0xFF4A5568);
  static const Color receivedBubble = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF8C95A6);

  static List<BoxShadow> get cardShadow => [
    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 3)),
  ];

  static List<BoxShadow> get softShadow => [
    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
  ];

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, surface: surface),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primary.withOpacity(0.12),
        labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
