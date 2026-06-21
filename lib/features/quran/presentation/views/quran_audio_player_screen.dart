import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'audio_playing_screen.dart';
import '../controllers/surah_juz_controller.dart';
import '../controllers/quran_audio_player_controller.dart';

class QuranAudioPlayerScreen extends ConsumerStatefulWidget {
  const QuranAudioPlayerScreen({super.key});

  @override
  ConsumerState<QuranAudioPlayerScreen> createState() => _QuranAudioPlayerScreenState();
}

class _QuranAudioPlayerScreenState extends ConsumerState<QuranAudioPlayerScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quranState = ref.watch(surahJuzControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
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
              onChanged: (val) => ref
                  .read(surahJuzControllerProvider.notifier)
                  .searchSurah(val),
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

          // Surah List
          Expanded(
            child: quranState.surahs.when(
              data: (_) {
                final list = quranState.filteredSurahs;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No Surah found',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return RawScrollbar(
                  controller: _scrollController,
                  thumbColor: AppColors.primaryTeal.withAlpha(150),
                  radius: const Radius.circular(8),
                  thickness: 6,
                  thumbVisibility: true,
                  interactive: true,
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: audioState.currentAudioUrl != null ? 100 : 20,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => Divider(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                      height: 1,
                      thickness: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final surah = list[index];
                      final isCurrent =
                          audioState.currentSurahNumber == surah.number;
                      final int totalVerses = quran.getVerseCount(
                        surah.number,
                      );
                      final downloadInfo = audioState.downloadInfoMap[surah.number];
                      final isDownloading = downloadInfo?.status == DownloadStatus.downloading;
                      final downloadProgress = downloadInfo?.progress ?? 0.0;
                      final isDownloaded = audioState.downloadedSurahs.contains(surah.number);

                      return InkWell(
                        onTap: () {
                          if (isCurrent) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AudioPlayingScreen(),
                              ),
                            );
                          } else {
                            ref
                                .read(
                                  quranAudioPlayerControllerProvider.notifier,
                                )
                                .playSurah(surah.number);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AudioPlayingScreen(),
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 4.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? AppColors.primaryTeal.withAlpha(30)
                                      : (isDark
                                            ? AppColors.surfaceDark
                                            : AppColors.primaryTeal.withAlpha(10)),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isCurrent
                                        ? AppColors.primaryTeal
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: isCurrent && audioState.isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primaryTeal,
                                        ),
                                      )
                                    : Icon(
                                        isCurrent && audioState.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: isCurrent
                                            ? AppColors.primaryTeal
                                            : (isDark
                                                  ? AppColors
                                                        .textSecondaryDark
                                                  : AppColors
                                                        .textSecondaryLight),
                                        size: 24,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surah.nameEnglish,
                                      style: TextStyle(
                                        fontWeight: isCurrent
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        fontSize: 15,
                                        color: isCurrent
                                            ? AppColors.primaryTeal
                                            : (isDark
                                                  ? AppColors.textPrimaryDark
                                                  : AppColors
                                                        .textPrimaryLight),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$totalVerses Verses • ${quran.getPlaceOfRevelation(surah.number)}',
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
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value: downloadProgress,
                                        strokeWidth: 2.5,
                                        color: AppColors.primaryTeal,
                                        backgroundColor: AppColors.primaryTeal.withAlpha(30),
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
                                    hapticFeedBack();
                                    ref
                                        .read(
                                          quranAudioPlayerControllerProvider
                                              .notifier,
                                        )
                                        .downloadSurah(surah.number);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black54,
                                ),
                              const SizedBox(width: 12),
                              Text(
                                surah.nameArabic,
                                style: GoogleFonts.amiri(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: isCurrent
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
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryTeal,
                ),
              ),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

