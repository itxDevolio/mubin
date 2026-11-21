import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/services/settings_controller.dart';
import '../../../../core/services/tafseer_service.dart';
import '../controllers/quran_progress_controller.dart';
import '../../../../services/quran_db_service.dart';
import '../../../../services/translation_service.dart';
import '../../../../services/quran_metadata_service.dart';

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

  Future<void> _onWordTapped(int surah, int ayah, Map<String, dynamic> word) async {
    setState(() {
      _selectedSurah = surah;
      _selectedAyah = ayah;
    });

    final settings = ref.read(settingsControllerProvider);
    final currentLang = settings.language;
    final isUrdu = currentLang == 'ur';
    final isPashto = currentLang == 'ps';
    final isRtl = isUrdu || isPashto;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final verseArabicText = await QuranDbService().getVerseText(surah, ayah);

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (verseArabicText.isNotEmpty) ...[
                    Text(
                      verseArabicText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IndoPakFont',
                        fontSize: 22,
                        height: 1.8,
                        color: AppColors.primaryTeal,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, thickness: 0.8),
                    const SizedBox(height: 20),
                  ],
                  FutureBuilder<bool>(
                    future: QuranDbService().doesAyahSpanToNextPage(_currentPage, surah, ayah),
                    builder: (context, spanSnapshot) {
                      final spansNextPage = spanSnapshot.data ?? false;

                      return FutureBuilder<String?>(
                        future: TranslationService().getTranslation(surah, ayah, language: currentLang),
                        builder: (context, transSnapshot) {
                          final translation = transSnapshot.data ?? (isUrdu ? 'ترجمہ دستیاب نہیں' : (isPashto ? 'ترجمه و نه موندل شوه' : 'Translation not available'));

                          return FutureBuilder<String?>(
                            future: settings.enableTafseer
                                ? TafseerService().getTafseer(surahNumber: surah, verseNumber: ayah, language: currentLang)
                                : Future.value(null),
                            builder: (context, tafseerSnapshot) {
                              final tafseer = tafseerSnapshot.data;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translation,
                                    textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                                    style: isPashto
                                        ? TextStyle(
                                            fontFamily: 'Amiri',
                                            fontSize: 15,
                                            height: 2.2,
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                          )
                                        : (isUrdu
                                            ? TextStyle(
                                                fontFamily: 'NotoNastaliqUrdu',
                                                fontSize: 14,
                                                height: 2.2,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                              )
                                            : TextStyle(
                                                fontSize: 14,
                                                height: 1.6,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                              )),
                                  ),
                                  if (spansNextPage) ...[
                                    const SizedBox(height: 12),
                                    Text(
                                      isUrdu
                                          ? '(یہ آیت اگلے صفحے پر بھی جاری ہے)'
                                          : (isPashto ? '(دا آیت په بل مخ کې هم دوام لري)' : '(This verse also continues on the next page)'),
                                      style: TextStyle(
                                        fontFamily: isPashto ? 'Amiri' : (isRtl ? 'NotoNastaliqUrdu' : 'Poppins'),
                                        fontSize: 12,
                                        color: AppColors.primaryTeal,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                  if (settings.enableTafseer && tafseer != null && tafseer.isNotEmpty) ...[
                                    const SizedBox(height: 16),
                                    const Divider(height: 1, thickness: 0.8),
                                    const SizedBox(height: 12),
                                    Text(
                                      isUrdu ? 'تفسیر:' : (isPashto ? 'تفسیر:' : 'Tafseer:'),
                                      style: TextStyle(
                                        fontFamily: isPashto ? 'Amiri' : (isRtl ? 'NotoNastaliqUrdu' : 'Poppins'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: AppColors.primaryTeal,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      tafseer,
                                      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                                      style: isPashto
                                          ? TextStyle(
                                              fontFamily: 'Amiri',
                                              fontSize: 14,
                                              height: 2.0,
                                              color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.9),
                                            )
                                          : (isRtl
                                              ? TextStyle(
                                                  fontFamily: 'NotoNastaliqUrdu',
                                                  fontSize: 12.5,
                                                  height: 2.0,
                                                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.9),
                                                )
                                              : TextStyle(
                                                  fontSize: 12.5,
                                                  height: 1.5,
                                                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.9),
                                                )),
                                    ),
                                  ],
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
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
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAF6EE),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFAF6EE),
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
          reverse: true, // Right to left traditional Mushaf reading direction
          onPageChanged: (idx) {
            final newPage = idx + 1;
            setState(() {
              _currentPage = newPage;
              _selectedSurah = null;
              _selectedAyah = null;
            });
            if (widget.shouldUpdateProgress) {
              ref.read(quranProgressControllerProvider.notifier).updateProgress(newPage);
            }
          },
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            return FutureBuilder<List<QuranLine>>(
              future: QuranDbService().getPageLines(pageNumber),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryTeal),
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

                final juzNum = QuranMetadataService().getJuzForIndoPakPage(pageNumber);

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Real Mushaf Top Header using exact 16-line IndoPak page-to-Juz mapping
                      _buildRealMushafTopHeader(pageNumber, juzNum, isDark),
                      const Divider(height: 4, thickness: 0.8, color: AppColors.primaryTeal),

                      // 2. 16 Lines Body with reduced spacing and NO side markers
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: lines.map((line) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                              child: _buildLineWidget(line, isDark),
                            );
                          }).toList(),
                        ),
                      ),

                      // 3. Real Mushaf Bottom Footer
                      const Divider(height: 4, thickness: 0.8, color: AppColors.primaryTeal),
                      _buildRealMushafBottomFooter(pageNumber, isDark),
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
              line.text,
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
          line.text,
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

    // Render individual words of the ayah line so user can click a specific verse/word
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: line.words.map((word) {
            final wordSurah = int.tryParse((word['surah'] ?? 1).toString()) ?? 1;
            final wordAyah = int.tryParse((word['ayah'] ?? 1).toString()) ?? 1;

            final isHighlighted = _selectedSurah == wordSurah && _selectedAyah == wordAyah;

            return InkWell(
              onTap: () => _onWordTapped(wordSurah, wordAyah, word),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppColors.primaryTeal.withValues(alpha: 0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  word['text']?.toString() ?? '',
                  style: TextStyle(
                    fontFamily: 'IndoPakFont',
                    fontSize: 54,
                    height: 1.02,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
