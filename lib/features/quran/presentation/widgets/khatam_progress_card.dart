import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class KhatamProgressCard extends StatelessWidget {
  final int lastReadPage;
  final VoidCallback onTap;
  final bool isUrdu;
  final bool isPashto;

  const KhatamProgressCard({
    super.key,
    required this.lastReadPage,
    required this.onTap,
    this.isUrdu = false,
    this.isPashto = false,
  });

  static const int _totalPages = 548;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isRtl = isUrdu || isPashto;

    final validPage = lastReadPage.clamp(0, _totalPages);
    final double percentage = validPage / _totalPages;
    final int percentInt = (percentage * 100).round();

    return InkWell(
      onTap: () => AdHelper.maybeShowKhatamAd(
        context,
        onContinue: onTap,
        onSkip: () {},
      ),
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
                    AppColors.primaryTeal.withValues(alpha: 0.05),
                    AppColors.primaryTeal.withValues(alpha: 0.01),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? AppColors.primaryTeal.withValues(alpha: 0.25)
                : AppColors.primaryTeal.withValues(alpha: 0.12),
            width: 1,
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment:
              isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              children: [
                // Clean Minimal Icon Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : AppColors.primaryTeal.withValues(alpha: 0.08),
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
                    isUrdu
                        ? "ختمِ قرآن"
                        : (isPashto ? "د قرآن ختم" : "QURAN COMPLETION"),
                    textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: isRtl ? 15 : 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: isRtl ? 0 : 1.2,
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
                              AppColors.lightTeal.withValues(alpha: 0.3),
                              AppColors.lightTeal.withValues(alpha: 0.1),
                            ]
                          : [
                              AppColors.lightTeal.withValues(alpha: 0.2),
                              AppColors.lightTeal.withValues(alpha: 0.05),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.lightTeal.withValues(alpha: 0.3),
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
                  ? Colors.white.withValues(alpha: 0.08)
                  : AppColors.primaryTeal.withValues(alpha: 0.06),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.lightTeal,
              ),
              minHeight: 6,
            ),
            const SizedBox(height: 14),

            // Action Row
            Row(
              mainAxisAlignment:
                  isRtl ? MainAxisAlignment.start : MainAxisAlignment.end,
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Text(
                  validPage >= _totalPages
                      ? (isUrdu
                          ? "ماشاء اللہ! ختمِ قرآن مکمل"
                          : (isPashto
                              ? "ماشاالله! د قرآن ختم بشپړ شو"
                              : "MashaAllah! Complete"))
                      : (isUrdu
                          ? "تلاوتِ قرآن جاری رکھیں"
                          : (isPashto
                              ? "د قرآن تلاوت ته دوام ورکړئ"
                              : "Continue Reading")),
                  style: TextStyle(
                    fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: isRtl ? 12 : 12,
                    letterSpacing: isRtl ? 0 : 0.3,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  validPage >= _totalPages
                      ? Icons.celebration_rounded
                      : (isRtl
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
