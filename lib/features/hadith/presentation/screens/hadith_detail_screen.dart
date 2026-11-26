import 'package:mubin/core/app_colors.dart';
import 'package:mubin/features/hadith/domain/entities/hadith.dart';
import 'package:mubin/features/hadith/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/hadith_notifier.dart';

class HadithDetailScreen extends ConsumerWidget {
  final HadithEntity hadith;

  const HadithDetailScreen({super.key, required this.hadith});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hadithLang = ref.watch(hadithLanguageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = hadithLang == 'ur';
    final bool isPashto = hadithLang == 'ps';
    final bool isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto
        ? 'Amiri'
        : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    final String bookName = BookModel.getBookNameFromSlug(
      hadith.bookSlug,
      isRtl,
    );

    final String heading = isRtl
        ? (hadith.headingUrdu.isNotEmpty
              ? hadith.headingUrdu
              : hadith.headingEnglish)
        : (hadith.headingEnglish.isNotEmpty
              ? hadith.headingEnglish
              : hadith.headingUrdu);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isRtl
              ? "حدیث ${hadith.hadithNumber}"
              : "Hadith ${hadith.hadithNumber}",
          style: TextStyle(
            fontFamily: fontFamily,
            letterSpacing: 0.5,
            fontSize: isRtl ? 16 : 18,
            fontWeight: FontWeight.bold,
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
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Header Info Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: WrapAlignment.spaceBetween,
                      textDirection: isRtl
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        if (bookName.isNotEmpty)
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
                              bookName,
                              style: TextStyle(
                                fontFamily: fontFamily,
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
                              color: AppColors.primaryTeal.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hadith.status.isNotEmpty ? hadith.status : "Hadith",
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
                      crossAxisAlignment: isRtl
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        // Hadith Title / Heading
                        if (heading.isNotEmpty) ...[
                          Text(
                            heading,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: isRtl ? 16 : 16,
                              fontWeight: FontWeight.bold,
                              height: isRtl ? 1.6 : 1.4,
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textPrimaryLight,
                            ),
                            textAlign: isRtl ? TextAlign.right : TextAlign.left,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Arabic Text
                        if (hadith.arabicText.isNotEmpty) ...[
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
                          const SizedBox(height: 30),
                        ],

                        // Translation Section
                        if (isRtl && hadith.urduText.isNotEmpty)
                          _buildTranslationSection(
                            title: isPashto ? "ترجمہ" : "ترجمہ",
                            content: hadith.urduText,
                            fontFamily: fontFamily,
                            isRtl: true,
                            isDark: isDark,
                            isMain: true,
                          )
                        else if (hadith.englishText.isNotEmpty)
                          _buildTranslationSection(
                            title: "English Translation",
                            content: hadith.englishText,
                            fontFamily: fontFamily,
                            isRtl: false,
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
    required String fontFamily,
    required bool isRtl,
    required bool isDark,
    required bool isMain,
  }) {
    return Column(
      crossAxisAlignment: isRtl
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isRtl
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isRtl)
              Container(
                width: 24,
                height: 2,
                color: AppColors.primaryTeal.withValues(alpha: 0.4),
              ),
            if (!isRtl) const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: fontFamily,
                color: AppColors.primaryTeal,
                fontSize: isMain ? 15 : 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isRtl) const SizedBox(width: 8),
            if (isRtl)
              Container(
                width: 24,
                height: 2,
                color: AppColors.primaryTeal.withValues(alpha: 0.4),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: isMain ? 15 : 14,
            height: isRtl ? (fontFamily == 'Amiri' ? 1.8 : 2.0) : 1.5,
            color: isDark
                ? (isMain ? Colors.white : Colors.white70)
                : AppColors.textPrimaryLight,
          ),
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}
