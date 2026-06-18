import 'package:flutter/material.dart';

import '../../app_colors.dart';

class CustomButtonTheme {
  CustomButtonTheme._();

  static ElevatedButtonThemeData get elevatedLight => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryTeal,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size.fromHeight(52), // Standard corporate height
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  static ElevatedButtonThemeData get elevatedDark => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryTeal,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}
