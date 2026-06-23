import 'package:dio/dio.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/chapter.dart';
import '../../domain/entities/hadith.dart';
import '../../domain/repositories/hadith_repository.dart';
import '../models/book_model.dart';
import '../models/chapter_model.dart';
import '../models/hadith_model.dart';
import '../datasources/hadith_local_data_source.dart';

class HadithRepositoryImpl implements HadithRepository {
  final HadithLocalDataSource localDataSource;
  final Dio dio = Dio(); // Dio instance
  final String apiKey = "\$2y\$10\$H7TztFj7y9lytzjLZ6UBcOO85JTBulutb8kgQJlpXIU50v1GkqIYW";

  HadithRepositoryImpl(this.localDataSource);

  @override
  Future<List<BookEntity>> getBooks() async {
    try {
      final response = await dio.get(
        'https://hadithapi.com/api/books',
        queryParameters: {'apiKey': apiKey},
      );

      if (response.statusCode == 200) {
        final List data = response.data['books']['data'];
        return data.map((e) => BookModel.fromJson(e)).toList();
      }
      throw Exception('Failed to load books');
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }

  @override
  Future<List<ChapterEntity>> getChapters(String bookSlug) async {
    try {
      final response = await dio.get(
        'https://hadithapi.com/api/$bookSlug/chapters',
        queryParameters: {'apiKey': apiKey},
      );

      if (response.statusCode == 200) {
        final List data = response.data['chapters']['data'];
        return data.map((e) => ChapterModel.fromJson(e)).toList();
      }
      throw Exception('Failed to load chapters');
    } catch (e) {
      throw Exception('Error fetching chapters: $e');
    }
  }

  @override
  Future<List<HadithEntity>> getHadiths(String bookSlug, String chapterNumber) async {
    // Local logic (Hive) same rahega
    // API logic with Dio:
    try {
      final response = await dio.get(
        'https://hadithapi.com/api/hadiths',
        queryParameters: {
          'apiKey': apiKey,
          'book': bookSlug,
          'chapter': chapterNumber
        },
      );

      final List data = response.data['hadiths']['data'];
      return data.map((e) => HadithModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error fetching hadiths: $e');
    }
  }
}