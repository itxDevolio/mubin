import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import '../../domain/entities/verse.dart';
import '../controllers/bookmark_controller.dart';
import '../controllers/quran_audio_player_controller.dart';

class VerseBottomSheet extends ConsumerWidget {
  final Verse verse;
  const VerseBottomSheet({super.key, required this.verse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUrdu = settings.language == 'ur';

    final isBookmarked = bookmarksState.maybeWhen(
      data: (list) => list.any((b) => b.id == verse.id),
      orElse: () => false,
    );

    final isPlayingThis =
        audioState.isPlaying && audioState.currentAudioUrl == verse.audioUrl;
    final isLoadingThis =
        audioState.isLoading && audioState.playingVerseId == verse.id;

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Surah ${quran.getSurahName(verse.surahNumber)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).textTheme.titleLarge?.color,
                          ),
                        ),
                        Text(
                          'Verse ${verse.verseNumber}',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: AppColors.accentGold,
                          size: 28,
                        ),
                        onPressed: () {
                          if (isBookmarked) {
                            ref
                                .read(bookmarkControllerProvider.notifier)
                                .toggleBookmarkState(verse);
                          } else {
                            _showBookmarkNameDialog(context, ref, verse);
                          }
                        },
                      ),
                      // Audio Control with Loading State
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isLoadingThis)
                            const SizedBox(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                          IconButton(
                            icon: Icon(
                              isPlayingThis
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 36,
                              color: isLoadingThis
                                  ? AppColors.primaryTeal.withAlpha(100)
                                  : AppColors.primaryTeal,
                            ),
                            onPressed: isLoadingThis
                                ? null
                                : () {
                                    if (isPlayingThis) {
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
                                          .playVerseAudio(
                                            verse.audioUrl,
                                            verse.id,
                                          );
                                    }
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              // Arabic Text of the Verse
              Text(
                verse.textArabic,
                textAlign: TextAlign.center,
                style: GoogleFonts.amiriQuran(
                  fontSize: 24,
                  height: 1.8,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                 'Translation:',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                verse.translation,
                textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                style: isUrdu
                    ? GoogleFonts.notoNastaliqUrdu(
                        fontSize: 18,
                        height: 2.2,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      )
                    : TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showBookmarkNameDialog(
    BuildContext context,
    WidgetRef ref,
    Verse verse,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Save Bookmark'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter title',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryTeal),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final namedVerse = verse.copyWith(
                bookmarkName: controller.text.trim(),
              );
              ref
                  .read(bookmarkControllerProvider.notifier)
                  .toggleBookmarkState(namedVerse);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
