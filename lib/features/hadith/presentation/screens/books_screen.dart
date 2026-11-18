import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/data_provider.dart';
import '../../data/models/book_model.dart';
import 'chapters_screen.dart';
import 'hadith_detail_screen.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<String> _urduTopics = [
    'نماز',
    'روزہ',
    'زکوٰۃ',
    'توبہ',
    'صبر',
    'والدين',
    'اخلاق',
    'دعا',
    'صدقہ',
    'نکاح'
  ];

  final List<String> _englishTopics = [
    'Prayer',
    'Fasting',
    'Charity',
    'Repentance',
    'Patience',
    'Parents',
    'Morals',
    'Dua',
    'Forgiveness'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(booksProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    final isSearching = _searchQuery.trim().length >= 2;
    final topics = isUrdu ? _urduTopics : _englishTopics;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu ? 'صحاح ستہ و موضوعاتی تلاش' : 'Sihah Sittah & Global Search',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment:
              isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Subject & Topic Search Banner / Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.primaryTeal.withValues(alpha: 0.2), AppColors.surfaceDark]
                      : [AppColors.primaryTeal.withValues(alpha: 0.12), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.primaryTeal.withValues(alpha: 0.3),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTeal.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.travel_explore_rounded,
                          color: AppColors.primaryTeal,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isUrdu
                              ? "موضوعاتی اور عالمی تلاش (Global Topic Search)"
                              : "Global Subject & Topic Search",
                          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: isUrdu ? 14 : 15,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isUrdu
                        ? "کسی بھی مسئلے، حکم یا موضوع (جیسے نماز، روزہ، طلاق، توبہ) کے بارے میں تمام کتبِ احادیث سے احادیث باآسانی تلاش کریں۔"
                        : "Search Hadiths across all 6 major books for any issue, topic, or subject (e.g. Prayer, Fasting, Divorce, Patience).",
                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                      fontSize: isUrdu ? 12 : 12.5,
                      height: 1.5,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Search Input Field with RTL/LTR Support
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                  fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: isUrdu
                      ? "موضوع یا مسئلہ درج کریں (مثلاً: نماز، طلاق، صبر)..."
                      : "Search topic or issue (e.g. Prayer, Divorce, Patience)...",
                  hintStyle: TextStyle(
                    fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: isUrdu ? 13 : 13.5,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryTeal,
                      size: 24,
                    ),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 20,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = "";
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Popular Topic Suggestion Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                reverse: isUrdu,
                itemCount: topics.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  final isSelected = _searchQuery.trim() == topic;
                  return ActionChip(
                    label: Text(
                      topic,
                      style: TextStyle(
                        fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight),
                      ),
                    ),
                    backgroundColor: isSelected
                        ? AppColors.primaryTeal
                        : (isDark ? AppColors.surfaceDark : Colors.white),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primaryTeal
                          : AppColors.primaryTeal.withValues(alpha: 0.3),
                    ),
                    onPressed: () {
                      hapticFeedBack();
                      setState(() {
                        _searchQuery = topic;
                        _searchController.text = topic;
                        _searchController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _searchController.text.length),
                        );
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 2. Global Search Results Mode OR 6 Books Grid Mode
            if (isSearching) ...[
              // Global Search Results Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  Text(
                    isUrdu
                        ? "موضوعاتی تلاش کے نتائج ('$_searchQuery'):"
                        : "Topic Search Results for '$_searchQuery':",
                    style: TextStyle(
                      fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                      fontSize: isUrdu ? 15 : 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = "";
                      });
                    },
                    child: Text(
                      isUrdu ? "صاف کریں" : "Clear Search",
                      style: const TextStyle(
                        color: AppColors.primaryTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ref
                  .watch(globalHadithSearchProvider(
                      SearchParam(query: _searchQuery, isUrdu: isUrdu)))
                  .when(
                    data: (hadiths) {
                      if (hadiths.isEmpty) {
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
                                      ? "'$_searchQuery' سے متعلق کوئی حدیث نہیں ملی"
                                      : "No Hadiths found for '$_searchQuery'",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                        isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hadiths.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final hadith = hadiths[index];
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
                                    color: Colors.black
                                        .withValues(alpha: isDark ? 0.3 : 0.04),
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
                                  // Top Row: Book Name, Hadith Number & Status Badge
                                  Row(
                                    textDirection: isUrdu
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    children: [
                                      if (bookName.isNotEmpty) ...[
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
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
                                              color: AppColors.primaryTeal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.white10
                                              : Colors.black.withValues(alpha: 0.04),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                      const Spacer(),
                                      if (hadith.status.isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? Colors.white10
                                                : Colors.black.withValues(alpha: 0.05),
                                            borderRadius:
                                                BorderRadius.circular(6),
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

                                  // Heading / Topic Title
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
                                        color: AppColors.primaryTeal
                                            .withValues(alpha: 0.6),
                                      ),
                                    ],
                                  ),

                                  if (previewText.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      previewText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: isUrdu
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: isUrdu
                                            ? 'NotoNastaliqUrdu'
                                            : 'Poppins',
                                        fontSize: isUrdu ? 12 : 12.5,
                                        height: 1.4,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: Column(
                          children: [
                            const CircularProgressIndicator(
                              color: AppColors.primaryTeal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isUrdu
                                  ? "تمام کتب میں موضوعاتی احادیث تلاش کی جا رہی ہیں..."
                                  : "Searching global Hadiths across books...",
                              style: TextStyle(
                                fontFamily:
                                    isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    error: (err, _) => Center(
                      child: Text(
                        "Error searching hadiths: $err",
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ),
            ] else ...[
              // 6 Books Grid Mode Header & Grid
              Row(
                textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  Text(
                    isUrdu ? "صحاح ستہ کی بنیادی کتب" : "Major Hadith Books",
                    style: TextStyle(
                      fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                      fontSize: isUrdu ? 15 : 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              booksAsync.when(
                data: (books) {
                  return Directionality(
                    textDirection:
                        isUrdu ? TextDirection.rtl : TextDirection.ltr,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: books.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.96,
                      ),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final String displayTitle =
                            isUrdu ? book.bookNameUrdu : book.bookName;
                        final String writerName = isUrdu
                            ? BookModel.getUrduWriterName(
                                book.slug, book.writerName)
                            : book.writerName;

                        return InkWell(
                          onTap: () {
                            hapticFeedBack();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ChaptersScreen(bookSlug: book.slug),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha: isDark ? 0.3 : 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Icon Badge
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryTeal
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.auto_stories_rounded,
                                    color: AppColors.primaryTeal,
                                    size: 20,
                                  ),
                                ),
                                const Spacer(),

                                // Book Title
                                Text(
                                  displayTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily:
                                        isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: isUrdu ? 14.5 : 15,
                                    height: isUrdu ? 1.5 : 1.2,
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 3),

                                // Writer Name
                                Text(
                                  writerName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily:
                                        isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                                    fontSize: isUrdu ? 10 : 11,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Hadith Count Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryTeal
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isUrdu
                                        ? "${book.totalHadith} احادیث"
                                        : "${book.totalHadith} Hadiths",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryTeal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CircularProgressIndicator(
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
                error: (err, stack) => Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      const Text("Error loading books"),
                      TextButton(
                        onPressed: () => ref.invalidate(booksProvider),
                        child: const Text(
                          "Retry",
                          style: TextStyle(color: AppColors.primaryTeal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),
            const AdBannerWidget(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
