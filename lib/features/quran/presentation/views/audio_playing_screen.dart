import 'package:auraq/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import '../controllers/quran_audio_player_controller.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (audioState.currentSurahNumber == null &&
        audioState.playingVerseId == null) {
      return const Scaffold(body: Center(child: Text("No audio playing")));
    }

    final String surahName = audioState.currentSurahNumber != null
        ? quran.getSurahNameEnglish(audioState.currentSurahNumber!)
        : "Verse Audio";

    final String surahArabic = audioState.currentSurahNumber != null
        ? quran.getSurahNameArabic(audioState.currentSurahNumber!)
        : "";

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
        actions: [
          IconButton(
            icon: Icon(
              audioState.keepPlayingInBackground
                  ? Icons.phonelink_ring_rounded
                  : Icons.phonelink_erase_rounded,
              color: audioState.keepPlayingInBackground
                  ? AppColors.primaryTeal
                  : (isDark ? Colors.white60 : Colors.black54),
            ),
            tooltip: "Background Play",
            onPressed: () => ref
                .read(quranAudioPlayerControllerProvider.notifier)
                .toggleBackgroundPlay(),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () {},
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
                        // Artwork / Disc
                        Container(
                          width: constraints.maxWidth * 0.65,
                          height: constraints.maxWidth * 0.65,
                          constraints: const BoxConstraints(
                            maxHeight: 280,
                            maxWidth: 280,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryTeal.withOpacity(0.2),
                              width: 8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryTeal.withOpacity(0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.music_note_rounded,
                              size: constraints.maxWidth * 0.2,
                              color: AppColors.primaryTeal.withOpacity(0.5),
                            ),
                          ),
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
                          "Mishary Rashid Alafasy",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white60 : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                                .withOpacity(0.1),
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
                              onPressed: () => ref
                                  .read(
                                    quranAudioPlayerControllerProvider.notifier,
                                  )
                                  .toggleLoop(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 48,
                              ),
                              onPressed: () => ref
                                  .read(
                                    quranAudioPlayerControllerProvider.notifier,
                                  )
                                  .skipPrevious(),
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            GestureDetector(
                              onTap: () {
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
                              onPressed: () => ref
                                  .read(
                                    quranAudioPlayerControllerProvider.notifier,
                                  )
                                  .skipNext(),
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
          },
        );
      },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimerShortcut(15),
              _buildTimerShortcut(30),
              _buildTimerShortcut(45),
              _buildTimerShortcut(60),
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
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Timer set for $minutes minutes"),
                        ),
                      );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ActionChip(
        label: Text("$minutes m"),
        onPressed: () => _minutesController.text = minutes.toString(),
        backgroundColor: AppColors.primaryTeal.withOpacity(0.1),
        labelStyle: const TextStyle(color: AppColors.primaryTeal),
      ),
    );
  }
}
