import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/services/settings_controller.dart';
import '../../../../core/utils/quran_utils.dart';
import '../controllers/quran_progress_controller.dart';
import '../../../../services/translation_service.dart';
import '../../../../services/quran_db_service.dart';
import '../../../../services/quran_metadata_service.dart';
import '../../domain/entities/verse.dart';
import '../widgets/verse_bottom_sheet.dart';
import '../controllers/quran_audio_player_controller.dart';

class MushafViewScreen extends ConsumerStatefulWidget {
  final int? initialPage;
  final int? surahNumber;
  final int? verseNumber;
  final bool shouldUpdateProgress;
  final int? highlightVerseId;
  final bool isBookmarkHighlight;

  const MushafViewScreen({
    super.key,
    this.initialPage,
    this.surahNumber,
    this.verseNumber,
    this.shouldUpdateProgress = true,
    this.highlightVerseId,
    this.isBookmarkHighlight = false,
  });

  @override
  ConsumerState<MushafViewScreen> createState() => _MushafViewScreenState();
}

class _MushafViewScreenState extends ConsumerState<MushafViewScreen> {
  late PageController _pageController;
  late int _currentPage;
  final int _totalPages = 548; // 16-line IndoPak Mushaf total pages
  int? _selectedSurah;
  int? _selectedAyah;
  bool _isLoadingPage = false;

  final Map<int, List<QuranLine>> _pageLinesCache = {};

  void _loadPage(int pageNumber) async {
    if (_pageLinesCache.containsKey(pageNumber)) return;
    final lines = await QuranDbService().getPageLines(pageNumber);
    if (mounted) {
      _pageLinesCache[pageNumber] = lines;
      if (pageNumber == _currentPage) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialPage != null) {
      _currentPage = widget.initialPage!.clamp(1, _totalPages);
      _pageController = PageController(initialPage: _currentPage - 1);
      _loadPage(_currentPage);
      _prefetchAdjacentPages(_currentPage);
      _initScreen();
    } else {
      _currentPage = 1;
      _pageController = PageController(initialPage: 0);
      _isLoadingPage = true;
      _resolveInitialPage();
    }
    _preloadAllPagesInBackground();
  }

  Future<void> _resolveInitialPage() async {
    int page = 1;
    if (widget.highlightVerseId != null) {
      int sNum = widget.highlightVerseId! ~/ 1000;
      int vNum = widget.highlightVerseId! % 1000;
      page = await QuranDbService().getPageForVerse(sNum, vNum);
    } else if (widget.surahNumber != null) {
      page =
      await QuranDbService().getStartingPageForSurah(widget.surahNumber!);
    }

    if (mounted) {
      setState(() {
        _currentPage = page.clamp(1, _totalPages);
        _pageController.jumpToPage(_currentPage - 1);
        _isLoadingPage = false;
      });
      _loadPage(_currentPage);
      _prefetchAdjacentPages(_currentPage);
      _initScreen();
    }
  }

  void _prefetchAdjacentPages(int pageNum) {
    for (int p = pageNum - 2; p <= pageNum + 2; p++) {
      if (p >= 1 && p <= _totalPages && !_pageLinesCache.containsKey(p)) {
        _loadPage(p);
      }
    }
  }

  Future<void> _preloadAllPagesInBackground() async {
    for (int p = 1; p <= _totalPages; p++) {
      if (!_pageLinesCache.containsKey(p)) {
        final lines = await QuranDbService().getPageLines(p);
        _pageLinesCache[p] = lines;
      }
    }
  }

  Future<void> _initScreen() async {
    if (widget.shouldUpdateProgress) {
      ref
          .read(quranProgressControllerProvider.notifier)
          .updateProgress(_currentPage);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdHelper.maybeShowSurahJuzAd(
        context,
        onContinue: () {},
        onSkip: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String fixLamAlif(String text) {
    if (text.isEmpty) return text;
    // Regex matching Lam (U+0644) + optional harakat/diacritics + Alef variants
    final regExp = RegExp(
      r'\u0644([\u0610-\u061A\u064B-\u065F\u0670]*)([\u0627\u0622\u0623\u0625])',
    );
    return text.replaceAllMapped(regExp, (match) {
      final harakat = match.group(1) ?? '';
      final alefChar = match.group(2) ?? '\u0627';
      String ligature = '\uFEFB'; // Lam-Alif
      if (alefChar == '\u0622') {
        ligature = '\uFEF5';
      } else if (alefChar == '\u0623') {
        ligature = '\uFEF7';
      } else if (alefChar == '\u0625') {
        ligature = '\uFEF9';
      }
      return '$ligature$harakat';
    });
  }

  List<InlineSpan> _buildWordSpans(String rawText,
      TextStyle baseStyle,
      VoidCallback onTap,
      VoidCallback onLongPress,) {
    final cleaned = fixLamAlif(rawText);
    return [
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              cleaned,
              style: baseStyle,
            ),
          ),
        ),
      ),
    ];
  }

  Future<void> _onWordLongPressed(int surah,
      int ayah,
      Map<String, dynamic> word,) async {
    final verseId = surah * 1000 + ayah;
    setState(() {
      _selectedSurah = surah;
      _selectedAyah = ayah;
    });
    await ref
        .read(quranProgressControllerProvider.notifier)
        .updateProgress(_currentPage, verseId: verseId);
  }

  Future<void> _onWordTapped(int surah,
      int ayah,
      Map<String, dynamic> word,) async {
    setState(() {
      _selectedSurah = surah;
      _selectedAyah = ayah;
    });

    final settings = ref.read(settingsControllerProvider);
    final currentLang = settings.language;
    final isUrdu = currentLang == 'ur';
    final isPashto = currentLang == 'ps';

    final verseArabicText = await QuranDbService().getVerseText(surah, ayah);
    final translation = await TranslationService().getTranslation(
      surah,
      ayah,
      language: currentLang,
    );
    final audioUrl = quran.getAudioURLByVerse(surah, ayah);
    final juzNum = quran.getJuzNumber(surah, ayah);

    final verse = Verse(
      id: surah * 1000 + ayah,
      surahNumber: surah,
      verseNumber: ayah,
      juzNumber: juzNum,
      pageNumber: _currentPage,
      textArabic: verseArabicText.isNotEmpty
          ? verseArabicText
          : (word['text']?.toString() ?? ''),
      translation:
      translation ??
          (isUrdu
              ? 'ترجمہ دستیاب نہیں'
              : (isPashto
              ? 'ترجمه و نه موندل شوه'
              : 'Translation not available')),
      audioUrl: audioUrl,
    );

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme
          .of(context)
          .cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => VerseBottomSheet(verse: verse),
    );

    if (mounted) {
      ref.read(quranAudioPlayerControllerProvider.notifier).stopAudio();
      setState(() {
        _selectedSurah = null;
        _selectedAyah = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    if (_isLoadingPage) {
      return Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFFAF6EE),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryTeal),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFAF6EE),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFFAF6EE),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : AppColors.primaryTeal,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "القرآن المجید",
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTeal,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _totalPages,
          reverse: true,
          // Right to left traditional Mushaf reading direction
          onPageChanged: (idx) {
            final newPage = idx + 1;
            setState(() {
              _currentPage = newPage;
              _selectedSurah = null;
              _selectedAyah = null;
            });
            _prefetchAdjacentPages(newPage);
            if (widget.shouldUpdateProgress) {
              ref
                  .read(quranProgressControllerProvider.notifier)
                  .updateProgress(newPage);
            }
          },
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            final lines = _pageLinesCache[pageNumber];
            if (lines == null) {
              _loadPage(pageNumber);
              return const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryTeal,
                  ),
                ),
              );
            }
            if (lines.isEmpty) {
              return const Center(child: Text('Page not found'));
            }

            final surahNameLine = lines.firstWhere(
                  (l) => l.lineType == 'surah_name',
              orElse: () =>
                  QuranLine(
                    pageNumber: pageNumber,
                    lineNumber: 0,
                    lineType: '',
                    isCentered: false,
                    text: '',
                    words: [],
                  ),
            );
            final bool hasNewSurah = surahNameLine.lineType == 'surah_name';
            final int? startingSurahNum = surahNameLine.surahNumber;

            final juzNum = QuranMetadataService().getJuzForIndoPakPage(
              pageNumber,
            );

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Real Mushaf Top Header with reduced opacity and increased spacing
                  Opacity(
                    opacity: 0.6,
                    child: _buildRealMushafTopHeader(
                      pageNumber,
                      juzNum,
                      isDark,
                      hasNewSurah: hasNewSurah,
                      startingSurah: startingSurahNum,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Divider(
                    height: 2,
                    thickness: 0.6,
                    color: AppColors.primaryTeal,
                  ),
                  const SizedBox(height: 12),

                  // 2. Lines Body (Centered and compact for page 1 & 2, spaceBetween for others)
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                      (pageNumber == 1 || pageNumber == 2)
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: lines
                          .asMap()
                          .entries
                          .map((entry) {
                        final idx = entry.key;
                        final line = entry.value;
                        final prevLine = idx > 0 ? lines[idx - 1] : null;
                        final isBasmallahAfterSurahName =
                            line.lineType == 'basmallah' &&
                                prevLine?.lineType == 'surah_name';

                        if (isBasmallahAfterSurahName) {
                          return const SizedBox.shrink();
                        }

                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: (pageNumber == 1 || pageNumber == 2)
                                ? 2.0
                                : 0.5,
                            horizontal: 4.0,
                          ),
                          child: _buildLineWidget(line, isDark, pageNumber),
                        );
                      }).toList(),
                    ),
                  ),

                  // 3. Real Mushaf Bottom Footer (Removed)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRealMushafTopHeader(int pageNumber,
      int juzNum,
      bool isDark, {
        bool hasNewSurah = false,
        int? startingSurah,
      }) {
    String surahTitle = '';
    try {
      final pageData = quran.getPageData(pageNumber);
      if (pageData.isNotEmpty) {
        final sNum = startingSurah ?? (pageData.first['surah'] as int);
        surahTitle = quran.getSurahNameArabic(sNum);
      }
    } catch (_) {}

    final juzName = (juzNum >= 1 && juzNum <= 30)
        ? QuranUtils.juzNamesArabic[juzNum - 1]
        : 'الجزء $juzNum';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Juz Name (not number)
        Text(
          juzName,
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
          textDirection: TextDirection.rtl,
        ),
        // Center: Clean smaller page number without background box
        Text(
          '$pageNumber',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : AppColors.primaryTeal,
          ),
        ),
        // Right: Surah Name in Arabic (only name, no ayat or maki/madani)
        Text(
          surahTitle,
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  Widget _buildLineWidget(QuranLine line, bool isDark, int pageNumber) {
    final bool isPage1Or2 = pageNumber == 1 || pageNumber == 2;
    final double textFontSize = isPage1Or2 ? 36.0 : 54.0;
    final double basmallahFontSize = isPage1Or2 ? 18.0 : 24.0;

    if (line.lineType == 'surah_name') {
      final sNum = line.surahNumber ?? 1;
      final surahName = quran.getSurahNameArabic(sNum);
      final verseCount = quran.getVerseCount(sNum);
      final place = quran.getPlaceOfRevelation(sNum) == 'Makkah'
          ? 'مكية'
          : 'مدنية';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F2EC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.primaryTeal.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  'سُورَةُ $surahName',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: isPage1Or2 ? 12 : 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primaryTeal,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '$verseCount آيات',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: isPage1Or2 ? 10 : 12,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  place,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: isPage1Or2 ? 10 : 12,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          if (sNum != 9) ...[
            const SizedBox(height: 2),
            Container(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِیْمِ',
                  style: TextStyle(
                    fontFamily: 'IndoPakFont',
                    fontSize: basmallahFontSize,
                    height: 1.0,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ],
      );
    }

    if (line.lineType == 'basmallah') {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            fixLamAlif(line.text),
            style: TextStyle(
              fontFamily: 'IndoPakFont',
              fontSize: basmallahFontSize,
              height: 1.0,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text.rich(
          TextSpan(
            children: line.words.reversed.expand((word) {
              final wordSurah =
                  int.tryParse((word['surah'] ?? 1).toString()) ?? 1;
              final wordAyah =
                  int.tryParse((word['ayah'] ?? 1).toString()) ?? 1;
              final wordVerseId = wordSurah * 1000 + wordAyah;

              final isSelected =
                  _selectedSurah == wordSurah && _selectedAyah == wordAyah;
              final isHighlighted =
                  widget.highlightVerseId != null &&
                      widget.highlightVerseId == wordVerseId;

              Color textColor;
              if (isSelected ||
                  (isHighlighted && !widget.isBookmarkHighlight)) {
                textColor = AppColors.accentGold;
              } else if (isHighlighted && widget.isBookmarkHighlight) {
                textColor = AppColors.primaryTeal;
              } else {
                textColor = isDark ? Colors.white : Colors.black87;
              }

              final wordStyle = TextStyle(
                fontFamily: 'IndoPakFont',
                fontSize: textFontSize,
                height: 1.02,
                color: textColor,
                backgroundColor: Colors.transparent,
              );

              return _buildWordSpans(
                word['text']?.toString() ?? '',
                wordStyle,
                    () => _onWordTapped(wordSurah, wordAyah, word),
                    () => _onWordLongPressed(wordSurah, wordAyah, word),
              );
            }).toList(),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
