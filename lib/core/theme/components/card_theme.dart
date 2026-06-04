import 'package:flutter/material.dart';
import '../../app_colors.dart';

class CustomCardTheme {
  CustomCardTheme._();

  static CardThemeData get light => const CardThemeData(
    color: AppColors.surfaceLight,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.borderLight, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  static CardThemeData get dark => const CardThemeData(
    color: AppColors.surfaceDark,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.borderDark, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}
