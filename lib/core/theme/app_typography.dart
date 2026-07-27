import 'package:flutter/material.dart';
import '../app_colors.dart';

class AppTypography {
  AppTypography._();

  // Font Families
  static const String _poppins = 'Poppins';
  static const String _amiri = 'Amiri';
  static const String _urdu = 'NotoNastaliqUrdu';

  static TextStyle get h1Light => const TextStyle(
    fontFamily: _poppins,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
    letterSpacing: -0.5,
  );

  /// Feature Screen Headings (e.g., "Prayer Times", "Surah List")
  static TextStyle get h2Light => const TextStyle(
    fontFamily: _poppins,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryLight,
  );

  /// Card Headings / Feature Button Labels
  static TextStyle get h3Light => const TextStyle(
    fontFamily: _poppins,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryLight,
  );

  /// Primary Body Text / Translation text
  static TextStyle get bodyLargeLight => const TextStyle(
    fontFamily: _poppins,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimaryLight,
    height: 1.5,
  );

  /// Captions, Subtitles, Hijri Date, Timings
  static TextStyle get bodyMediumLight => const TextStyle(
    fontFamily: _poppins,
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondaryLight,
  );

  // ===========================================================================
  // 🌙 DARK MODE TEXT STYLES (Poppins for English/System Text)
  // ===========================================================================

  static TextStyle get h1Dark => const TextStyle(
    fontFamily: _poppins,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryDark,
    letterSpacing: -0.5,
  );

  static TextStyle get h2Dark => const TextStyle(
    fontFamily: _poppins,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get h3Dark => const TextStyle(
    fontFamily: _poppins,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get bodyLargeDark => const TextStyle(
    fontFamily: _poppins,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimaryDark,
    height: 1.5,
  );

  static TextStyle get bodyMediumDark => const TextStyle(
    fontFamily: _poppins,
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondaryDark,
  );

  // ===========================================================================
  // 🕌 ARABIC TYPOGRAPHY (Amiri Font for Quran, Duas & Adhkar)
  // ===========================================================================

  /// Quranic Verses, Arabic Text in Light Mode
  static TextStyle get quranArabicLight => const TextStyle(
    fontFamily: _amiri,
    fontSize: 28,
    height: 1.9,
    color: AppColors.textPrimaryLight,
    fontWeight: FontWeight.normal,
  );

  /// Quranic Verses, Arabic Text in Dark Mode
  static TextStyle get quranArabicDark => const TextStyle(
    fontFamily: _amiri,
    fontSize: 28,
    height: 1.9,
    color: AppColors.textPrimaryDark,
    fontWeight: FontWeight.normal,
  );

  // ===========================================================================
  // 🇵🇰 URDU TYPOGRAPHY (Noto Nastaliq Urdu)
  // ===========================================================================

  static TextStyle get urduStyleLight => const TextStyle(
    fontFamily: _urdu,
    color: AppColors.textPrimaryLight,
    height: 2.2,
  );

  static TextStyle get urduStyleDark => const TextStyle(
    fontFamily: _urdu,
    color: AppColors.textPrimaryDark,
    height: 2.2,
  );

  /// No longer needed as fonts are bundled in assets
  static Future<void> prefetchFonts() async {
    return;
  }
}
