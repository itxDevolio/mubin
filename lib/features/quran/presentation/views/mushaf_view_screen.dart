import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/services/settings_controller.dart';
import '../controllers/quran_progress_controller.dart';
import '../../../../services/translation_service.dart';
import '../../../../services/quran_db_service.dart';
import '../../../../services/quran_metadata_service.dart';
import '../../domain/entities/verse.dart';
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
  final int _totalPages = 548; // 16-line IndoPak Mushaf total pages
  int? _selectedSurah;
  int? _selectedAyah;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, _totalPages);
    _pageController = PageController(initialPage: _currentPage - 1);

    _initScreen();
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

  List<InlineSpan> _buildWordSpans(
    String rawText,
    TextStyle baseStyle,
    VoidCallback onTap,
  ) {
    final cleaned = fixLamAlif(rawText);
    return [
      TextSpan(
        text: '$cleaned ',
        style: baseStyle,
        recognizer: TapGestureRecognizer()..onTap = onTap,
      ),
    ];
  }

  Future<void> _onWordTapped(
    int surah,
    int ayah,
    Map<String, dynamic> word,
  ) async {
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
              : (isPashto ? 'ترجمه و نه موندل شوه' : 'Translation not available')),
      audioUrl: audioUrl,
    );

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => VerseBottomSheet(verse: verse),
    );

    if (mounted) {
      setState(() {
        _selectedSurah = null;
        _selectedAyah = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            if (widget.shouldUpdateProgress) {
              ref
                  .read(quranProgressControllerProvider.notifier)
                  .updateProgress(newPage);
            }
          },
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            return FutureBuilder<List<QuranLine>>(
              future: QuranDbService().getPageLines(pageNumber),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryTeal,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading page: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                final lines = snapshot.data ?? [];
                if (lines.isEmpty) {
                  return const Center(child: Text('Page not found'));
                }

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
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(height: 12),

                      // 2. Lines Body (Centered for page 1 & 2, spaceBetween for others)
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                              (pageNumber == 1 || pageNumber == 2)
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: lines.map((line) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: (pageNumber == 1 || pageNumber == 2)
                                    ? 12.0
                                    : 1.0,
                                horizontal: 4.0,
                              ),
                              child: _buildLineWidget(line, isDark),
                            );
                          }).toList(),
                        ),
                      ),

                      // 3. Real Mushaf Bottom Footer
                      const SizedBox(height: 6),
                      const Divider(
                        height: 2,
                        thickness: 0.6,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(height: 6),
                      Opacity(
                        opacity: 0.6,
                        child: _buildRealMushafBottomFooter(pageNumber, isDark),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildRealMushafTopHeader(int pageNumber, int juzNum, bool isDark) {
    String surahTitle = '';
    try {
      final pageData = quran.getPageData(pageNumber);
      if (pageData.isNotEmpty) {
        final sNum = pageData.first['surah'] as int;
        surahTitle = quran.getSurahNameArabic(sNum);
      }
    } catch (_) {}

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Para / Juz Name from exact IndoPak page mapping
        Text(
          'الجزء $juzNum',
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
        // Right: Surah Name in Arabic
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

  Widget _buildRealMushafBottomFooter(int pageNumber, bool isDark) {
    final manzilNum = ((pageNumber - 1) * 7 ~/ 548) + 1;

    return Center(
      child: Text(
        'منزل $manzilNum',
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTeal,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildLineWidget(QuranLine line, bool isDark) {
    if (line.lineType == 'surah_name') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fixLamAlif(line.text),
              style: TextStyle(
                fontFamily: 'IndoPakFont',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.primaryTeal,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      );
    }

    if (line.lineType == 'basmallah') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        alignment: Alignment.center,
        child: Text(
          fixLamAlif(line.text),
          style: TextStyle(
            fontFamily: 'IndoPakFont',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          textDirection: TextDirection.rtl,
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text.rich(
          TextSpan(
            children: line.words.expand((word) {
              final wordSurah =
                  int.tryParse((word['surah'] ?? 1).toString()) ?? 1;
              final wordAyah =
                  int.tryParse((word['ayah'] ?? 1).toString()) ?? 1;

              final isHighlighted =
                  _selectedSurah == wordSurah && _selectedAyah == wordAyah;

              final wordStyle = TextStyle(
                fontFamily: 'IndoPakFont',
                fontSize: 54,
                height: 1.02,
                color: isDark ? Colors.white : Colors.black87,
                backgroundColor: isHighlighted
                    ? AppColors.primaryTeal.withValues(alpha: 0.25)
                    : Colors.transparent,
              );

              return _buildWordSpans(
                word['text']?.toString() ?? '',
                wordStyle,
                () => _onWordTapped(wordSurah, wordAyah, word),
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
