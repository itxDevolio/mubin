import 'package:quran/quran.dart' as quran;

import '../../domain/entities/juz.dart';
import '../../domain/entities/reading_progress.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/verse.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_data_source.dart';
import '../models/reading_progress_model.dart';
import '../models/verse_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Surah>> getSurahs({String lang = 'en'}) async {
    try {
      List<Surah> surahList = [];
      for (int i = 1; i <= quran.totalSurahCount; i++) {
        surahList.add(
          Surah(
            number: i,
            nameArabic: quran.getSurahNameArabic(i),
            nameEnglish: quran.getSurahNameEnglish(i),
            totalVerses: quran.getVerseCount(i),
          ),
        );
      }
      return surahList;
    } catch (e) {
      throw Exception("Error parsing data from quran package: $e");
    }
  }

  @override
  Future<List<Juz>> getJuzList({String lang = 'en'}) async {
    try {
      List<Juz> totalJuzList = [];
      for (int i = 1; i <= 30; i++) {
        totalJuzList.add(
          Juz(number: i, verses: []),
        ); // Lazy load verses if needed
      }
      return totalJuzList;
    } catch (e) {
      throw Exception("Error compiling Juz list: $e");
    }
  }

  @override
  Future<void> saveReadingProgress(int pageNumber) async {
    final progressModel = ReadingProgressModel(
      lastReadPage: pageNumber,
      updatedAt: DateTime.now(),
    );
    await localDataSource.cacheReadingProgress(progressModel);
  }

  @override
  Future<ReadingProgress> getReadingProgress() async {
    final localProgress = await localDataSource.getLastReadingProgress();
    if (localProgress != null) {
      return localProgress;
    }
    return ReadingProgress.initial();
  }

  @override
  Future<void> toggleBookmark(Verse verse) async {
    final bookmarks = await localDataSource.getCachedBookmarks();
    final isBookmarked = bookmarks.any((b) => b.id == verse.id);

    if (isBookmarked) {
      await localDataSource.removeBookmark(verse.id);
    } else {
      await localDataSource.saveBookmark(VerseModel.fromEntity(verse));
    }
  }

  @override
  Future<List<Verse>> getBookmarkedVerses() async {
    final bookmarks = await localDataSource.getCachedBookmarks();
    return bookmarks;
  }

  @override
  Future<List<Verse>> getVerses(int page, {String lang = 'en'}) async {
    try {
      final List<dynamic> rawPageData = quran.getPageData(page);
      List<Verse> verses = [];

      final translationType = lang == 'ur'
          ? quran.Translation.urdu
          : quran.Translation.enSaheeh;

      for (var element in rawPageData) {
        final Map<String, dynamic> data = element as Map<String, dynamic>;
        final int surah = data['surah'] as int;
        final int start = data['start'] as int;
        final int end = data['end'] as int;

        for (int v = start; v <= end; v++) {
          verses.add(
            Verse(
              id: surah * 1000 + v,
              surahNumber: surah,
              verseNumber: v,
              textArabic: quran.getVerse(surah, v, verseEndSymbol: true),
              translation: quran.getVerseTranslation(
                surah,
                v,
                translation: translationType,
              ),
              audioUrl: quran.getAudioURLByVerse(surah, v),
              juzNumber: quran.getJuzNumber(surah, v),
              pageNumber: quran.getPageNumber(surah, v),
            ),
          );
        }
      }
      return verses;
    } catch (e) {
      throw Exception("Error fetching verses for page $page: $e");
    }
  }
}
