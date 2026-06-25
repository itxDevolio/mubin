import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/data_provider.dart';
import 'hadith_list_screen.dart';

class ChaptersScreen extends ConsumerStatefulWidget {
  final String bookSlug;
  const ChaptersScreen({super.key, required this.bookSlug});

  @override
  ConsumerState<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends ConsumerState<ChaptersScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final chaptersAsync = ref.watch(chaptersProvider(widget.bookSlug));
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
           'Chapters',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.toLowerCase();
                });
              },
              style: TextStyle(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Search Chapters...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryTeal,
                  size: 22,
                ),
                filled: true,
                fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primaryTeal,
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: chaptersAsync.when(
              data: (chapters) {
                final filteredChapters = chapters.where((chapter) {
                  return chapter.chapterEnglish.toLowerCase().contains(_searchQuery) ||
                      chapter.chapterUrdu.contains(_searchQuery) ||
                      chapter.chapterNumber.contains(_searchQuery);
                }).toList();

                if (filteredChapters.isEmpty) {
                  return Center(
                    child: Text(
                      'No Chapter found',
                      style: TextStyle(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filteredChapters.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final chapter = filteredChapters[index];
                    final String displayTitle = isUrdu ? chapter.chapterUrdu : chapter.chapterEnglish;

                    return InkWell(
                      onTap: () {
                        hapticFeedBack();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HadithListScreen(
                              bookSlug: widget.bookSlug,
                              chapterNumber: chapter.chapterNumber,
                              chapterName: displayTitle,
                            ),
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
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(isDark ? 30 : 10),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!isUrdu) ...[
                              _buildChapterBadge(chapter.chapterNumber),
                              const SizedBox(width: 16),
                            ],
                            
                            Expanded(
                              child: Text(
                                displayTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                  fontFamily: isUrdu ? GoogleFonts.amiri().fontFamily : null,
                                  height: 1.5,
                                ),
                                textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                              ),
                            ),
                            
                            if (isUrdu) ...[
                              const SizedBox(width: 16),
                              _buildChapterBadge(chapter.chapterNumber),
                            ] else ...[
                               const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.primaryTeal,
                              ),
                            ],
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error, size: 40),
                    const SizedBox(height: 12),
                    Text(isUrdu ? "ابواب لوڈ کرنے میں خرابی" : "Error loading chapters"),
                    TextButton(
                      onPressed: () => ref.invalidate(chaptersProvider(widget.bookSlug)),
                      child: Text(isUrdu ? "دوبارہ کوشش کریں" : "Retry", style: const TextStyle(color: AppColors.primaryTeal)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterBadge(String number) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withAlpha(20),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryTeal.withAlpha(50),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: const TextStyle(
          color: AppColors.primaryTeal,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
