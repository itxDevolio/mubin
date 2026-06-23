import '../entities/book.dart';
import '../entities/hadith.dart';
import '../entities/chapter.dart';

abstract class HadithRepository {
  // Naye methods add karein
  Future<List<BookEntity>> getBooks();
  Future<List<ChapterEntity>> getChapters(String bookSlug);
  Future<List<HadithEntity>> getHadiths(String bookSlug, String chapterNumber);
}