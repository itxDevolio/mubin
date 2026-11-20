import 'dart:async';
import 'dart:io';
import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/core/widgets/glass_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran/quran.dart' as quran;
import 'package:mubin/features/quran/presentation/controllers/quran_audio_player_controller.dart';
import 'package:mubin/features/quran/presentation/controllers/surah_juz_controller.dart';
import 'package:mubin/features/quran/presentation/views/audio_playing_screen.dart';

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
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu ? 'تلاوت آڈیو' : (isPashto ? 'د قرآن تلاوت آډیو' : 'Quran Audio'),
          style: TextStyle(
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
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
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
              cursorColor: AppColors.primaryTeal,
              style: TextStyle(
                fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: isUrdu
                    ? 'سورت تلاش کریں'
                    : (isPashto ? 'سورت لټول' : 'Search Surah'),
                hintStyle: TextStyle(
                  fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
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
                      isUrdu
                          ? 'کوئی سورت نہیں ملی'
                          : (isPashto ? 'هیڅ سورت ونه موندل شو' : 'No Surah found'),
                      style: TextStyle(
                        fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
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
                            vertical: 12.0,
                            horizontal: 4.0,
                          ),
                          child: Row(
                            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                            children: [
                              // Number Badge
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? AppColors.primaryTeal.withValues(alpha: 0.12)
                                      : (isDark
                                            ? AppColors.primaryTeal.withValues(alpha: 0.12)
                                            : AppColors.primaryTeal.withValues(alpha: 0.08)),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isCurrent
                                        ? AppColors.primaryTeal
                                        : AppColors.primaryTeal.withValues(alpha: 0.2),
                                    width: isCurrent ? 1.5 : 1,
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
                              Expanded(
                                child: Text(
                                  isRtl ? surah.nameArabic : surah.nameEnglish,
                                  textAlign: isRtl
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: isRtl ? 'Amiri' : 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: isRtl ? 20 : 16,
                                    color: isCurrent
                                        ? AppColors.primaryTeal
                                        : (isDark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight),
                                    letterSpacing: isRtl ? 0 : 0.2,
                                  ),
                                ),
                              ),
                              if (isCurrent)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.volume_up_rounded,
                                    color: AppColors.primaryTeal,
                                    size: 22,
                                  ),
                                ),
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
                                Builder(
                                  builder: (context) {
                                    final isProtected = ref.read(quranAudioPlayerControllerProvider.notifier).isAdProtectedSurah(surah.number);
                                    return IconButton(
                                      icon: const Icon(
                                        Icons.download_for_offline_outlined,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        hapticFeedBack();
                                        if (isProtected) {
                                          _loadAndShowAd(() {
                                            ref
                                                .read(quranAudioPlayerControllerProvider.notifier)
                                                .downloadSurah(surah.number);
                                          });
                                        } else {
                                          ref
                                              .read(quranAudioPlayerControllerProvider.notifier)
                                              .downloadSurah(surah.number);
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black54,
                                    );
                                  },
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
      bottomNavigationBar: audioState.errorMessage != null && !audioState.isPlaying && !audioState.isLoading
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: Border(
                  top: BorderSide(
                    color: Colors.red.withAlpha(80),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off_rounded, color: Colors.red, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        audioState.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        hapticFeedBack();
                        ref.read(quranAudioPlayerControllerProvider.notifier).retryCurrentAudio();
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: const Text("Retry", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : (audioState.currentSurahNumber != null
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    border: Border(
                      top: BorderSide(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        width: 1,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AudioPlayingScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryTeal,
                              shape: BoxShape.circle,
                            ),
                            child: audioState.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    audioState.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quran.getSurahNameEnglish(audioState.currentSurahNumber!),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                Text(
                                  audioState.currentReciter.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              audioState.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                              color: AppColors.primaryTeal,
                              size: 32,
                            ),
                            onPressed: () {
                              hapticFeedBack();
                              if (audioState.isPlaying) {
                                ref.read(quranAudioPlayerControllerProvider.notifier).pauseAudio();
                              } else {
                                ref.read(quranAudioPlayerControllerProvider.notifier).resumeAudio();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null),
    );
  }

  void _loadAndShowAd(VoidCallback onRewarded) {
    bool adHandled = false;
    Timer? timeoutTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GlassLoadingOverlay(message: "Loading Ad..."),
      ),
    );

    timeoutTimer = Timer(const Duration(seconds: 7), () {
      if (!adHandled) {
        adHandled = true;
        if (Navigator.canPop(context)) {
          Navigator.pop(context); // Dismiss loading overlay
        }
        onRewarded();
      }
    });

    final String rewardedAdUnitId = Platform.isAndroid
        ? 'ca-app-pub-5751989678728366/3969215228'
        : 'ca-app-pub-5751989678728366/3969215228';

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (adHandled) {
            ad.dispose();
            return;
          }
          adHandled = true;
          timeoutTimer?.cancel();
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // Dismiss loading overlay
          }

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              onRewarded(); // Fallback
            },
          );
          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              onRewarded();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (adHandled) return;
          adHandled = true;
          timeoutTimer?.cancel();
          debugPrint('RewardedAd failed to load: $error');
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // Dismiss loading overlay
          }
          onRewarded(); // Fallback if ad fails to load
        },
      ),
    );
  }
}
