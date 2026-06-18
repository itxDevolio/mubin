import '../entities/surah.dart';
import '../entities/juz.dart';
import '../entities/verse.dart';
import '../entities/reading_progress.dart';

abstract class QuranRepository {
  // Quran Data
  Future<List<Surah>> getSurahs({String lang = 'en'});
  Future<List<Juz>> getJuzList({String lang = 'en'});

  // Progress tracking
  Future<void> saveReadingProgress(int pageNumber);
  Future<ReadingProgress> getReadingProgress();

  // Bookmarks
  Future<void> toggleBookmark(
    Verse verse,
  ); // Updated: name is now part of entity if provided
  Future<List<Verse>> getBookmarkedVerses();
  Future<List<Verse>> getVerses(int page, {String lang = 'en'});
}
