import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get h1Light => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
    letterSpacing: -0.5,
  );

  /// Feature Screen Headings (e.g., "Prayer Times", "Surah List")
  static TextStyle get h2Light => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700, // w700
    color: AppColors.textPrimaryLight,
  );

  /// Card Headings / Feature Button Labels
  static TextStyle get h3Light => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryLight,
  );

  /// Primary Body Text / Translation text
  static TextStyle get bodyLargeLight => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimaryLight,
    height: 1.5,
  );

  /// Captions, Subtitles, Hijri Date, Timings
  static TextStyle get bodyMediumLight => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondaryLight,
  );

  // ===========================================================================
  // 🌙 DARK MODE TEXT STYLES (Poppins for English/System Text)
  // ===========================================================================

  static TextStyle get h1Dark => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryDark,
    letterSpacing: -0.5,
  );

  static TextStyle get h2Dark => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get h3Dark => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle get bodyLargeDark => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimaryDark,
    height: 1.5,
  );

  static TextStyle get bodyMediumDark => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondaryDark,
  );

  // ===========================================================================
  // 🕌 ARABIC TYPOGRAPHY (Amiri Font for Quran, Duas & Adhkar)
  // ===========================================================================

  /// Quranic Verses, Arabic Text in Light Mode
  static TextStyle get quranArabicLight => GoogleFonts.amiri(
    fontSize: 28,
    height: 1.9,
    // Arabic text needs more line-height to display diacritics (Zabar/Zer/Pesh) properly
    color: AppColors.textPrimaryLight,
    fontWeight: FontWeight.normal,
  );

  /// Quranic Verses, Arabic Text in Dark Mode
  static TextStyle get quranArabicDark => GoogleFonts.amiri(
    fontSize: 28,
    height: 1.9,
    color: AppColors.textPrimaryDark,
    fontWeight: FontWeight.normal,
  );

  // ===========================================================================
  // 🇵🇰 URDU TYPOGRAPHY (Noto Nastaliq Urdu)
  // ===========================================================================

  static TextStyle get urduStyleLight => GoogleFonts.notoNastaliqUrdu(
    color: AppColors.textPrimaryLight,
    height: 2.2,
  );

  static TextStyle get urduStyleDark => GoogleFonts.notoNastaliqUrdu(
    color: AppColors.textPrimaryDark,
    height: 2.2,
  );

  /// Pre-fetches necessary fonts to avoid flickering on first load.
  static Future<void> prefetchFonts() async {
    // Touching the fonts with specific weights used in the app
    // Poppins variants
    GoogleFonts.poppins(fontWeight: FontWeight.normal);
    GoogleFonts.poppins(fontWeight: FontWeight.w600);
    GoogleFonts.poppins(fontWeight: FontWeight.w700);
    GoogleFonts.poppins(fontWeight: FontWeight.bold);
    
    // Arabic & Urdu
    GoogleFonts.amiri();
    GoogleFonts.amiriQuran();
    GoogleFonts.notoNastaliqUrdu();
    
    // Wait for all triggered font fetches to complete
    await GoogleFonts.pendingFonts();
  }
}
