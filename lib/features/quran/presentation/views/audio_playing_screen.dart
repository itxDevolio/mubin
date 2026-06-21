import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/features/quran/domain/entities/reciter.dart';
import 'package:auraq/features/quran/presentation/controllers/quran_audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;

class AudioPlayingScreen extends ConsumerWidget {
  const AudioPlayingScreen({super.key});

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
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (audioState.currentSurahNumber == null &&
        audioState.playingVerseId == null) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note_rounded,
                size: 64,
                color: AppColors.primaryTeal.withAlpha(128),
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
        ),
      );
    }

    final String surahName = audioState.currentSurahNumber != null
        ? quran.getSurahNameEnglish(audioState.currentSurahNumber!)
        : "Verse Audio";

    final String surahArabic = audioState.currentSurahNumber != null
        ? quran.getSurahNameArabic(audioState.currentSurahNumber!)
        : "";

    final int? surahNumber = audioState.currentSurahNumber;
    final bool isDownloaded = surahNumber != null && audioState.isSurahDownloaded(surahNumber);
    final DownloadStatus downloadStatus = surahNumber != null 
        ? audioState.getDownloadStatus(surahNumber) 
        : DownloadStatus.notDownloaded;
    final double downloadProgress = surahNumber != null 
        ? audioState.getDownloadProgress(surahNumber) 
        : 0.0;

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
          surahName,
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
          // Source indicator (local/online)
          if (audioState.currentAudioUrl != null)
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
              hapticFeedBack();
              ref
                  .read(quranAudioPlayerControllerProvider.notifier)
                  .toggleBackgroundPlay();
            },
          ),
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
              if (surahNumber != null)
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
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop && !audioState.keepPlayingInBackground) {
            ref.read(quranAudioPlayerControllerProvider.notifier).stopAudio();
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.65,
                              height: constraints.maxWidth * 0.65,
                              constraints: const BoxConstraints(
                                maxHeight: 280,
                                maxWidth: 280,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryTeal.withAlpha(26),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: audioState.isPlayingFromLocal
                                      ? AppColors.primaryTeal.withAlpha(128)
                                      : AppColors.primaryTeal.withAlpha(51),
                                  width: 8,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryTeal.withAlpha(51),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  audioState.isPlayingFromLocal
                                      ? Icons.download_done_rounded
                                      : Icons.music_note_rounded,
                                  size: constraints.maxWidth * 0.2,
                                  color: AppColors.primaryTeal.withAlpha(128),
                                ),
                              ),
                            ),
                            // Download progress indicator
                            if (downloadStatus == DownloadStatus.downloading)
                              Container(
                                width: constraints.maxWidth * 0.65,
                                height: constraints.maxWidth * 0.65,
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
                                      backgroundColor: AppColors.primaryTeal.withAlpha(51),
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
                            if (isDownloaded && downloadStatus != DownloadStatus.downloading)
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
                                        color: AppColors.primaryTeal.withAlpha(77),
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
                        ),
                        const SizedBox(height: 32),

                        // Surah Info
                        Text(
                          surahArabic,
                          style: GoogleFonts.amiri(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTeal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          surahName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          audioState.currentReciter.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white60 : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (audioState.errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(26),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.red.withAlpha(77),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    audioState.errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  onPressed: () {
                                    ref.read(quranAudioPlayerControllerProvider.notifier).clearError();
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const Spacer(),
                        const SizedBox(height: 24),

                        // Seek Bar
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 20,
                            ),
                            activeTrackColor: AppColors.primaryTeal,
                            inactiveTrackColor: AppColors.primaryTeal
                                .withAlpha(26),
                            thumbColor: AppColors.primaryTeal,
                          ),
                          child: Slider(
                            value: audioState.position.inSeconds.toDouble(),
                            max: audioState.duration.inSeconds.toDouble().clamp(
                              1.0,
                              double.infinity,
                            ),
                            onChanged: (val) {
                              ref
                                  .read(
                                    quranAudioPlayerControllerProvider.notifier,
                                  )
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
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                _formatDuration(audioState.duration),
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                audioState.loopMode == LoopMode.one
                                    ? Icons.repeat_one_rounded
                                    : (audioState.loopMode == LoopMode.all
                                          ? Icons.repeat_rounded
                                          : Icons.repeat_rounded),
                                color: audioState.loopMode != LoopMode.off
                                    ? AppColors.primaryTeal
                                    : (isDark
                                          ? Colors.white54
                                          : Colors.black54),
                              ),
                              onPressed: () {
                                hapticFeedBack();
                                ref
                                    .read(
                                      quranAudioPlayerControllerProvider.notifier,
                                    )
                                    .toggleLoop();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 48,
                              ),
                              onPressed: () {
                                hapticFeedBack();
                                ref
                                    .read(
                                      quranAudioPlayerControllerProvider.notifier,
                                    )
                                    .skipPrevious();
                              },
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            GestureDetector(
                              onTap: () {
                                hapticFeedBack();
                                if (audioState.isPlaying) {
                                  ref
                                      .read(
                                        quranAudioPlayerControllerProvider
                                            .notifier,
                                      )
                                      .pauseAudio();
                                } else {
                                  ref
                                      .read(
                                        quranAudioPlayerControllerProvider
                                            .notifier,
                                      )
                                      .resumeAudio();
                                }
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryTeal,
                                  shape: BoxShape.circle,
                                ),
                                child: audioState.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        audioState.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 45,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 48,
                              ),
                              onPressed: () {
                                hapticFeedBack();
                                ref
                                    .read(
                                      quranAudioPlayerControllerProvider.notifier,
                                    )
                                    .skipNext();
                              },
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.timer_outlined,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                              onPressed: () =>
                                  _showTimerBottomSheet(context, ref),
                            ),
                          ],
                        ),
                        
                        // Download button (if surah is not downloaded)
                        if (surahNumber != null && !isDownloaded && downloadStatus != DownloadStatus.downloading)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                hapticFeedBack();
                                ref
                                    .read(quranAudioPlayerControllerProvider.notifier)
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
                        if (downloadStatus == DownloadStatus.downloading && surahNumber != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextButton.icon(
                              onPressed: () {
                                hapticFeedBack();
                                ref
                                    .read(quranAudioPlayerControllerProvider.notifier)
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
      ),
     );
  }

  void _showTimerBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return _SleepTimerSheet(
          onSetTimer: (minutes) {
            ref
                .read(quranAudioPlayerControllerProvider.notifier)
                .setSleepTimer(minutes);
            Navigator.pop(context);
            if (minutes > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Timer set for $minutes minutes"),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showReciterBottomSheet(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
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
                "Select Reciter",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${availableReciters.length} reciters available",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableReciters.length,
                  itemBuilder: (context, index) {
                    final reciter = availableReciters[index];
                    final isSelected = audioState.currentReciter == reciter;
                    return InkWell(
                      onTap: () {
                        hapticFeedBack();
                        ref
                            .read(quranAudioPlayerControllerProvider.notifier)
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
                                  if (reciter.arabicName != null)
                                    Text(
                                      reciter.arabicName!,
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
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDownloadsInfo(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surahNumber = audioState.currentSurahNumber;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          title: Row(
            children: [
              Icon(
                surahNumber != null && audioState.isSurahDownloaded(surahNumber)
                    ? Icons.download_done_rounded
                    : Icons.download_for_offline_outlined,
                color: AppColors.primaryTeal,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  surahNumber != null && audioState.isSurahDownloaded(surahNumber)
                      ? "Downloaded"
                      : "Not Downloaded",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                context,
                "Surah",
                surahNumber != null ? "Surah $surahNumber" : "N/A",
                isDark,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                "Reciter",
                audioState.currentReciter.name,
                isDark,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                "Status",
                audioState.isPlayingFromLocal ? "Playing from device" : "Streaming online",
                isDark,
              ),
              if (surahNumber != null && audioState.isSurahDownloaded(surahNumber)) ...[
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref
                        .read(quranAudioPlayerControllerProvider.notifier)
                        .deleteDownloadedSurah(surahNumber);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Downloaded surah deleted")),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete Download"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white60 : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SleepTimerSheet extends StatefulWidget {
  final Function(int) onSetTimer;

  const _SleepTimerSheet({required this.onSetTimer});

  @override
  State<_SleepTimerSheet> createState() => _SleepTimerSheetState();
}

class _SleepTimerSheetState extends State<_SleepTimerSheet> {
  late TextEditingController _minutesController;

  @override
  void initState() {
    super.initState();
    _minutesController = TextEditingController();
  }

  @override
  void dispose() {
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Set Sleep Timer",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _minutesController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Minutes",
              hintText: "Enter minutes (e.g. 30)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: const Icon(Icons.timer),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildTimerShortcut(15),
              _buildTimerShortcut(30),
              _buildTimerShortcut(45),
              _buildTimerShortcut(60),
              _buildTimerShortcut(90),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    widget.onSetTimer(0);
                    Navigator.pop(context);
                  },
                  child: const Text("Turn Off"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final minutes = int.tryParse(_minutesController.text) ?? 0;
                    if (minutes > 0) {
                      widget.onSetTimer(minutes);
                    } else if (_minutesController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter minutes")),
                      );
                    }
                  },
                  child: const Text("Set Timer"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerShortcut(int minutes) {
    return ActionChip(
      label: Text("$minutes min"),
      onPressed: () => _minutesController.text = minutes.toString(),
      backgroundColor: AppColors.primaryTeal.withAlpha(26),
      labelStyle: const TextStyle(color: AppColors.primaryTeal),
    );
  }
}