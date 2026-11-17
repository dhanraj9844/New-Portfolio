import 'package:flutter/material.dart';

/// Central place for every color, gradient and text style used across the
/// portfolio, so the whole look can be restyled from one file.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B1220);
  static const Color surface = Color(0xFF111A2C);
  static const Color surfaceAlt = Color(0xFF16213A);
  static const Color border = Color(0xFF223052);

  static const Color textPrimary = Color(0xFFF3F6FB);
  static const Color textSecondary = Color(0xFFA9B4C7);
  static const Color textMuted = Color(0xFF6E7A93);

  static const Color accentGreen = Color(0xFF3EE6B0);
  static const Color accentBlue = Color(0xFF4EA2FF);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentGreen, accentBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const RadialGradient heroGlow = RadialGradient(
    colors: [Color(0x333EE6B0), Colors.transparent],
    radius: 0.9,
  );
}

class AppText {
  AppText._();

  static const String fontFamily = 'Segoe UI';

  static const TextStyle display = TextStyle(
    fontSize: 46,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.5,
  );

  static const TextStyle nav = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );
}

/// Breakpoints used everywhere to switch between mobile / tablet / desktop
/// layouts.
class AppBreakpoints {
  AppBreakpoints._();
  static const double mobile = 640;
  static const double tablet = 1000;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppText.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentGreen,
      secondary: AppColors.accentBlue,
      surface: AppColors.surface,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.accentGreen,
      selectionColor: Color(0x553EE6B0),
      selectionHandleColor: AppColors.accentGreen,
    ),
  );
}