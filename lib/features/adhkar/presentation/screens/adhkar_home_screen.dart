import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/features/tasbeeh/presentation/screens/tasbeeh_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/adhkar_constants.dart';
import 'adhkar_list_screen.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class AdhkarHomeScreen extends ConsumerWidget {
  const AdhkarHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Adhkar & Tasbeeh",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Featured Card - Minimal & Clean
              _buildFeaturedCard(context, isUrdu, isDark),

              const SizedBox(height: 28),

              Text(
                "Explore Adhkar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 16),

              // Grid Menu
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),
                itemCount: AdhkarConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = AdhkarConstants.categories[index];
                  return _buildCategoryCard(context, category, isUrdu, isDark);
                },
              ),
              const SizedBox(height: 20),
              const AdBannerWidget(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, bool isUrdu, bool isDark) {
    return InkWell(
      onTap: () {
        hapticFeedBack();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TasbeehListScreen()),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // Clean surface color matching the design system instead of heavy gradients
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Minimalist Icon Container with subtle primary tint
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                FlutterIslamicIcons.tasbih3,
                color: AppColors.primaryTeal,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tasbeeh Counter",
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                      fontSize: isUrdu ? 17 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Count your daily dhikr",
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Subtle forward arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isDark ? Colors.white54 : Colors.black45,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    AdhkarCategory category,
    bool isUrdu,
    bool isDark,
  ) {
    IconData icon;
    Color color;

    switch (category.id) {
      case 'morning':
        icon = Icons.wb_sunny_rounded;
        color = const Color(0xFFFFB74D);
        break;
      case 'evening':
        icon = Icons.nights_stay_rounded;
        color = const Color(0xFF5C6BC0);
        break;
      case 'sleeping':
        icon = Icons.bedtime_rounded;
        color = const Color(0xFF7E57C2);
        break;
      case 'waking':
        icon = Icons.wb_twilight_rounded;
        color = const Color(0xFF26A69A);
        break;
      default:
        icon = Icons.bookmark_rounded;
        color = AppColors.primaryTeal;
    }

    return InkWell(
      onTap: () {
        hapticFeedBack();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AdhkarListScreen(
              dhikrList: category.dhikrs,
              title: category.titleEn,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 10),
            Text(
              category.titleEn,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
