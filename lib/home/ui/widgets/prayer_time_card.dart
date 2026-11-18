import 'package:adhan_dart/adhan_dart.dart';
import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/dark_and_light_theme.dart';
import 'package:mubin/core/services/date_time_formate.dart';
import 'package:flutter/material.dart';

class PrayerTimeCard extends StatelessWidget {
  final String prayerName;
  final DateTime prayerTime;
  final Prayer activePrayer;
  final Prayer currentCardPrayer;
  final int flexValue;
  final bool isRtl;

  const PrayerTimeCard({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.activePrayer,
    required this.currentCardPrayer,
    this.flexValue = 10,
    this.isRtl = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentActive = activePrayer == currentCardPrayer;

    final Color textColor = isCurrentActive
        ? Colors.white
        : getThemeColor(
            context,
            light: Colors.black87,
            dark: Colors.white.withOpacity(0.8),
          );

    final Color subTextColor = isCurrentActive
        ? Colors.white.withOpacity(0.9)
        : getThemeColor(context, light: Colors.black45, dark: Colors.white38);

    final Color inactiveBgColor = getThemeColor(
      context,
      light: Colors.black.withOpacity(0.03),
      dark: Colors.white.withOpacity(0.04),
    );

    return Expanded(
      flex: isCurrentActive ? (flexValue + 2) : flexValue,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          horizontal: isCurrentActive ? 2 : 4,
          vertical: isCurrentActive ? 0 : 2,
        ),
        padding: EdgeInsets.symmetric(
          vertical: isCurrentActive ? 15 : 11,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          gradient: isCurrentActive
              ? const LinearGradient(
                  colors: [AppColors.primaryTeal, AppColors.success],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: isCurrentActive ? null : inactiveBgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isCurrentActive
                ? AppColors.primaryTeal.withOpacity(0.5)
                : getThemeColor(
                    context,
                    light: Colors.black.withOpacity(0.05),
                    dark: Colors.white.withOpacity(0.05),
                  ),
            width: isCurrentActive ? 1.5 : 1,
          ),
          boxShadow: isCurrentActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryTeal.withOpacity(0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Namaz Name
            Text(
              prayerName,
              maxLines: 1,
              style: TextStyle(
                fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                color: textColor,
                fontSize: isCurrentActive
                    ? (isRtl ? 11 : 12)
                    : (isRtl ? 10 : 11),
                fontWeight: isCurrentActive ? FontWeight.bold : FontWeight.w500,
                letterSpacing: isCurrentActive ? 0.4 : 0.2,
              ),
            ),

            const SizedBox(height: 5),

            // 2. Formatted Time
            Center(
              child: Text(
                timeFormate(prayerTime.toLocal()),
                maxLines: 1,
                style: TextStyle(
                  color: subTextColor,
                  fontSize: isCurrentActive ? 9.5 : 9,
                  fontWeight: isCurrentActive
                      ? FontWeight.w700
                      : FontWeight.w800,
                ),
              ),
            ),

            // 3. Premium Active Indicator Dot
            if (isCurrentActive) ...[
              const SizedBox(height: 6),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white60,
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
