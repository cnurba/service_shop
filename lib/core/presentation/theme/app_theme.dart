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
      appBarTheme: base.appBarTheme.copyWith(
        //color: ServiceColors.appBarColor,
        elevation: 2,
        iconTheme: const IconThemeData(color: ServiceColors.primaryColor),
        titleTextStyle: const TextStyle(
          color: ServiceColors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        color: ServiceColors.cardBgColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static TextTheme _lightTextTheme(TextTheme baseTextTheme) {
    return baseTextTheme.copyWith();
  }
}
