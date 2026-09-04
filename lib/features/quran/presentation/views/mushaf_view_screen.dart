import 'package:mubin/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/utils/quran_utils.dart';
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

    final currentLang = ref.watch(settingsControllerProvider).language;
    final bookmarkedIds = bookmarksState.maybeWhen(
      data: (list) => list.map((b) => b.id).toSet(),
      orElse: () => <int>{},
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 1. Mushaf Page View
          PageView.builder(
            controller: _pageController,
            itemCount: 604,
            reverse: true,
            onPageChanged: (idx) {
              final newPage = idx + 1;
              setState(() => _currentPage = newPage);
              _loadPages(newPage);
              if (widget.shouldUpdateProgress) {
                ref.read(quranProgressControllerProvider.notifier).updateProgress(newPage);
              }
            },
            itemBuilder: (context, index) {
              final pageNumber = index + 1;
              final pageState = mushafState[pageNumber];

              if (pageState == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    ref.read(mushafControllerProvider.notifier).loadVersesForPage(pageNumber);
                  }
                });
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryTeal),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 15), // Smaller space for top overlay
                child: pageState.when(
                  data: (verses) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final double availableHeight = constraints.maxHeight;
                        final double lineHeight = availableHeight / 16;
                        final double fontSize = lineHeight * 0.45;

                        final List<InlineSpan> spans = [];
                        final isJuzStart = _isJuzStartPage(pageNumber);

                        for (int i = 0; i < verses.length; i++) {
                          final verse = verses[i];
                          final isSelected = selectedVerseId == verse.id;
                          final isPlaying = audioState.playingVerseId == verse.id && audioState.isPlaying;

                          if (verse.verseNumber == 1) {
                            spans.add(
                              WidgetSpan(
                                child: _buildStyledHeader(verse.surahNumber, fontSize, isDark, lineHeight, currentLang),
                              ),
                            );
                            spans.add(const TextSpan(text: "\n"));
                          }

                          final isBookmarked = bookmarkedIds.contains(verse.id);
                          final isTargetHighlight = widget.highlightVerseId == verse.id;

                          spans.add(
                            TextSpan(
                              text: "${verse.textArabic} ",
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: fontSize,
                                height: lineHeight / fontSize,
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
                                                ? AppColors.primaryTeal.withAlpha(38)
                                                : null))),
                                fontWeight: (isJuzStart && i == 0 || isTargetHighlight)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ref.read(surahJuzControllerProvider.notifier).selectVerse(verse.id);
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => VerseBottomSheet(verse: verse),
                                  ).whenComplete(() {
                                    ref.read(quranAudioPlayerControllerProvider.notifier).stopAudio();
                                    ref.read(surahJuzControllerProvider.notifier).selectVerse(-1);
                                  });
                                },
                            ),
                          );
                        }

                        return Container(
                          height: availableHeight,
                          width: constraints.maxWidth,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: constraints.maxWidth,
                              child: CustomPaint(
                                painter: QuranLinesPainter(
                                  numberOfLines: 16,
                                  lineHeight: lineHeight,
                                  color: isDark 
                                      ? Colors.white.withValues(alpha: 0.1) 
                                      : Colors.black.withValues(alpha: 0.05),
                                  drawOnlyForContent: true,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(children: spans),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryTeal),
                  ),
                  error: (err, _) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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

          // 2. Custom Top Overlay (Replaces AppBar)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryTeal.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // 1. Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryTeal, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // 2. Juz Info
                    Expanded(
                      child: Text(
                        currentLang == 'ur' 
                          ? QuranUtils.juzNamesArabic[_getJuz(_currentPage) - 1]
                          : QuranUtils.juzNamesEnglish[_getJuz(_currentPage) - 1],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontFamily: currentLang == 'ur' ? 'Amiri' : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 3. Page Number (Poppins, size 13)
                    Text(
                      "$_currentPage",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    // 4. Surah Name
                    Expanded(
                      child: Text(
                        currentLang == 'ur'
                          ? quran.getSurahNameArabic(quran.getPageData(_currentPage).first['surah'])
                          : (_englishSurahNames[quran.getPageData(_currentPage).first['surah']] ?? "Surah"),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontFamily: currentLang == 'ur' ? 'Amiri' : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Small extra space to balance the back button
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
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


  Widget _buildStyledHeader(int surahNumber, double fontSize, bool isDark, double lineHeight, String lang) {
    return Container(
      width: double.infinity,
      height: lineHeight, // Maintain the 16-line grid consistency
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withValues(alpha: 0.05),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.primaryTeal.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Left: Verse Count
          Expanded(
            child: Text(
              "${quran.getVerseCount(surahNumber)}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primaryTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Center: Surah Name
          Expanded(
            flex: 2,
            child: Text(
              quran.getSurahNameArabic(surahNumber),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 20,
                color: AppColors.primaryTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Right: Revelation Place
          Expanded(
            child: Text(
              quran.getPlaceOfRevelation(surahNumber),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primaryTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getJuz(int page) {
    const juzStartPages = [1, 22, 42, 62, 82, 102, 122, 142, 162, 182, 202, 222, 242, 262, 282, 302, 322, 342, 362, 382, 402, 422, 442, 462, 482, 502, 522, 542, 562, 582];
    for (int i = juzStartPages.length - 1; i >= 0; i--) {
      if (page >= juzStartPages[i]) return i + 1;
    }
    return 1;
  }

  static const Map<int, String> _englishSurahNames = {
    1: "Al-Fatihah", 2: "Al-Baqarah", 3: "Ali 'Imran", 4: "An-Nisa'", 5: "Al-Ma'idah",
    6: "Al-An'am", 7: "Al-A'raf", 8: "Al-Anfal", 9: "At-Tawbah", 10: "Yunus",
    11: "Hud", 12: "Yusuf", 13: "Ar-Ra'd", 14: "Ibrahim", 15: "Al-Hijr",
    16: "An-Nahl", 17: "Al-Isra'", 18: "Al-Kahf", 19: "Maryam", 20: "Ta-Ha",
    21: "Al-Anbiya'", 22: "Al-Hajj", 23: "Al-Mu'minun", 24: "An-Nur", 25: "Al-Furqan",
    26: "Ash-Shu'ara'", 27: "An-Naml", 28: "Al-Qasas", 29: "Al-'Ankabut", 30: "Ar-Rum",
    31: "Luqman", 32: "As-Sajdah", 33: "Al-Ahzab", 34: "Saba'", 35: "Fatir",
    36: "Ya-Sin", 37: "As-Saffat", 38: "Sad", 39: "Az-Zumar", 40: "Ghafir",
    41: "Fussilat", 42: "Ash-Shura", 43: "Az-Zukhruf", 44: "Ad-Dukhan", 45: "Al-Jathiyah",
    46: "Al-Ahqaf", 47: "Muhammad", 48: "Al-Fath", 49: "Al-Hujurat", 50: "Qaf",
    51: "Adh-Dhariyat", 52: "At-Tur", 53: "An-Najm", 54: "Al-Qamar", 55: "Ar-Rahman",
    56: "Al-Waqi'ah", 57: "Al-Hadid", 58: "Al-Mujadilah", 59: "Al-Hashr", 60: "Al-Mumtahanah",
    61: "As-Saff", 62: "Al-Jumu'ah", 63: "Al-Munafiqun", 64: "At-Taghabun", 65: "At-Talaq",
    66: "At-Tahrim", 67: "Al-Mulk", 68: "Al-Qalam", 69: "Al-Haqqah", 70: "Al-Ma'arij",
    71: "Nuh", 72: "Al-Jinn", 73: "Al-Muzzammil", 74: "Al-Muddaththir", 75: "Al-Qiyamah",
    76: "Al-Insan", 77: "Al-Mursalat", 78: "An-Naba'", 79: "An-Nazi'at", 80: "'Abasa",
    81: "At-Takwir", 82: "Al-Infitar", 83: "Al-Mutaffifin", 84: "Al-Inshiqaq", 85: "Al-Buruj",
    86: "At-Tariq", 87: "Al-A'la", 88: "Al-Ghashiyah", 89: "Al-Fajr", 90: "Al-Balad",
    91: "Ash-Shams", 92: "Al-Layl", 93: "Ad-Duha", 94: "Ash-Sharh", 95: "At-Tin",
    96: "Al-'Alaq", 97: "Al-Qadr", 98: "Al-Bayyinah", 99: "Az-Zalzalah", 100: "Al-'Adiyat",
    101: "Al-Qari'ah", 102: "At-Takathur", 103: "Al-'Asr", 104: "Al-Humazah", 105: "Al-Fil",
    106: "Quraysh", 107: "Al-Ma'un", 108: "Al-Kawthar", 109: "Al-Kafirun", 110: "An-Nasr",
    111: "Al-Masad", 112: "Al-Ikhlas", 113: "Al-Falaq", 114: "An-Nas"
  };

  String _toArabicNumbers(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) => arabicDigits[int.parse(d)]).join();
  }
}

class QuranLinesPainter extends CustomPainter {
  final int numberOfLines;
  final double lineHeight;
  final Color color;
  final bool drawOnlyForContent;

  QuranLinesPainter({
    required this.numberOfLines,
    required this.lineHeight,
    required this.color,
    this.drawOnlyForContent = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.8;

    // If drawOnlyForContent is true, we only draw lines for the actual size of the widget
    // But we still want to maintain the grid feeling.
    // size.height will be the height of the RichText due to IntrinsicHeight.
    for (double y = lineHeight; y <= size.height + 2; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
