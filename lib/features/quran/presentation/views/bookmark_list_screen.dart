import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import 'mushaf_view_screen.dart';
import '../controllers/bookmark_controller.dart';
import '../../../../services/quran_db_service.dart';

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String textFont = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu
              ? 'محفوظ شدہ نشانات (بک مارکس)'
              : (isPashto ? 'نښانې' : 'Saved Bookmarks'),
          style: TextStyle(
            fontFamily: textFont,
            fontWeight: FontWeight.bold,
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
      body: bookmarksState.when(
        data: (bookmarksList) {
          if (bookmarksList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.primaryTeal.withValues(alpha: 0.06),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryTeal.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.bookmark_border_rounded,
                      size: 40,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.primaryTeal.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isUrdu
                        ? 'کوئی نشان محفوظ نہیں ہے'
                        : (isPashto
                            ? 'هیڅ نښه نه ده خوندي شوې'
                            : 'No bookmarks saved yet'),
                    style: TextStyle(
                      fontFamily: textFont,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                      fontSize: isRtl ? 14 : 15,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: bookmarksList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final verse = bookmarksList[index];
              final bool hasCustomName = verse.bookmarkName != null;
              final surahName = isUrdu
                  ? 'سورہ ${quran.getSurahNameArabic(verse.surahNumber)}'
                  : 'Surah ${quran.getSurahName(verse.surahNumber)}';
              final verseInfo = isUrdu
                  ? 'آیت ${verse.verseNumber}'
                  : 'Verse ${verse.verseNumber}';
              final subtitleText = '$surahName • $verseInfo';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MushafViewScreen(
                            initialPage: verse.pageNumber,
                            highlightVerseId: verse.id,
                            isBookmarkHighlight: true,
                            shouldUpdateProgress: false,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                        children: [
                          // Bookmark Icon Badge
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primaryTeal.withValues(alpha: 0.12)
                                  : AppColors.primaryTeal.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primaryTeal.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.bookmark_rounded,
                              color: AppColors.accentGold,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text Content Area
                          Expanded(
                            child: Column(
                              crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hasCustomName ? verse.bookmarkName! : subtitleText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: hasCustomName ? textFont : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hasCustomName ? subtitleText : verse.textArabic,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: hasCustomName ? textFont : 'Amiri',
                                    fontSize: hasCustomName ? 13 : 15,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Delete Button
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              size: 22,
                            ),
                            color: AppColors.error.withValues(alpha: 0.8),
                            onPressed: () => ref
                                .read(bookmarkControllerProvider.notifier)
                                .toggleBookmarkState(verse),
                            splashRadius: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryTeal),
        ),
        error: (err, _) => Center(
          child: Text(
            'Error: $err',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
