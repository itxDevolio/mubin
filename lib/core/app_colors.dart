import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---  Islamic Brand Identity ---
  static const Color primaryTeal       = Color(0xFF008080); // Rich Premium Islamic Teal
  static const Color lightTeal         = Color(0xFF26A69A); // Active tabs / highlights
  static const Color darkTeal          = Color(0xFF004D40); // Deep Emerald for app bars

  // ---  Premium Accents (For Moon, Borders, and Icons) ---
  static const Color accentGold        = Color(0xFFC5A059); // Muted Premium Gold (High Contrast)
  static const Color lightGold         = Color(0xFFD4AF37); // Classic Shiny Gold

  // --- ☀ Light Mode Palette ---
  static const Color backgroundLight   = Color(0xFFF6F8FA); // Premium soft off-white (reduces strain)
  static const Color surfaceLight      = Color(0xFFFFFFFF); // Clean white for cards & sheets
  static const Color textPrimaryLight  = Color(0xFF1E2229); // Charcoal Black (Never pure black)
  static const Color textSecondaryLight= Color(0xFF626973); // Muted gray for subtitle/Hijri date
  static const Color borderLight       = Color(0xFFE2E8F0); // Thin elegant dividers

  // ---  Dark Mode Palette  ---
  static const Color backgroundDark    = Color(0xFF0F1115); // Deep premium midnight dark
  static const Color surfaceDark       = Color(0xFF1A1D24); // Elevated dark container cards
  static const Color textPrimaryDark   = Color(0xFFF1F2F6); // Soft white (reduces glare at night)
  static const Color textSecondaryDark = Color(0xFFA4B0BE); // Soft silver for text subtitles
  static const Color borderDark        = Color(0xFF2D3748); // Minimal dark dividers

  // --- System Status ---
  static const Color error             = Color(0xFFFF4757);
  static const Color success           = Color(0xFF2ED573);
}