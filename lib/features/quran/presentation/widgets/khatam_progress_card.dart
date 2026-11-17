import 'package:mubin/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class KhatamProgressCard extends StatelessWidget {
  final int lastReadPage;
  final VoidCallback onTap;
  final bool isUrdu;

  const KhatamProgressCard({
    super.key,
    required this.lastReadPage,
    required this.onTap,
    this.isUrdu = false,
  });

  static const int _totalPages = 604;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final validPage = lastReadPage.clamp(0, _totalPages);
    final double percentage = validPage / _totalPages;
    final int percentInt = (percentage * 100).round();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          crossAxisAlignment:
              isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
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
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Title Typography Clean Up
                Expanded(
                  child: Text(
                    isUrdu ? "ختمِ قرآن" : "QURAN COMPLETION",
                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: isUrdu ? 15 : 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: isUrdu ? 0 : 1.2,
                    ),
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
            const SizedBox(height: 20),

            // Clean Progress Bar
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: isDark
                  ? Colors.white.withOpacity(0.08)
                  : AppColors.primaryTeal.withOpacity(0.06),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.lightTeal),
              minHeight: 6,
            ),
            const SizedBox(height: 14),

            // Action Row
            Row(
              mainAxisAlignment:
                  isUrdu ? MainAxisAlignment.start : MainAxisAlignment.end,
              textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Text(
                  validPage >= _totalPages
                      ? (isUrdu ? "ماشاء اللہ! ختمِ قرآن مکمل" : "MashaAllah! Complete")
                      : (isUrdu ? "تلاوتِ قرآن جاری رکھیں" : "Continue Reading"),
                  style: TextStyle(
                    fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: isUrdu ? 12 : 12,
                    letterSpacing: isUrdu ? 0 : 0.3,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  validPage >= _totalPages
                      ? Icons.celebration_rounded
                      : (isUrdu
                          ? Icons.arrow_back_ios_rounded
                          : Icons.arrow_forward_ios_rounded),
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
