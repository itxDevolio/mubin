import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../app_typography.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static AppBarTheme get light => AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight, size: 24),
    titleTextStyle: AppTypography.h2Light,
  );

  static AppBarTheme get dark => AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColors.textPrimaryDark, size: 24),
    titleTextStyle: AppTypography.h2Dark,
  );
}