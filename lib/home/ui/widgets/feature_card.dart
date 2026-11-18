import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/services/dark_and_light_theme.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isRtl;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isRtl = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeDark(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: getThemeColor(
              context,
              light: Colors.white,
              dark: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: getThemeColor(
                context,
                light: Colors.black.withOpacity(0.05),
                dark: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 28,
                color: isDark ? AppColors.primaryTeal : AppColors.success,
              ),

              const SizedBox(height: 10),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                  fontSize: isRtl ? 13.5 : 15,
                  fontWeight: FontWeight.w500,
                  height: isRtl ? 1.5 : 1.2,
                  color: getThemeColor(
                    context,
                    light: Colors.black87,
                    dark: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
