import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/app_colors.dart';
import '../../domain/entities/reciter.dart';
import '../controllers/quran_audio_controller.dart';
import 'quran_audio_player_screen.dart';

/// Home screen for Quran Audio feature
/// Displays list of all Surahs with play and download options
class QuranAudioHomeScreen extends ConsumerStatefulWidget {
  const QuranAudioHomeScreen({super.key});

  @override
  ConsumerState<QuranAudioHomeScreen> createState() => _QuranAudioHomeScreenState();
}

class _QuranAudioHomeScreenState extends ConsumerState<QuranAudioHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<int> _filteredSurahs = List.generate(114, (i) => i + 1);

  void _filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = List.generate(114, (i) => i + 1);
      } else {
        _filteredSurahs = List.generate(114, (i) => i + 1).where((surahNum) {
          final nameEnglish = quran.getSurahNameEnglish(surahNum).toLowerCase();
          final nameArabic = quran.getSurahNameArabic(surahNum);
          return nameEnglish.contains(query.toLowerCase()) ||
              nameArabic.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(quranAudioControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Quran Audio',
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
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSurahs,
              style: TextStyle(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Search Surah...',
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

          // Reciter Info Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.person_rounded,
                  size: 18,
                  color: AppColors.primaryTeal,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Reciter: ${audioState.currentReciter.name}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _showReciterBottomSheet(context),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: AppColors.primaryTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Surah List
          Expanded(
            child: _filteredSurahs.isEmpty
                ? Center(
                    child: Text(
                      'No Surah found',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 100,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filteredSurahs.length,
                    separatorBuilder: (context, index) => Divider(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                      height: 1,
                      thickness: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final surahNum = _filteredSurahs[index];
                      return _buildSurahTile(surahNum, audioState, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahTile(int surahNum, dynamic state, bool isDark) {
    final isCurrentSurah = state.currentSurahNumber == surahNum;
    final isPlaying = state.isPlaying && isCurrentSurah;
    final isLoading = state.isLoading && isCurrentSurah;
    final isDownloaded = state.isSurahDownloaded(surahNum);
    final downloadStatus = state.getDownloadStatus(surahNum);
    final isDownloading = downloadStatus?.isDownloading ?? false;
    final downloadProgress = downloadStatus?.progress ?? 0.0;
    final totalVerses = quran.getVerseCount(surahNum);

    return InkWell(
      onTap: () {
        if (isCurrentSurah) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuranAudioPlayerScreen(),
            ),
          );
        } else {
          ref
              .read(quranAudioControllerProvider.notifier)
              .playSurah(surahNum);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuranAudioPlayerScreen(),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
        child: Row(
          children: [
            // Play Button / Loading Indicator
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCurrentSurah
                    ? AppColors.primaryTeal.withOpacity(0.12)
                    : (isDark
                        ? AppColors.surfaceDark
                        : AppColors.primaryTeal.withOpacity(0.04)),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrentSurah
                      ? AppColors.primaryTeal
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryTeal,
                      ),
                    )
                  : Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: isCurrentSurah
                          ? AppColors.primaryTeal
                          : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight),
                      size: 24,
                    ),
            ),
            const SizedBox(width: 16),

            // Surah Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quran.getSurahNameEnglish(surahNum),
                    style: TextStyle(
                      fontWeight: isCurrentSurah
                          ? FontWeight.bold
                          : FontWeight.w600,
                      fontSize: 15,
                      color: isCurrentSurah
                          ? AppColors.primaryTeal
                          : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalVerses Verses • ${quran.getPlaceOfRevelation(surahNum)}',
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

            // Download Status
            if (isDownloading)
              SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: downloadProgress,
                      strokeWidth: 2.5,
                      color: AppColors.primaryTeal,
                      backgroundColor: AppColors.primaryTeal.withOpacity(0.1),
                    ),
                    if (downloadProgress > 0)
                      Text(
                        '${(downloadProgress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 8,
                          color: AppColors.primaryTeal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              )
            else if (isDownloaded)
              const Icon(
                Icons.download_done_rounded,
                color: AppColors.primaryTeal,
                size: 20,
              )
            else
              IconButton(
                icon: const Icon(
                  Icons.download_for_offline_outlined,
                  size: 20,
                ),
                onPressed: () {
                  ref
                      .read(quranAudioControllerProvider.notifier)
                      .downloadSurah(surahNum);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            const SizedBox(width: 12),

            // Surah Number in Arabic
            Text(
              quran.getSurahNameArabic(surahNum),
              style: GoogleFonts.amiri(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: isCurrentSurah
                    ? AppColors.accentGold
                    : (isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryTeal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReciterBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final audioState = ref.read(quranAudioControllerProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        final reciters = [
          Reciters.misharyRashidAlafasy,
          Reciters.abdulBasetAbdulSamad,
          Reciters.abdurRahmanAsSudais,
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Reciter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '3 reciters available',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              ...reciters.map((reciter) {
                final isSelected = audioState.currentReciter == reciter;
                return InkWell(
                  onTap: () {
                    ref
                        .read(quranAudioControllerProvider.notifier)
                        .setReciter(reciter);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isSelected
                              ? AppColors.primaryTeal
                              : (isDark ? Colors.white10 : Colors.black12),
                          child: Icon(
                            Icons.person_rounded,
                            color: isSelected ? Colors.white : AppColors.primaryTeal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reciter.name,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                reciter.arabicName,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.white60 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primaryTeal,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}