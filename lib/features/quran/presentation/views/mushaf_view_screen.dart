import 'package:mubin/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/services/settings_controller.dart';
import '../controllers/bookmark_controller.dart';
import '../controllers/mushaf_controller.dart';
import '../controllers/surah_juz_controller.dart';
import '../controllers/quran_audio_player_controller.dart';
import '../controllers/quran_progress_controller.dart';
import '../widgets/verse_bottom_sheet.dart';

class MushafViewScreen extends ConsumerStatefulWidget {
  final int initialPage;
  final bool shouldUpdateProgress;
  final int? highlightVerseId;

  const MushafViewScreen({
    super.key,
    required this.initialPage,
    this.shouldUpdateProgress = true,
    this.highlightVerseId,
  });

  @override
  ConsumerState<MushafViewScreen> createState() => _MushafViewScreenState();
}

class _MushafViewScreenState extends ConsumerState<MushafViewScreen> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage - 1);

    // Initial load
    _initScreen();
  }

  Future<void> _initScreen() async {
    // Start data load
    _loadPages(_currentPage);

    // Progress update
    if (widget.shouldUpdateProgress) {
      ref
          .read(quranProgressControllerProvider.notifier)
          .updateProgress(_currentPage);
    }
  }

  void _loadPages(int page) {
    ref.read(mushafControllerProvider.notifier).loadVersesForPage(page);
    // Prefetch next page
    if (page < 604) {
      ref
          .read(mushafControllerProvider.notifier)
          .loadVersesForPage(page + 1, silent: true);
    }
  }

  @override
  void dispose() {
    // Sirf PageController dispose karein, ref yahan use na karein
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to settings for language changes
    ref.listen<SettingsState>(settingsControllerProvider, (previous, next) {
      if (previous?.language != next.language) {
        // Refresh current page with new language
        _loadPages(_currentPage);
      }
    });

    final mushafState = ref.watch(mushafControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final bookmarksState = ref.watch(bookmarkControllerProvider);
    final selectedVerseId = ref
        .watch(surahJuzControllerProvider)
        .selectedVerseId;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bookmarkedIds = bookmarksState.maybeWhen(
      data: (list) => list.map((b) => b.id).toSet(),
      orElse: () => <int>{},
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.transparent : AppColors.primaryTeal,
        centerTitle: true,
        elevation: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${_getSurahName(_currentPage)}  |  الجزء ${_getJuz(_currentPage)}",
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 16,
                color: isDark ? AppColors.primaryTeal : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.primaryTeal : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 604,
        reverse: true,
        onPageChanged: (idx) {
          final newPage = idx + 1;
          setState(() => _currentPage = newPage);

          // Verses load karein
          _loadPages(newPage);

          // Reading progress save karein (agar enabled ho)
          if (widget.shouldUpdateProgress) {
            ref
                .read(quranProgressControllerProvider.notifier)
                .updateProgress(newPage);
          }
        },
        itemBuilder: (context, index) {
          final pageNumber = index + 1;
          final pageState = mushafState[pageNumber];

          // Failsafe: Agar state null hai toh load trigger karein
          if (pageState == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                ref
                    .read(mushafControllerProvider.notifier)
                    .loadVersesForPage(pageNumber);
              }
            });
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryTeal),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: pageState.when(
              data: (verses) {
                final List<InlineSpan> spans = [];
                final isJuzStart = _isJuzStartPage(pageNumber);

                for (int i = 0; i < verses.length; i++) {
                  final verse = verses[i];
                  final isSelected = selectedVerseId == verse.id;
                  final isPlaying =
                      audioState.playingVerseId == verse.id &&
                      audioState.isPlaying;

                  // 1. Surah Header Logic
                  if (verse.verseNumber == 1) {
                    spans.add(
                      WidgetSpan(
                        child: _buildSurahHeader(verse.surahNumber, isDark),
                      ),
                    );
                  }

                  // 2. Verse Text Span
                  final isBookmarked = bookmarkedIds.contains(verse.id);
                  final isTargetHighlight = widget.highlightVerseId == verse.id;

                  spans.add(
                    TextSpan(
                      text: verse.textArabic,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 20,
                        height: 2.3,
                        color: isPlaying
                            ? AppColors.primaryTeal
                            : (isSelected
                                  ? AppColors.accentGold
                                  : (isDark ? Colors.white : Colors.black87)),
                        backgroundColor: isSelected
                            ? AppColors.accentGold.withAlpha(26)
                            : (isTargetHighlight
                                  ? AppColors.accentGold.withAlpha(77)
                                  : (isBookmarked
                                        ? AppColors.accentGold.withAlpha(38)
                                        : (isJuzStart && i == 0
                                              ? AppColors.primaryTeal.withAlpha(
                                                  38,
                                                )
                                              : null))),
                        fontWeight: (isJuzStart && i == 0 || isTargetHighlight)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ref
                              .read(surahJuzControllerProvider.notifier)
                              .selectVerse(verse.id);

                          // Audio play removed from here, user will play from bottom sheet
                          // ref.read(quranAudioPlayerControllerProvider.notifier).playVerseAudio(verse.audioUrl, verse.id);

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                VerseBottomSheet(verse: verse),
                          ).whenComplete(() {
                            // Stop audio when bottom sheet is closed
                            ref
                                .read(
                                  quranAudioPlayerControllerProvider.notifier,
                                )
                                .stopAudio();
                            ref
                                .read(surahJuzControllerProvider.notifier)
                                .selectVerse(-1);
                          });
                        },
                    ),
                  );
                }

                return Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomPaint(
                        painter: QuranLinesPainter(
                          lineHeight: 20 * 2.3, // Match text height
                          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                        ),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          text: TextSpan(children: spans),
                        ),
                      ),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryTeal),
              ),
              error: (err, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $err', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(mushafControllerProvider.notifier)
                          .loadVersesForPage(pageNumber),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Helper Methods ---
  bool _isJuzStartPage(int page) {
    const juzPages = [
      1,
      22,
      42,
      62,
      82,
      102,
      122,
      142,
      162,
      182,
      202,
      222,
      242,
      262,
      282,
      302,
      322,
      342,
      362,
      382,
      402,
      422,
      442,
      462,
      482,
      502,
      522,
      542,
      562,
      582,
    ];
    return juzPages.contains(page);
  }

  Widget _buildSurahHeader(int surahNumber, bool isDark) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryTeal.withValues(alpha: 0.2)),
        image: const DecorationImage(
          image: AssetImage('assets/app_logos/mubin.png'),
          opacity: 0.05,
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        children: [
          Text(
            quran.getSurahNameArabic(surahNumber),
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTeal,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quran.getPlaceOfRevelation(surahNumber),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const Text("  •  "),
              Text(
                "${quran.getVerseCount(surahNumber)} Verses",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  String _getSurahName(int page) {
    try {
      final data = quran.getPageData(page);
      if (data.isEmpty) return "القرآن الكريم";

      // Check if a new surah starts on this page, preferred for title
      for (var v in data) {
        if (v["verse"] == 1) {
          return quran.getSurahNameArabic(v["surah"]!);
        }
      }

      // Default to first surah on page
      return quran.getSurahNameArabic(data.first["surah"] ?? 1);
    } catch (_) {
      return "القرآن الكريم";
    }
  }

  int _getJuz(int page) {
    // Standard Madani Mushaf Juz start pages (604 pages edition)
    // This ensures Juz updates exactly at the correct page boundaries
    // independently of the Surah names.
    const juzStartPages = [
      1,
      22,
      42,
      62,
      82,
      102,
      122,
      142,
      162,
      182,
      202,
      222,
      242,
      262,
      282,
      302,
      322,
      342,
      362,
      382,
      402,
      422,
      442,
      462,
      482,
      502,
      522,
      542,
      562,
      582,
    ];

    for (int i = juzStartPages.length - 1; i >= 0; i--) {
      if (page >= juzStartPages[i]) {
        return i + 1;
      }
    }
    return 1;
  }
}

class QuranLinesPainter extends CustomPainter {
  final double lineHeight;
  final Color color;

  QuranLinesPainter({required this.lineHeight, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    // Draw horizontal lines across the page
    for (double y = lineHeight; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    
    // Draw the last line at the bottom if needed
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
