import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/data_provider.dart';
import 'chapters_screen.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(booksProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
         'Hadith Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontFamily: isUrdu ? GoogleFonts.amiri().fontFamily : null,
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
              hint: Text( 'Search Books...'),
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
            child: booksAsync.when(
              data: (books) {
                final filteredBooks = books.where((book) {
                  return book.bookName.toLowerCase().contains(_searchQuery) ||
                      book.bookNameUrdu.contains(_searchQuery);
                }).toList();

                if (filteredBooks.isEmpty) {
                  return Center(
                    child: Text(
              'No Book found',
                      style: TextStyle(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filteredBooks.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];
                    final String displayTitle = isUrdu ? book.bookNameUrdu : book.bookName;

                    return InkWell(
                      onTap: () {
                        hapticFeedBack();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChaptersScreen(bookSlug: book.slug),
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
                          children: [
                            if (!isUrdu) ...[
                              _buildBookIcon(),
                              const SizedBox(width: 16),
                            ],
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                      fontFamily: isUrdu ? GoogleFonts.amiri().fontFamily : null,
                                    ),
                                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                  "${book.totalHadith} Hadiths",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            
                            if (isUrdu) ...[
                              const SizedBox(width: 16),
                              _buildBookIcon(),
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
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error, size: 40),
                    const SizedBox(height: 12),
                    Text("Error loading books"),
                    TextButton(
                      onPressed: () => ref.invalidate(booksProvider),
                      child: Text( "Retry", style: const TextStyle(color: AppColors.primaryTeal)),
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

  Widget _buildBookIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryTeal, AppColors.lightTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryTeal.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.auto_stories_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
