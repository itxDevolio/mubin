import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/data_provider.dart';
import '../../data/models/book_model.dart';
import 'hadith_list_screen.dart';
import 'hadith_detail_screen.dart';

class ChaptersScreen extends ConsumerStatefulWidget {
  final String bookSlug;

  const ChaptersScreen({super.key, required this.bookSlug});

  @override
  ConsumerState<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends ConsumerState<ChaptersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chaptersAsync = ref.watch(chaptersProvider(widget.bookSlug));
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';
    final bool isSearching = _searchQuery.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu ? 'ابواب' : 'Chapters',
          style: TextStyle(
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
            fontSize: isUrdu ? 16 : 18,
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.toLowerCase();
                });
              },
              textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
              textAlign: isUrdu ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                fontStyle: FontStyle.normal,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: isUrdu
                    ? 'حدیث نمبر سے تلاش کریں (مثلاً 1140)'
                    : 'Search Hadith by number (e.g. 1140)',
                hintStyle: TextStyle(
                  fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                  fontStyle: FontStyle.normal,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: isUrdu ? 12 : 12.5,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryTeal,
                  size: 22,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
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
            child: isSearching
                ? ref
                    .watch(
                      bookHadithSearchProvider(
                        BookSearchParam(
                          bookSlug: widget.bookSlug,
                          query: _searchQuery,
                          isUrdu: isUrdu,
                        ),
                      ),
                    )
                    .when(
                      data: (bookHadiths) {
                        if (bookHadiths.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    isUrdu
                                        ? "'$_searchQuery' سے متعلق اس کتاب میں کوئی حدیث نہیں ملی"
                                        : "No Hadiths found in this book for '$_searchQuery'",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: isUrdu
                                          ? 'NotoNastaliqUrdu'
                                          : 'Poppins',
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: bookHadiths.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final hadith = bookHadiths[index];
                            final String bookName = BookModel.getBookNameFromSlug(
                              hadith.bookSlug,
                              isUrdu,
                            );
                            final String heading = isUrdu
                                ? (hadith.headingUrdu.isNotEmpty
                                    ? hadith.headingUrdu
                                    : hadith.headingEnglish)
                                : (hadith.headingEnglish.isNotEmpty
                                    ? hadith.headingEnglish
                                    : hadith.headingUrdu);
                            final String previewText = isUrdu
                                ? hadith.urduText
                                : hadith.englishText;

                            return InkWell(
                              onTap: () {
                                hapticFeedBack();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        HadithDetailScreen(hadith: hadith),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceDark
                                      : Colors.white,
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
                                    Row(
                                      textDirection: isUrdu
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      children: [
                                        if (bookName.isNotEmpty) ...[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryTeal
                                                  .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              bookName,
                                              style: TextStyle(
                                                fontFamily: isUrdu
                                                    ? 'NotoNastaliqUrdu'
                                                    : 'Poppins',
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryTeal,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryTeal
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            isUrdu
                                                ? "حدیث # ${hadith.hadithNumber}"
                                                : "Hadith #${hadith.hadithNumber}",
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryTeal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (heading.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        heading,
                                        style: TextStyle(
                                          fontFamily: isUrdu
                                              ? 'NotoNastaliqUrdu'
                                              : 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: isDark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight,
                                        ),
                                        textAlign: isUrdu
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Text(
                                      previewText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: isUrdu
                                            ? 'NotoNastaliqUrdu'
                                            : 'Poppins',
                                        fontSize: 13,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                        height: 1.4,
                                      ),
                                      textAlign: isUrdu
                                          ? TextAlign.right
                                          : TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryTeal,
                        ),
                      ),
                      error: (err, _) => Center(
                        child: Text(
                          isUrdu
                              ? "حدیث تلاش کرنے میں خرابی: $err"
                              : "Error searching hadiths: $err",
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    )
                : chaptersAsync.when(
                    data: (chapters) {
                      if (chapters.isEmpty) {
                        return Center(
                          child: Text(
                            isUrdu ? 'کوئی باب نہیں ملا' : 'No Chapter found',
                            style: TextStyle(
                              fontFamily: isUrdu
                                  ? 'NotoNastaliqUrdu'
                                  : 'Poppins',
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: chapters.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final chapter = chapters[index];
                          final String displayTitle = isUrdu
                              ? chapter.chapterUrdu
                              : chapter.chapterEnglish;

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
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : Colors.white,
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
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: isUrdu
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isDark
                                            ? Colors.white
                                            : AppColors.textPrimaryLight,
                                        fontFamily: isUrdu
                                            ? 'NotoNastaliqUrdu'
                                            : null,
                                        height: 1.5,
                                      ),
                                      textAlign: isUrdu
                                          ? TextAlign.right
                                          : TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    isUrdu
                                        ? Icons.arrow_back_ios_new_rounded
                                        : Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: AppColors.primaryTeal,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    error: (err, _) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 40,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isUrdu
                                ? "ابواب لوڈ کرنے میں خرابی"
                                : "Error loading chapters",
                          ),
                          TextButton(
                            onPressed: () => ref.invalidate(
                              chaptersProvider(widget.bookSlug),
                            ),
                            child: Text(
                              isUrdu ? "دوبارہ کوشش کریں" : "Retry",
                              style: const TextStyle(
                                color: AppColors.primaryTeal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
