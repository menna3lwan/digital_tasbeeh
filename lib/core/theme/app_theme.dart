import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF1A5C48);
  static const Color primaryLight = Color(0xFF2A7A62);
  static const Color primaryDark = Color(0xFF0F3D30);
  static const Color accent = Color(0xFFC4A035);
  static const Color background = Color(0xFFF7F4EF);
  static const Color backgroundTop = Color(0xFFFDFBF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1C1C1C);
  static const Color onBackgroundMuted = Color(0xFF8A8A8A);
  static const Color counterRing = Color(0xFFE8F0EC);
  static const Color error = Color(0xFFC62828);
}

abstract final class AppSpacing {
  static const double screenHorizontal = 28;
  static const double sectionGap = 40;
  static const double counterToButton = 44;
  static const double bottomSafe = 20;
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      error: AppColors.error,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.onBackground,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.onBackground,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 15,
          color: AppColors.onBackgroundMuted,
          height: 1.5,
        ),
      ),
    );
  }
}
