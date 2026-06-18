import 'package:adhan_dart/adhan_dart.dart';
import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/dark_and_light_theme.dart';
import 'package:auraq/core/services/date_time_formate.dart';
import 'package:flutter/material.dart';

class PrayerTimeCard extends StatelessWidget {
  final String prayerName;
  final DateTime prayerTime;
  final Prayer activePrayer;
  final Prayer currentCardPrayer;
  final int flexValue;

  const PrayerTimeCard({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.activePrayer,
    required this.currentCardPrayer,
    this.flexValue = 10,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentActive = activePrayer == currentCardPrayer;

    final Color textColor = isCurrentActive
        ? Colors.white
        : (themeDark(context) ? Colors.white.withOpacity(0.8) : Colors.black87);

    final Color subTextColor = isCurrentActive
        ? Colors.white.withOpacity(
            0.9,
          ) // Active ka subtext thoda aur clear kiya
        : (themeDark(context) ? Colors.white38 : Colors.black45);

    final Color inactiveBgColor = themeDark(context)
        ? Colors.white.withOpacity(0.04)
        : Colors.black.withOpacity(0.03);

    return Expanded(
      // 🔥 Active card ko row mein thodi mazeed breathing space dene ke liye flex adjust kiya
      flex: isCurrentActive ? (flexValue + 2) : flexValue,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // Smooth transition effect
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          horizontal: isCurrentActive ? 2 : 4,
          vertical: isCurrentActive
              ? 0
              : 2, // Active card thoda bahar nikla hua dikhega
        ),
        // Active card ko thodi vertical padding zyada di taake height barh jaye
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
          // Corner radius thoda enhance kiya
          border: Border.all(
            // 🔥 Active card par soft neon cyan border taake wo pop out kare
            color: isCurrentActive
                ? AppColors.primaryTeal.withOpacity(0.5)
                : (themeDark(context)
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.05)),
            width: isCurrentActive ? 1.5 : 1,
          ),
          // 🔥 Active card par behtareen glow shadow
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
                color: textColor,
                fontSize: isCurrentActive ? 12 : 11,
                // Active ka size thoda bada
                fontWeight: isCurrentActive ? FontWeight.bold : FontWeight.w600,
                letterSpacing: isCurrentActive ? 0.4 : 0.2,
              ),
            ),

            const SizedBox(height: 5),

            // 2. Formatted Time
            Text(
              timeFormate(prayerTime.toLocal()),
              maxLines: 1,
              style: TextStyle(
                color: subTextColor,
                fontSize: isCurrentActive ? 9.5 : 9,
                // Active ka time bhi clear dikhe
                fontWeight: isCurrentActive
                    ? FontWeight.w700
                    : FontWeight.normal,
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
                  // Dot ke gird bhi aik chota sa soft shadow effect
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
