import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Dark palette ──────────────────────────────────────────────
  static const _bgDark = Color(0xFF1C1612);
  static const _surfaceDark = Color(0xFF2A2118);
  static const _surfaceVarDark = Color(0xFF342B1F);
  static const _amber = Color(0xFFC8853A);
  static const _amberContainer = Color(0xFF4A3020);
  static const _tan = Color(0xFFD4A96A);
  static const _tanContainer = Color(0xFF3D2F1A);
  static const _sage = Color(0xFF7BA68E);
  static const _onBgDark = Color(0xFFE8DDD0);
  static const _onSurfaceVarDark = Color(0xFFB5A898);
  static const _errorColor = Color(0xFFCF6679);

  // ── Light palette ─────────────────────────────────────────────
  static const _bgLight = Color(0xFFFAF7F2);
  static const _surfaceLight = Color(0xFFFFFFFF);
  static const _surfaceVarLight = Color(0xFFF0E8DF);
  static const _amberLight = Color(0xFF8B5A2B);
  static const _onBgLight = Color(0xFF1C1612);

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: _bgDark,
      colorScheme: const ColorScheme.dark(
        surface: _surfaceDark,
        surfaceContainerHighest: _surfaceVarDark,
        primary: _amber,
        primaryContainer: _amberContainer,
        onPrimary: Colors.white,
        onPrimaryContainer: _tan,
        secondary: _tan,
        secondaryContainer: _tanContainer,
        onSecondary: _bgDark,
        tertiary: _sage,
        onTertiary: Colors.white,
        onSurface: _onBgDark,
        onSurfaceVariant: _onSurfaceVarDark,
        error: _errorColor,
        outline: _surfaceVarDark,
      ),
      textTheme: _buildTextTheme(base.textTheme, _onBgDark, _onSurfaceVarDark),
      appBarTheme: AppBarTheme(
        backgroundColor: _bgDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: _onBgDark,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: _onBgDark),
      ),
      cardTheme: CardThemeData(
        color: _surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: _surfaceVarDark, width: 1),
        ),
        margin: const EdgeInsets.only(bottom: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _amber,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _amber,
          side: const BorderSide(color: _amber),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVarDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _surfaceVarDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _amber, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(color: _onSurfaceVarDark, fontSize: 14),
        hintStyle: GoogleFonts.inter(color: _onSurfaceVarDark, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceVarDark,
        selectedColor: _amber,
        labelStyle: GoogleFonts.inter(color: _onBgDark, fontSize: 13),
        secondaryLabelStyle:
            GoogleFonts.inter(color: Colors.white, fontSize: 13),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _amber,
        thumbColor: _amber,
        overlayColor: _amber.withOpacity(0.15),
        inactiveTrackColor: _surfaceVarDark,
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      ),
      dividerTheme:
          const DividerThemeData(color: _surfaceVarDark, thickness: 1),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _surfaceDark,
        selectedItemColor: _amber,
        unselectedItemColor: _onSurfaceVarDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:
            GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _surfaceVarDark,
        contentTextStyle: GoogleFonts.inter(color: _onBgDark),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: _bgLight,
      colorScheme: const ColorScheme.light(
        surface: _surfaceLight,
        surfaceContainerHighest: _surfaceVarLight,
        primary: _amberLight,
        primaryContainer: Color(0xFFFFDDB3),
        onPrimary: Colors.white,
        secondary: Color(0xFF8B6B47),
        tertiary: Color(0xFF5A8A70),
        onSurface: _onBgLight,
        onSurfaceVariant: Color(0xFF665543),
        error: _errorColor,
        outline: Color(0xFFD4C4B5),
      ),
      textTheme:
          _buildTextTheme(base.textTheme, _onBgLight, const Color(0xFF665543)),
      appBarTheme: AppBarTheme(
        backgroundColor: _bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: _onBgLight,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: _onBgLight),
      ),
      cardTheme: CardThemeData(
        color: _surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE5D9CE), width: 1),
        ),
        margin: const EdgeInsets.only(bottom: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _amberLight,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVarLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5D9CE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _amberLight, width: 1.5),
        ),
        labelStyle:
            GoogleFonts.inter(color: const Color(0xFF665543), fontSize: 14),
        hintStyle:
            GoogleFonts.inter(color: const Color(0xFF665543), fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceVarLight,
        selectedColor: _amberLight,
        labelStyle: GoogleFonts.inter(color: _onBgLight, fontSize: 13),
        secondaryLabelStyle:
            GoogleFonts.inter(color: Colors.white, fontSize: 13),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _surfaceLight,
        selectedItemColor: _amberLight,
        unselectedItemColor: const Color(0xFF998877),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:
            GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _amberLight,
        thumbColor: _amberLight,
        overlayColor: _amberLight.withOpacity(0.15),
        inactiveTrackColor: _surfaceVarLight,
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      ),
    );
  }

  static TextTheme _buildTextTheme(
      TextTheme base, Color primary, Color secondary) {
    return base.copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
          color: primary, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.playfairDisplay(
          color: primary, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.playfairDisplay(
          color: primary, fontWeight: FontWeight.bold, fontSize: 26),
      headlineMedium: GoogleFonts.inter(
          color: primary, fontWeight: FontWeight.w700, fontSize: 20),
      headlineSmall: GoogleFonts.inter(
          color: primary, fontWeight: FontWeight.w600, fontSize: 18),
      titleLarge: GoogleFonts.inter(
          color: primary, fontWeight: FontWeight.w600, fontSize: 16),
      titleMedium: GoogleFonts.inter(
          color: primary, fontWeight: FontWeight.w500, fontSize: 15),
      bodyLarge: GoogleFonts.inter(color: primary, fontSize: 15),
      bodyMedium: GoogleFonts.inter(color: secondary, fontSize: 14),
      bodySmall: GoogleFonts.inter(color: secondary, fontSize: 12),
      labelLarge: GoogleFonts.inter(
          color: primary, fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium: GoogleFonts.inter(color: secondary, fontSize: 12),
    );
  }
}
