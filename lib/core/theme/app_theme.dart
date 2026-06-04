import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'app_typography.dart';
import 'components/app_bar_theme.dart';
import 'components/card_theme.dart';
import 'components/button_theme.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryTeal,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Injecting Modular Component Themes
      appBarTheme: CustomAppBarTheme.light,
      cardTheme: CustomCardTheme.light,
      elevatedButtonTheme: CustomButtonTheme.elevatedLight,

      // Mapping Core Typography
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1Light,
        headlineMedium: AppTypography.h2Light,
        titleLarge: AppTypography.h3Light,
        bodyLarge: AppTypography.bodyLargeLight,
        bodyMedium: AppTypography.bodyMediumLight,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryTeal,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Injecting Modular Component Themes
      appBarTheme: CustomAppBarTheme.dark,
      cardTheme: CustomCardTheme.dark,
      elevatedButtonTheme: CustomButtonTheme.elevatedDark,

      // Mapping Core Typography
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1Dark,
        headlineMedium: AppTypography.h2Dark,
        titleLarge: AppTypography.h3Dark,
        bodyLarge: AppTypography.bodyLargeDark,
        bodyMedium: AppTypography.bodyMediumDark,
      ),
    );
  }
}
