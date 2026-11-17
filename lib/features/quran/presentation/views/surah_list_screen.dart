import 'package:mubin/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/services/settings_controller.dart';
import '../controllers/surah_juz_controller.dart';
import 'mushaf_view_screen.dart';

class SurahListScreen extends ConsumerStatefulWidget {
  const SurahListScreen({super.key});

  @override
  ConsumerState<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends ConsumerState<SurahListScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<SettingsState>(settingsControllerProvider, (previous, next) {
      if (previous?.language != next.language) {
        ref.read(surahJuzControllerProvider.notifier).loadSurahs();
      }
    });

    final quranState = ref.watch(surahJuzControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu ? 'سورتوں کی فہرست' : 'Surah List',
          style: TextStyle(
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
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
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              onChanged: (val) => ref
                  .read(surahJuzControllerProvider.notifier)
                  .searchSurah(val),
              textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
              style: TextStyle(
                fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: isUrdu ? 'سورت کا نام تلاش کریں...' : 'Search Surah...',
                hintStyle: TextStyle(
                  fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
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

          // Surah List Section
          Expanded(
            child: quranState.surahs.when(
              data: (_) {
                final list = quranState.filteredSurahs;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      isUrdu ? 'کوئی سورت نہیں ملی' : 'No Surah found',
                      style: TextStyle(
                        fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: list.length,
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
                    final surah = list[index];

                    final totalVerses = quran.getVerseCount(surah.number);
                    final rawRevelation = quran.getPlaceOfRevelation(surah.number);
                    final revelationPlace = isUrdu
                        ? (rawRevelation == 'Makkah' ? "مکی" : "مدنی")
                        : rawRevelation;

                    return InkWell(
                      onTap: () {
                        int startingPage = quran
                            .getSurahPages(surah.number)
                            .first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MushafViewScreen(
                              initialPage: startingPage,
                              shouldUpdateProgress: false,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 4.0,
                        ),
                        child: Row(
                          textDirection:
                              isUrdu ? TextDirection.rtl : TextDirection.ltr,
                          children: [
                            // Number Badge
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.primaryTeal.withValues(
                                        alpha: 0.12,
                                      )
                                    : AppColors.primaryTeal.withValues(
                                        alpha: 0.08,
                                      ),
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
                                '${surah.number}',
                                style: const TextStyle(
                                  color: AppColors.primaryTeal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Surah Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isUrdu ? surah.nameArabic : surah.nameEnglish,
                                    style: TextStyle(
                                      fontFamily: isUrdu ? 'Amiri' : 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: isUrdu ? 20 : 16,
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight,
                                      letterSpacing: isUrdu ? 0 : 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUrdu
                                        ? "$revelationPlace • $totalVerses آیات"
                                        : "$revelationPlace • $totalVerses Verses",
                                    style: TextStyle(
                                      fontFamily:
                                          isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                                      fontSize: isUrdu ? 11 : 12,
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondaryLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (!isUrdu) ...[
                              Text(
                                surah.nameArabic,
                                style: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.accentGold
                                      : AppColors.primaryTeal,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],

                            Icon(
                              isUrdu
                                  ? Icons.arrow_back_ios_rounded
                                  : Icons.arrow_forward_ios_rounded,
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
                );
              },
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primaryTeal),
                    SizedBox(height: 16),
                    Text('Loading Surahs...', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.error.withOpacity(0.8),
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Failed to load Surahs',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      err.toString(),
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () => ref
                          .read(surahJuzControllerProvider.notifier)
                          .loadSurahs(),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Retry'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryTeal,
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
