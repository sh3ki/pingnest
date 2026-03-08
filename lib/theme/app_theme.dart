import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF10B981);
  static const Color accent = Color(0xFFF59E0B);
  static const Color surface = Color(0xFFF8FAFF);
  static const Color sentBubble = Color(0xFF3B82F6);
  static const Color receivedBubble = Color(0xFFFFFFFF);

  static LinearGradient get heroGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
  );

  static LinearGradient get onlineGradient => const LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  static List<BoxShadow> get cardShadow => [
    BoxShadow(color: primary.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4)),
  ];

  static List<BoxShadow> get softShadow => [
    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2)),
  ];

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, surface: surface),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      textTheme: base.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primary.withOpacity(0.15),
        labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
