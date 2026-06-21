import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/app_colors.dart';
import '../controllers/quran_audio_controller.dart';
import '../views/quran_audio_player_screen.dart';

/// A mini audio player widget that can be displayed at the bottom of screens
/// Shows current playing Surah info and basic playback controls
class MiniAudioPlayer extends ConsumerWidget {
  const MiniAudioPlayer({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Don't show if nothing is playing
    if (audioState.isIdle || audioState.currentSurahNumber == null) {
      return const SizedBox.shrink();
    }

    final surahNumber = audioState.currentSurahNumber;
    final isPlaying = audioState.isPlaying;
    final isLoading = audioState.isLoading;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuranAudioPlayerScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress bar
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 4,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 12,
                ),
                activeTrackColor: AppColors.primaryTeal,
                inactiveTrackColor: AppColors.primaryTeal.withValues(alpha: 0.2),
                thumbColor: AppColors.primaryTeal,
              ),
              child: Slider(
                value: audioState.position.inSeconds.toDouble(),
                max: audioState.duration.inSeconds.toDouble().clamp(1.0, double.infinity),
                onChanged: (val) {
                  ref
                      .read(quranAudioControllerProvider.notifier)
                      .seek(Duration(seconds: val.toInt()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(audioState.position),
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    _formatDuration(audioState.duration),
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            // Mini player content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  // Surah icon / thumbnail
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      audioState.isPlayingFromLocal
                          ? Icons.download_done_rounded
                          : Icons.music_note_rounded,
                      color: AppColors.primaryTeal,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Surah info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          surahNumber != null
                              ? quran.getSurahNameEnglish(surahNumber)
                              : 'Quran Recitation',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          audioState.currentReciter.name,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Controls
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded),
                        onPressed: () {
                          ref
                              .read(quranAudioControllerProvider.notifier)
                              .skipPrevious();
                        },
                        color: isDark ? Colors.white : Colors.black87,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 28,
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: 28,
                                ),
                                onPressed: () {
                                  ref
                                      .read(quranAudioControllerProvider.notifier)
                                      .togglePlayPause();
                                },
                                color: AppColors.primaryTeal,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded),
                        onPressed: () {
                          ref
                              .read(quranAudioControllerProvider.notifier)
                              .skipNext();
                        },
                        color: isDark ? Colors.white : Colors.black87,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Safe area padding for bottom navigation
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: const SizedBox(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}