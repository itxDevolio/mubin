import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:auraq/features/tasbeeh/presentation/screens/tasbeeh_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/adhkar_constants.dart';
import 'adhkar_list_screen.dart';

class AdhkarHomeScreen extends ConsumerWidget {
  const AdhkarHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
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
              
              const SizedBox(height: 30),
              
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.darkTeal, AppColors.primaryTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryTeal.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(FlutterIslamicIcons.tasbih3, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                "Tasbeeh Counter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  Text(
                    "Count your daily dhikr",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, AdhkarCategory category, bool isUrdu, bool isDark) {
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
              title: isUrdu ? category.titleUr : category.titleEn,
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
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(
              isUrdu ? category.titleUr : category.titleEn,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
