import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/widgets/ad_banner_widget.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/core/services/tafseer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../domain/entities/verse.dart';
import 'package:mubin/features/quran/presentation/controllers/bookmark_controller.dart';
import 'package:mubin/features/quran/presentation/controllers/quran_audio_player_controller.dart';

class VerseBottomSheet extends ConsumerStatefulWidget {
  final Verse verse;

  const VerseBottomSheet({super.key, required this.verse});

  @override
  ConsumerState<VerseBottomSheet> createState() => _VerseBottomSheetState();
}

class _VerseBottomSheetState extends ConsumerState<VerseBottomSheet> {
  @override
  void dispose() {
    ref.read(quranAudioPlayerControllerProvider.notifier).stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verse = widget.verse;
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;

    final isBookmarked = bookmarksState.maybeWhen(
      data: (list) => list.any((b) => b.id == verse.id),
      orElse: () => false,
    );

    final isPlayingThis =
        audioState.isPlaying && (audioState.currentAudioUrl == verse.audioUrl || audioState.playingVerseId == verse.id);
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  fontFamily: 'IndoPakFont',
                  fontSize: 22,
                  height: 1.8,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              // Translation Header & Text
              Align(
                alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  isUrdu ? 'ترجمہ' : (isPashto ? 'ترجمہ' : 'Translation:'),
                  style: TextStyle(
                    fontFamily: isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins'),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.primaryTeal,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                verse.translation,
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                style: isRtl
                    ? TextStyle(
                        fontFamily: isPashto ? 'Amiri' : 'NotoNastaliqUrdu',
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
              if (verse.verseNumber % 3 == 0) ...[
                const Center(child: AdBannerWidget()),
                const SizedBox(height: 24),
              ],
              if (settings.enableTafseer && tafseerAsync != null) ...[
                const Divider(),
                const SizedBox(height: 12),
                Align(
                  alignment: isRtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    isUrdu || isPashto ? 'تفسیر:' : 'Tafseer:',
                    style: TextStyle(
                      fontFamily: isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins'),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                tafseerAsync.when(
                  data: (tafseerText) {
                    if (tafseerText == null || tafseerText.isEmpty) {
                      return Text(
                        isUrdu
                            ? 'اس آیت کے لیے تفسیر دستیاب نہیں ہے۔'
                            : (isPashto
                                  ? 'د دې آیت لپاره تفسیر نشته.'
                                  : 'No Tafseer available for this verse.'),
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }
                    return Text(
                      tafseerText,
                      textDirection: isRtl
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: isRtl
                          ? TextStyle(
                              fontFamily: isPashto ? 'Amiri' : 'NotoNastaliqUrdu',
                              fontSize: 13,
                              height: 2.2,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            )
                          : TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              height: 1.6,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
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
                        : (isPashto
                              ? 'تفسیر په پورته کولو کې ستونزه رامنځته شوه.'
                              : 'Error loading Tafseer.'),
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
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String textFont = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isUrdu
              ? 'بک مارک محفوظ کریں'
              : (isPashto ? 'نښه خوندي کړئ' : 'Save Bookmark'),
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontFamily: textFont,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        content: TextField(
          controller: controller,
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          cursorColor: AppColors.primaryTeal,
          style: TextStyle(
            fontFamily: textFont,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: isUrdu
                ? 'عنوان درج کریں'
                : (isPashto ? 'عنوان ولیکئ' : 'Enter title'),
            hintStyle: TextStyle(
              fontFamily: textFont,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontSize: 14,
            ),
            filled: true,
            fillColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.primaryTeal,
                width: 1.2,
              ),
            ),
          ),
          autofocus: true,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isUrdu
                  ? ' کینسل'
                  : (isPashto ? 'کینسل' : 'Cancel'),
              style: TextStyle(
                fontFamily: textFont,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontWeight: FontWeight.w500,
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
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              isUrdu
                  ? 'محفوظ کریں'
                  : (isPashto ? 'خوندي کړئ' : 'Save'),
              style: TextStyle(
                fontFamily: textFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
