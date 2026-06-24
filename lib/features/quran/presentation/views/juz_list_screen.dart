import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/utils/quran_utils.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'mushaf_view_screen.dart';

class JuzListScreen extends ConsumerStatefulWidget {
  const JuzListScreen({super.key});

  @override
  ConsumerState<JuzListScreen> createState() => _JuzListScreenState();
}

class _JuzListScreenState extends ConsumerState<JuzListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(settingsControllerProvider).language;
    final isUrdu = lang == 'ur';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filter Juz based on state query
    final filteredJuz = List.generate(30, (i) => i + 1).where((j) {
      final name = isUrdu
          ? QuranUtils.juzNamesArabic[j - 1]
          : QuranUtils.juzNamesEnglish[j - 1];
      return name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          j.toString() == _searchQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Juz / Para List',
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
      body: Column(
        children: [
          // Premium Styled Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: TextStyle(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Search Juz / Para...',
                hintStyle: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryTeal,
                  size: 22,
                ),
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

          // Juz List Section
          Expanded(
            child: filteredJuz.isEmpty && _searchQuery.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No Juz found for "$_searchQuery"',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : filteredJuz.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              color: AppColors.primaryTeal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading Juz...',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                    itemCount: filteredJuz.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                      height: 1,
                      thickness: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final juzNumber = filteredJuz[index];

                      // Explicit Names Parsing
                      final juzEnglishName =
                          QuranUtils.juzNamesEnglish[juzNumber - 1];
                      final juzArabicName =
                          QuranUtils.juzNamesArabic[juzNumber - 1];

                      return InkWell(
                        onTap: () {
                          final Map<int, List<int>> juzData =
                              Map<int, List<int>>.from(
                                quran.getSurahAndVersesFromJuz(juzNumber),
                              );
                          int startingSurah = juzData.keys.first;
                          int startingVerse = juzData[startingSurah]!.first;
                          int calculatedPage = quran.getPageNumber(
                            startingSurah,
                            startingVerse,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MushafViewScreen(
                                initialPage: calculatedPage,
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
                              // Elegant Indexed Number Badge
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.primaryTeal.withValues(alpha: 0.12)
                                      : AppColors.primaryTeal.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primaryTeal.withValues(
                                      alpha: 0.2,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$juzNumber',
                                  style: const TextStyle(
                                    color: AppColors.primaryTeal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Text Content Area (English/Transliteration details)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      juzEnglishName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Juz $juzNumber",
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

                              // Pure Arabic Text Display on Right Side
                              Text(
                                juzArabicName,
                                style: GoogleFonts.amiri(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.accentGold
                                      : AppColors.primaryTeal,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
