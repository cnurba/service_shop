import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AppTheme {
  static ThemeData lightTheme = _buildLightAppTheme();

  static ThemeData _buildLightAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      textTheme: _lightTextTheme(base.textTheme),
      primaryColor: ServiceColors.primaryColor,
      scaffoldBackgroundColor: ServiceColors.scaffoldBackgroundColor,
      cardTheme: base.cardTheme.copyWith(
        color: ServiceColors.cardBgColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static TextTheme _lightTextTheme(TextTheme baseTextTheme) {
    return baseTextTheme.copyWith();
  }
}
