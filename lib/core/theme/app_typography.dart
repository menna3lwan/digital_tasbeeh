import 'package:flutter/material.dart';

import 'app_theme.dart';

abstract final class AppTypography {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
    letterSpacing: 0.2,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onBackgroundMuted,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle counter(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w200,
        color: AppColors.primary,
        letterSpacing: -1.5,
        height: 1,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static const TextStyle tapLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
    letterSpacing: 0.8,
    height: 1,
  );

  static const TextStyle resetLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.onBackgroundMuted,
    letterSpacing: 0.2,
    height: 1,
  );
}
