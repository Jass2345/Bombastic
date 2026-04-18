import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const _primaryColor = Color(0xFFFF3B30);
  static const _secondaryColor = Color(0xFFFF9500);

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;
    // IBM Plex Sans KR: 모던하고 얇은 느낌, 세련된 UI
    return GoogleFonts.ibmPlexSansKrTextTheme(base).copyWith(
      // AppBar·다이얼로그 제목 → Jua
      titleLarge: GoogleFonts.jua(textStyle: base.titleLarge),
      titleMedium: GoogleFonts.jua(textStyle: base.titleMedium),
      headlineLarge: GoogleFonts.jua(textStyle: base.headlineLarge),
      headlineMedium: GoogleFonts.jua(textStyle: base.headlineMedium),
      headlineSmall: GoogleFonts.jua(textStyle: base.headlineSmall),
    );
  }

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          secondary: _secondaryColor,
          brightness: Brightness.light,
        ),
        textTheme: _buildTextTheme(Brightness.light),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          // titleTextStyle 미설정 → textTheme.titleLarge(Jua) 자동 상속
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.jua(fontSize: 16),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          secondary: _secondaryColor,
          brightness: Brightness.dark,
        ),
        textTheme: _buildTextTheme(Brightness.dark),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.jua(fontSize: 16),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
