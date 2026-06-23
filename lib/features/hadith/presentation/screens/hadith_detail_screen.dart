import 'package:auraq/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/hadith_notifier.dart';

class HadithDetailScreen extends ConsumerStatefulWidget {
  final String bookSlug;
  final String chapterNumber;

  const HadithDetailScreen({
    super.key,
    required this.bookSlug,
    required this.chapterNumber,
  });

  @override
  ConsumerState<HadithDetailScreen> createState() => _HadithDetailScreenState();
}

class _HadithDetailScreenState extends ConsumerState<HadithDetailScreen> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Hadith Details',
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
      body: state is HadithLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryTeal))
          : state is HadithError
              ? Center(child: Text("Error: ${state.message}"))
              : state is HadithLoaded
                  ? PageView.builder(
                      itemCount: state.hadiths.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final hadith = state.hadiths[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                          child: Container(
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Header Info
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                      color: AppColors.primaryTeal.withAlpha(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryTeal,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Hadith #${hadith.hadithNumber}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.primaryTeal.withAlpha(100)),
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
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // Arabic Text
                                          Text(
                                            hadith.arabicText,
                                            style: GoogleFonts.amiri(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              height: 1.8,
                                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          const SizedBox(height: 32),
                                          
                                          // Urdu Translation
                                          _buildTranslationSection(
                                            title: "اردو ترجمہ",
                                            content: hadith.urduText,
                                            isUrdu: true,
                                            isDark: isDark,
                                          ),
                                          
                                          const SizedBox(height: 24),
                                          
                                          // English Translation
                                          _buildTranslationSection(
                                            title: "English Translation",
                                            content: hadith.englishText,
                                            isUrdu: false,
                                            isDark: isDark,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
      bottomNavigationBar: state is HadithLoaded && state.hadiths.length > 1
          ? Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swipe_outlined, color: AppColors.primaryTeal.withAlpha(150), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Swipe left or right for more",
                    style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildTranslationSection({
    required String title,
    required String content,
    required bool isUrdu,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 2,
              color: AppColors.primaryTeal.withAlpha(100),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primaryTeal,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: isUrdu 
            ? GoogleFonts.amiri(
                fontSize: 18,
                height: 1.6,
                color: isDark ? Colors.white70 : AppColors.textPrimaryLight,
              )
            : TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.textPrimaryLight,
              ),
          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}
