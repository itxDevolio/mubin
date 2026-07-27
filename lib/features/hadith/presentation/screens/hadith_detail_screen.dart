import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/features/hadith/domain/entities/hadith.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HadithDetailScreen extends ConsumerWidget {
  final HadithEntity hadith;

  const HadithDetailScreen({super.key, required this.hadith});

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
          'Hadith ${hadith.hadithNumber}',
          style: TextStyle(
            letterSpacing: 0.5,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 30 : 10),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    color: AppColors.primaryTeal.withAlpha(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${hadith.hadithNumber}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryTeal.withAlpha(100),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hadith.status,
                            style: const TextStyle(
                              color: AppColors.primaryTeal,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Arabic Text (Always present and centered)
                        Text(
                          hadith.arabicText,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 20,
                            height: 1.8,
                            color: isDark
                                ? Colors.white
                                : AppColors.textPrimaryLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Main Translation based on Settings (Strictly only one)
                        if (isUrdu)
                          _buildTranslationSection(
                            title: "Translation",
                            content: hadith.urduText,
                            isUrdu: true,
                            isDark: isDark,
                            isMain: true,
                          )
                        else
                          _buildTranslationSection(
                            title: "English Translation",
                            content: hadith.englishText,
                            isUrdu: false,
                            isDark: isDark,
                            isMain: true,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationSection({
    required String title,
    required String content,
    required bool isUrdu,
    required bool isDark,
    required bool isMain,
  }) {
    return Column(
      crossAxisAlignment: isUrdu
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isUrdu
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isUrdu)
              Container(
                width: 24,
                height: 2,
                color: AppColors.primaryTeal.withAlpha(100),
              ),
            if (!isUrdu) const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isMain
                    ? AppColors.primaryTeal
                    : AppColors.primaryTeal.withAlpha(150),
                fontSize: isMain ? 15 : 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isUrdu) const SizedBox(width: 8),
            if (isUrdu)
              Container(
                width: 24,
                height: 2,
                color: AppColors.primaryTeal.withAlpha(100),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: isUrdu
              ? TextStyle(
                  fontFamily: 'NotoNastaliqUrdu',
                  fontSize: 15,
                  height: 2.0,
                  color: isDark
                      ? (isMain ? Colors.white : Colors.white70)
                      : AppColors.textPrimaryLight,
                )
              : TextStyle(
                  fontSize: isMain ? 16 : 14,
                  height: 1.5,
                  color: isDark
                      ? (isMain ? Colors.white : Colors.white70)
                      : AppColors.textPrimaryLight,
                ),
          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}
