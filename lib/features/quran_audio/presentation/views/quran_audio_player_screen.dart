import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/app_colors.dart';
import '../../domain/entities/audio_playback_state.dart';
import '../../domain/entities/reciter.dart';
import '../controllers/quran_audio_controller.dart';

/// Full-screen audio player with playback controls
class QuranAudioPlayerScreen extends ConsumerWidget {
  const QuranAudioPlayerScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatDownloadProgress(double progress) {
    return "${(progress * 100).toStringAsFixed(1)}%";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          audioState.currentSurahNumber != null
              ? quran.getSurahNameEnglish(audioState.currentSurahNumber!)
              : 'Quran Audio',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Source indicator
              if (audioState.currentSurahNumber != null)
                Tooltip(
                  message: audioState.isPlayingFromLocal
                      ? "Playing from device storage"
                      : "Streaming from internet",
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      audioState.isPlayingFromLocal
                          ? Icons.download_done_rounded
                          : Icons.cloud_outlined,
                      color: audioState.isPlayingFromLocal
                          ? AppColors.primaryTeal
                          : (isDark ? Colors.white60 : Colors.black54),
                      size: 22,
                    ),
                  ),
                ),
              // Background play toggle
              IconButton(
                icon: Icon(
                  audioState.keepPlayingInBackground
                      ? Icons.phonelink_ring_rounded
                      : Icons.phonelink_erase_rounded,
                  color: audioState.keepPlayingInBackground
                      ? AppColors.primaryTeal
                      : (isDark ? Colors.white60 : Colors.black54),
                ),
                tooltip: audioState.keepPlayingInBackground
                    ? "Background play enabled"
                    : "Background play disabled",
                onPressed: () {
                  ref
                      .read(quranAudioControllerProvider.notifier)
                      .toggleBackgroundPlay();
                },
              ),
              // More options menu
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'reciter':
                      _showReciterBottomSheet(context, ref);
                      break;
                    case 'downloads':
                      _showDownloadsInfo(context, ref);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'reciter',
                    child: ListTile(
                      leading: Icon(Icons.person_rounded),
                      title: Text('Select Reciter'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  if (audioState.currentSurahNumber != null)
                    const PopupMenuItem(
                      value: 'downloads',
                      child: ListTile(
                        leading: Icon(Icons.download_rounded),
                        title: Text('Download Info'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: _buildPlayerBody(audioState, ref, isDark, context),
    );
  }

  Widget _buildPlayerBody(QuranAudioState state, WidgetRef ref, bool isDark, BuildContext context) {
    if (state.currentSurahNumber == null && state.currentVerseNumber == null) {
      return _buildNoAudioPlaying(isDark, ref, context);
    }

    final surahNumber = state.currentSurahNumber;
    final isDownloaded = surahNumber != null && state.isSurahDownloaded(surahNumber);
    final downloadStatus = surahNumber != null ? state.getDownloadStatus(surahNumber) : null;
    final isDownloading = downloadStatus?.isDownloading ?? false;
    final downloadProgress = downloadStatus?.progress ?? 0.0;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && !state.keepPlayingInBackground) {
          ref.read(quranAudioControllerProvider.notifier).stop();
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),

                      // Artwork / Disc with download status
                      _buildArtworkDisc(state, isDownloading, downloadProgress, isDownloaded, isDark, context),
                      const SizedBox(height: 32),

                      // Surah Info
                      if (surahNumber != null) ...[
                        Text(
                          quran.getSurahNameArabic(surahNumber),
                          style: GoogleFonts.amiri(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTeal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          quran.getSurahNameEnglish(surahNumber),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Reciter Info
                      Text(
                        state.currentReciter.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // Error message
                      if (state.errorMessage != null) ...[
                        const SizedBox(height: 12),
                        _buildErrorMessage(state, ref, isDark),
                      ],

                      const Spacer(),
                      const SizedBox(height: 24),

                      // Seek Bar
                      _buildSeekBar(state, ref, isDark, context),
                      const SizedBox(height: 24),

                      // Controls
                      _buildPlaybackControls(state, ref, isDark, context),

                      // Download button
                      if (surahNumber != null && !isDownloaded && !isDownloading)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ref
                                  .read(quranAudioControllerProvider.notifier)
                                  .downloadSurah(surahNumber);
                            },
                            icon: const Icon(Icons.download_rounded),
                            label: const Text("Download for Offline"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryTeal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),

                      // Cancel download button
                      if (isDownloading && surahNumber != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextButton.icon(
                            onPressed: () {
                              ref
                                  .read(quranAudioControllerProvider.notifier)
                                  .cancelDownload(surahNumber);
                            },
                            icon: const Icon(Icons.cancel_rounded, size: 16),
                            label: const Text("Cancel Download"),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoAudioPlaying(bool isDark, WidgetRef ref, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_note_rounded,
            size: 64,
            color: AppColors.primaryTeal.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No audio playing",
            style: TextStyle(
              color: isDark ? Colors.white60 : Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text("Browse Surahs"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkDisc(
    QuranAudioState state,
    bool isDownloading,
    double downloadProgress,
    bool isDownloaded,
    bool isDark,
    BuildContext context,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.width * 0.65,
          constraints: const BoxConstraints(
            maxHeight: 280,
            maxWidth: 280,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryTeal.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: state.isPlayingFromLocal
                  ? AppColors.primaryTeal.withValues(alpha: 0.5)
                  : AppColors.primaryTeal.withValues(alpha: 0.2),
              width: 8,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryTeal.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              state.isPlayingFromLocal
                  ? Icons.download_done_rounded
                  : Icons.music_note_rounded,
              size: MediaQuery.of(context).size.width * 0.2,
              color: AppColors.primaryTeal.withValues(alpha: 0.5),
            ),
          ),
        ),
        // Download progress indicator
        if (isDownloading)
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.65,
            constraints: const BoxConstraints(
              maxHeight: 280,
              maxWidth: 280,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: downloadProgress,
                  strokeWidth: 4,
                  backgroundColor: AppColors.primaryTeal.withValues(alpha: 0.2),
                  color: AppColors.primaryTeal,
                ),
                Text(
                  _formatDownloadProgress(downloadProgress),
                  style: const TextStyle(
                    color: AppColors.primaryTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        // Downloaded badge
        if (isDownloaded && !isDownloading)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryTeal.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Downloaded',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorMessage(QuranAudioState state, WidgetRef ref, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: () => ref.read(quranAudioControllerProvider.notifier).clearError(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeekBar(QuranAudioState state, WidgetRef ref, bool isDark, BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            activeTrackColor: AppColors.primaryTeal,
            inactiveTrackColor: AppColors.primaryTeal.withValues(alpha: 0.1),
            thumbColor: AppColors.primaryTeal,
          ),
          child: Slider(
            value: state.position.inSeconds.toDouble(),
            max: state.duration.inSeconds.toDouble().clamp(1.0, double.infinity),
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
                _formatDuration(state.position),
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                ),
              ),
              Text(
                _formatDuration(state.duration),
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaybackControls(QuranAudioState state, WidgetRef ref, bool isDark, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Loop button
        IconButton(
          icon: Icon(
            state.loopMode == AudioLoopMode.one
                ? Icons.repeat_one_rounded
                : (state.loopMode == AudioLoopMode.all
                    ? Icons.repeat_rounded
                    : Icons.repeat_rounded),
            color: state.loopMode != AudioLoopMode.off
                ? AppColors.primaryTeal
                : (isDark ? Colors.white54 : Colors.black54),
          ),
          onPressed: () {
            ref.read(quranAudioControllerProvider.notifier).toggleLoopMode();
          },
        ),
        // Previous button
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded, size: 48),
          onPressed: () {
            ref.read(quranAudioControllerProvider.notifier).skipPrevious();
          },
          color: isDark ? Colors.white : Colors.black87,
        ),
        // Play/Pause button
        GestureDetector(
          onTap: () {
            ref.read(quranAudioControllerProvider.notifier).togglePlayPause();
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: AppColors.primaryTeal,
              shape: BoxShape.circle,
            ),
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Icon(
                    state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 45,
                    color: Colors.white,
                  ),
          ),
        ),
        // Next button
        IconButton(
          icon: const Icon(Icons.skip_next_rounded, size: 48),
          onPressed: () {
            ref.read(quranAudioControllerProvider.notifier).skipNext();
          },
          color: isDark ? Colors.white : Colors.black87,
        ),
        // Sleep timer button
        IconButton(
          icon: Icon(
            Icons.timer_outlined,
            color: state.sleepTimerMinutes != null
                ? AppColors.primaryTeal
                : (isDark ? Colors.white54 : Colors.black54),
          ),
          onPressed: () {
            _showSleepTimerOptions(context, ref);
          },
        ),
      ],
    );
  }

  void _showSleepTimerOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Sleep Timer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text("15 minutes"),
                onTap: () {
                  ref.read(quranAudioControllerProvider.notifier).setSleepTimer(15);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text("30 minutes"),
                onTap: () {
                  ref.read(quranAudioControllerProvider.notifier).setSleepTimer(30);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text("60 minutes"),
                onTap: () {
                  ref.read(quranAudioControllerProvider.notifier).setSleepTimer(60);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.timer_off_rounded),
                title: const Text("Cancel Sleep Timer"),
                onTap: () {
                  ref.read(quranAudioControllerProvider.notifier).cancelSleepTimer();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReciterBottomSheet(BuildContext context, WidgetRef ref) {
    final allReciters = Reciters.all;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Select Reciter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ...allReciters.map((reciter) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      reciter.name[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  title: Text(reciter.name),
                  subtitle: Text(reciter.arabicName),
                  onTap: () {
                    ref.read(quranAudioControllerProvider.notifier).setReciter(reciter);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showDownloadsInfo(BuildContext context, WidgetRef ref) {
    final state = ref.read(quranAudioControllerProvider);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Download Info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Surah: ${state.currentSurahNumber != null ? quran.getSurahNameEnglish(state.currentSurahNumber!) : "None"}"),
              const SizedBox(height: 8),
              Text("Downloaded: ${state.isSurahDownloaded(state.currentSurahNumber ?? 0) ? "Yes" : "No"}"),
              const SizedBox(height: 8),
              if (state.currentSurahNumber != null) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    if (state.isSurahDownloaded(state.currentSurahNumber!)) {
                      ref.read(quranAudioControllerProvider.notifier).deleteDownloadedSurah(state.currentSurahNumber!);
                    } else {
                      ref.read(quranAudioControllerProvider.notifier).downloadSurah(state.currentSurahNumber!);
                    }
                    Navigator.pop(context);
                  },
                  icon: Icon(state.isSurahDownloaded(state.currentSurahNumber!) ? Icons.delete_rounded : Icons.download_rounded),
                  label: Text(state.isSurahDownloaded(state.currentSurahNumber!) ? "Delete Download" : "Download"),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}