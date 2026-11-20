import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/hadith_notifier.dart';
import '../../data/models/book_model.dart';
import 'hadith_detail_screen.dart';

class HadithListScreen extends ConsumerStatefulWidget {
  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  const HadithListScreen({
    super.key,
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
  });

  @override
  ConsumerState<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends ConsumerState<HadithListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(hadithProvider.notifier)
          .fetchHadiths(widget.bookSlug, widget.chapterNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hadithProvider);
    final hadithLang = ref.watch(hadithLanguageProvider);
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final bool isUrdu = hadithLang == 'ur';
    final String bookName = BookModel.getBookNameFromSlug(
      widget.bookSlug,
      isUrdu,
    );

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.chapterName,
          style: TextStyle(
            fontSize: isUrdu ? 15 : 16,
            fontWeight: FontWeight.bold,
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
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
      body: state is HadithLoading
          ? const Center(
        child: CircularProgressIndicator(color: AppColors.primaryTeal),
      )
          : state is HadithError
          ? Center(child: Text("Error: ${state.message}"))
          : state is HadithLoaded
          ? ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: state.hadiths.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final hadith = state.hadiths[index];

          final String heading = isUrdu
              ? (hadith.headingUrdu.isNotEmpty
              ? hadith.headingUrdu
              : hadith.headingEnglish)
              : (hadith.headingEnglish.isNotEmpty
              ? hadith.headingEnglish
              : hadith.headingUrdu);

          return InkWell(
            onTap: () {
              hapticFeedBack();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HadithDetailScreen(hadith: hadith),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDark ? 0.3 : 0.04,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isUrdu
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // Header Row: Book Name + Hadith Number + Status Badge
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    textDirection: isUrdu
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      if (bookName.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            bookName,
                            style: TextStyle(
                              fontFamily: isUrdu
                                  ? 'NotoNastaliqUrdu'
                                  : 'Poppins',
                              color: AppColors.primaryTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white10
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isUrdu
                              ? "حدیث ${hadith.hadithNumber}"
                              : "Hadith ${hadith.hadithNumber}",
                          style: TextStyle(
                            fontFamily: isUrdu
                                ? 'NotoNastaliqUrdu'
                                : 'Poppins',
                            color: isDark
                                ? Colors.white70
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                      if (hadith.status.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white10
                                : Colors.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            hadith.status,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTeal,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Compact Title Row with Arrow Indicator
                  const SizedBox(height: 10),
                  Row(
                    textDirection: isUrdu
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Expanded(
                        child: Text(
                          heading.isNotEmpty
                              ? heading
                              : (isUrdu
                              ? "حدیث نمبر ${hadith.hadithNumber}"
                              : "Hadith Number ${hadith.hadithNumber}"),
                          textAlign: isUrdu
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily: isUrdu
                                ? 'NotoNastaliqUrdu'
                                : 'Poppins',
                            fontSize: isUrdu ? 14 : 14.5,
                            fontWeight: FontWeight.bold,
                            height: isUrdu ? 1.5 : 1.3,
                            color: isDark
                                ? Colors.white
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isUrdu
                            ? Icons.arrow_back_ios_rounded
                            : Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: AppColors.primaryTeal.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
          : const SizedBox(),
    );
  }
}
