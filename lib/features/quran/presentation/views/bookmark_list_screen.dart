import 'package:auraq/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mushaf_view_screen.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Saved Bookmarks',
          style: TextStyle(
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.primaryTeal.withValues(alpha: 0.06),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.bookmark_border_rounded,
                      size: 40,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.primaryTeal.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No bookmarks saved yet',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: bookmarksList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              height: 1,
              thickness: 0.8,
            ),
            itemBuilder: (context, index) {
              final verse = bookmarksList[index];
              final bool hasCustomName = verse.bookmarkName != null;

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MushafViewScreen(
                        initialPage: verse.pageNumber,
                        highlightVerseId: verse.id,
                        shouldUpdateProgress: false,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 4.0,
                  ),
                  child: Row(
                    children: [
                      // Elegant Left Icon Badge
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.primaryTeal.withValues(alpha: 0.12)
                              : AppColors.primaryTeal.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primaryTeal.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.bookmark_rounded,
                          color: AppColors.accentGold,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Text Content (Title & Subtitle Info)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasCustomName
                                  ? verse.bookmarkName!
                                  : verse.textArabic,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textDirection: hasCustomName
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: hasCustomName
                                  ? TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight,
                                      letterSpacing: 0.2,
                                    )
                                  : GoogleFonts.amiri(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight,
                                    ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Surah ${verse.surahNumber} • Verse ${verse.verseNumber} • Page ${verse.pageNumber}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Elegant Delete Button
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
