import 'package:flutter/material.dart';
import '../state/app_state.dart';

/// Builds a [ThemeData] driven by the current accessibility settings.
///
/// This is what makes "Accessibility Settings" a real, functioning feature
/// rather than a static screen: when [AppState.largeText] or
/// [AppState.highContrast] change, [AppTheme.build] produces a different
/// ThemeData, and because MaterialApp is wrapped in a ListenableBuilder
/// listening to AppState, the whole app rebuilds with the new look.
class AppTheme {
  static ThemeData build(AppState state) {
    final bool contrast = state.highContrast;

    final Color background = contrast ? Colors.black : const Color(0xFFF5F5F5);
    final Color surface = contrast ? const Color(0xFF121212) : Colors.white;
    final Color onSurface = contrast ? Colors.white : const Color(0xFF111111);
    final Color subtitle = contrast ? const Color(0xFFCCCCCC) : const Color(0xFF6B6B6B);
    final Color primary = contrast ? Colors.white : Colors.black;
    final Color onPrimary = contrast ? Colors.black : Colors.white;
    final Color divider = contrast ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0);

    final double scale = state.largeText ? 1.25 : 1.0;

    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: background,
      dividerColor: divider,
      colorScheme: ColorScheme(
        brightness: contrast ? Brightness.dark : Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: primary,
        onSecondary: onPrimary,
        error: const Color(0xFFD32F2F),
        onError: Colors.white,
        surface: surface,
        onSurface: onSurface,
      ),
      textTheme: _textTheme(onSurface, subtitle, scale),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: onSurface,
          fontSize: 18 * scale,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: contrast ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: contrast ? BorderSide(color: divider) : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          side: BorderSide(color: divider),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: contrast ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: subtitle, fontSize: 14 * scale),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? onPrimary : subtitle,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primary : divider,
        ),
      ),
      iconTheme: IconThemeData(color: onSurface),
    );

    return base;
  }

  static TextTheme _textTheme(Color onSurface, Color subtitle, double scale) {
    return TextTheme(
      headlineSmall: TextStyle(
        color: onSurface,
        fontSize: 22 * scale,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        color: onSurface,
        fontSize: 18 * scale,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: onSurface,
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: onSurface, fontSize: 15 * scale),
      bodyMedium: TextStyle(color: subtitle, fontSize: 13 * scale),
      labelLarge: TextStyle(
        color: onSurface,
        fontSize: 14 * scale,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
