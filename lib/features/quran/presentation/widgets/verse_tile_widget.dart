import 'package:flutter/material.dart';
import 'package:auraq/core/services/dark_and_light_theme.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this package import
import '../../domain/entities/verse.dart';

class VerseTileWidget extends StatelessWidget {
  final Verse verse;
  final bool isHighlighted;
  final VoidCallback onTap;

  const VerseTileWidget({
    super.key,
    required this.verse,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted ? getThemeColor(context, light: Colors.white, dark: Colors.teal.withValues(alpha: 0.12)) : getThemeColor(context, light: Colors.white, dark: Colors.white),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: getThemeColor(context, light: Colors.black.withValues(alpha: 0.03), dark: Colors.white.withValues(alpha: 0.03)),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isHighlighted ? getThemeColor(context, light: Colors.grey.withValues(alpha: 0.15), dark: Colors.teal) : getThemeColor(context, light: Colors.grey.withValues(alpha: 0.15), dark: Colors.grey.withValues(alpha: 0.15)),
          width: isHighlighted ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: getThemeColor(context, light: Colors.teal.withValues(alpha: 0.1), dark: Colors.teal.withValues(alpha: 0.1)),
                  child: Text(
                    '${verse.verseNumber}',
                    style: TextStyle(
                      fontSize: 11,
                      color: getThemeColor(context, light: Colors.teal, dark: Colors.teal),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Surah ${verse.surahNumber}',
                  style: TextStyle(fontSize: 12, color: getThemeColor(context, light: Colors.grey, dark: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              verse.textArabic,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: GoogleFonts.amiriQuran(
                fontSize: 24,
                height: 2.0,
                color: const Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
