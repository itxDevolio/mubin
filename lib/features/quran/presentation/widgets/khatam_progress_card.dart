import 'package:auraq/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';

/// KhatamProgressCard - Quran completion progress dikhata hai
/// Clean architecture ke hisaab se yeh sirf UI render karta hai
class KhatamProgressCard extends StatelessWidget {
  final int lastReadPage;
  final VoidCallback onTap;

  const KhatamProgressCard({
    super.key,
    required this.lastReadPage,
    required this.onTap,
  });

  // Total pages in Quran (standard Madani Mushaf)
  static const int _totalPages = 604;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Safety check for calculation
    final validPage = lastReadPage.clamp(0, _totalPages);
    final double percentage = validPage / _totalPages;
    final int percentInt = (percentage * 100).round();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), // Standardized clean radius
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [AppColors.darkTeal, AppColors.primaryTeal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    AppColors.primaryTeal.withOpacity(0.05),
                    AppColors.primaryTeal.withOpacity(0.01),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? AppColors.primaryTeal.withOpacity(0.25)
                : AppColors.primaryTeal.withOpacity(0.12),
            width: 1,
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Clean Minimal Icon Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : AppColors.primaryTeal.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FlutterIslamicIcons.solidQuran2,
                    color: isDark ? Colors.white : AppColors.primaryTeal,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),

                // Title Typography Clean Up
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QURAN COMPLETION",
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Page $validPage of $_totalPages",
                        style: GoogleFonts.poppins(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress Percentage Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              AppColors.lightTeal.withOpacity(0.3),
                              AppColors.lightTeal.withOpacity(0.1),
                            ]
                          : [
                              AppColors.lightTeal.withOpacity(0.2),
                              AppColors.lightTeal.withOpacity(0.05),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.lightTeal.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "$percentInt%",
                    style: const TextStyle(
                      color: AppColors.lightTeal,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Clean Progress Bar
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: isDark
                  ? Colors.white.withOpacity(0.08)
                  : AppColors.primaryTeal.withOpacity(0.06),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.lightTeal),
              minHeight: 6,
            ),
            const SizedBox(height: 16),

            // Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  validPage >= _totalPages ? "MashaAllah! Complete" : "Continue Reading",
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  validPage >= _totalPages
                      ? Icons.celebration_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.primaryTeal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
