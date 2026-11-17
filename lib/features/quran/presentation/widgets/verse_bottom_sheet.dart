import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/core/services/tafseer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../domain/entities/verse.dart';
import 'package:mubin/features/quran/presentation/controllers/bookmark_controller.dart';
import 'package:mubin/features/quran/presentation/controllers/quran_audio_player_controller.dart';

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

    final tafseerAsync = settings.enableTafseer
        ? ref.watch(
            verseTafseerProvider((
              surahNumber: verse.surahNumber,
              verseNumber: verse.verseNumber,
              language: settings.language,
            )),
          )
        : null;

    return DraggableScrollableSheet(
      initialChildSize: settings.enableTafseer ? 0.6 : 0.45,
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
                          isUrdu
                              ? 'سورہ ${quran.getSurahNameArabic(verse.surahNumber)}'
                              : 'Surah ${quran.getSurahName(verse.surahNumber)}',
                          style: TextStyle(
                            fontFamily: isUrdu ? 'Amiri' : 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: isUrdu ? 20 : 18,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                        ),
                        Text(
                          isUrdu
                              ? 'آیت ${verse.verseNumber}'
                              : 'Verse ${verse.verseNumber}',
                          style: TextStyle(
                            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
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
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 20,
                  height: 1.8,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                isUrdu ? 'ترجمہ:' : 'Translation:',
                style: TextStyle(
                  fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                verse.translation,
                textDirection: isUrdu
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: isUrdu
                    ? TextStyle(
                        fontFamily: 'NotoNastaliqUrdu',
                        fontSize: 14,
                        height: 2.2,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      )
                    : TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
              ),
              const SizedBox(height: 24),
              if (settings.enableTafseer && tafseerAsync != null) ...[
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  isUrdu ? 'تفسیر (تذکیر القرآن):' : 'Tafseer (Tazkirul Quran):',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTeal,
                  ),
                ),
                const SizedBox(height: 8),
                tafseerAsync.when(
                  data: (tafseerText) {
                    if (tafseerText == null || tafseerText.isEmpty) {
                      return Text(
                        isUrdu
                            ? 'اس آیت کے لیے تفسیر دستیاب نہیں ہے۔'
                            : 'No Tafseer available for this verse.',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }
                    return Text(
                      tafseerText,
                      textDirection: isUrdu
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: isUrdu
                          ? TextStyle(
                              fontFamily: 'NotoNastaliqUrdu',
                              fontSize: 13,
                              height: 2.2,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            )
                          : TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              height: 1.6,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
                  error: (err, stack) => Text(
                    isUrdu
                        ? 'تفسیر لوڈ کرنے میں مسئلہ پیش آیا۔'
                        : 'Error loading Tafseer.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
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
    final settings = ref.read(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          isUrdu ? 'بک مارک محفوظ کریں' : 'Save Bookmark',
          style: TextStyle(
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
          style: TextStyle(
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
          ),
          decoration: InputDecoration(
            hintText: isUrdu ? 'عنوان درج کریں' : 'Enter title',
            hintStyle: TextStyle(
              fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
            ),
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
            child: Text(
              isUrdu ? 'منسوخ کریں' : 'Cancel',
              style: TextStyle(
                fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final namedVerse = verse.copyWith(
                bookmarkName: controller.text.trim().isEmpty
                    ? null
                    : controller.text.trim(),
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
            child: Text(
              isUrdu ? 'محفوظ کریں' : 'Save',
              style: TextStyle(
                fontFamily: isUrdu ? 'NotoNastaliqUrdu' : 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
