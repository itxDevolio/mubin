import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  final String apiKey = r"$2y$10$H7TztFj7y9lytzjLZ6UBcOO85JTBulutb8kgQJlpXIU50v1GkqIYW";

  HadithRepositoryImpl(this.localDataSource);

  @override
  Future<List<BookEntity>> getBooks() async {
    const String cacheKey = 'hadith_books';

    final cachedData = localDataSource.getCachedHadiths(cacheKey);
    if (cachedData != null && cachedData is List && cachedData.isNotEmpty) {
      final List<BookEntity> books =
          cachedData.map((e) => BookModel.fromJson(Map<String, dynamic>.from(e))).toList();
      return books.take(6).toList();
    }

    try {
      final response = await dio.get(
        'https://hadithapi.com/api/books',
        queryParameters: {'apiKey': apiKey},
      );

      if (response.statusCode == 200) {
        final data = response.data['books'];
        if (data is List) {
          await localDataSource.cacheHadiths(cacheKey, data);
          final List<BookEntity> books = data.map((e) => BookModel.fromJson(e)).toList();
          return books.take(6).toList();
        }
      }
      throw Exception('Failed to load books');
    } catch (e) {
      if (cachedData != null && cachedData is List) {
        final List<BookEntity> books =
            cachedData.map((e) => BookModel.fromJson(Map<String, dynamic>.from(e))).toList();
        return books.take(6).toList();
      }
      throw Exception('Error fetching books: $e');
    }
  }

  @override
  Future<List<ChapterEntity>> getChapters(String bookSlug) async {
    final String cacheKey = 'hadith_chapters_$bookSlug';

    final cachedData = localDataSource.getCachedHadiths(cacheKey);
    if (cachedData != null && cachedData is List && cachedData.isNotEmpty) {
      return cachedData.map((e) => ChapterModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }

    try {
      final response = await dio.get(
        'https://hadithapi.com/api/$bookSlug/chapters',
        queryParameters: {'apiKey': apiKey},
      );

      if (response.statusCode == 200) {
        final data = response.data['chapters'];
        if (data is List) {
          await localDataSource.cacheHadiths(cacheKey, data);
          return data.map((e) => ChapterModel.fromJson(e)).toList();
        }
      }
      throw Exception('Failed to load chapters');
    } catch (e) {
      if (cachedData != null && cachedData is List) {
        return cachedData.map((e) => ChapterModel.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      throw Exception('Error fetching chapters: $e');
    }
  }

  @override
  Future<List<HadithEntity>> getHadiths(String bookSlug, String chapterNumber) async {
    final String cacheKey = 'hadiths_${bookSlug}_ch$chapterNumber';

    final cachedData = localDataSource.getCachedHadiths(cacheKey);
    if (cachedData != null && cachedData is List && cachedData.isNotEmpty) {
      return cachedData.map((e) => HadithModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }

    try {
      final response = await dio.get(
        'https://hadithapi.com/api/hadiths',
        queryParameters: {
          'apiKey': apiKey,
          'book': bookSlug,
          'chapter': chapterNumber
        },
      );

      if (response.statusCode == 200) {
        final List? data = response.data['hadiths']['data'];
        if (data != null) {
          await localDataSource.cacheHadiths(cacheKey, data);
          return data.map((e) => HadithModel.fromJson(e)).toList();
        }
      }
      throw Exception('Failed to load hadiths');
    } catch (e) {
      if (cachedData != null && cachedData is List) {
        return cachedData.map((e) => HadithModel.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      throw Exception('Error fetching hadiths: $e');
    }
  }

  @override
  Future<List<HadithEntity>> searchHadiths(String query, bool isUrdu) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return [];

    final String cacheKey = 'search_hadiths_${isUrdu ? "ur" : "en"}_${trimmedQuery.toLowerCase()}';

    // 1. Check Cache
    final cachedData = localDataSource.getCachedHadiths(cacheKey);
    if (cachedData != null && cachedData is List && cachedData.isNotEmpty) {
      return cachedData.map((e) => HadithModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }

    // 2. Online Dynamic Search across all books via API with higher pagination & relevance
    try {
      Response response;
      if (isUrdu) {
        response = await dio.get(
          'https://hadithapi.com/api/hadiths',
          queryParameters: {
            'apiKey': apiKey,
            'hadithUrdu': trimmedQuery,
            'paginate': 100,
          },
        );
      } else {
        response = await dio.get(
          'https://hadithapi.com/api/hadiths',
          queryParameters: {
            'apiKey': apiKey,
            'hadithEnglish': trimmedQuery,
            'paginate': 100,
          },
        );
      }

      List rawList = [];
      if (response.statusCode == 200 && response.data != null) {
        final rawHadiths = response.data['hadiths'];
        if (rawHadiths is Map && rawHadiths['data'] is List) {
          rawList = rawHadiths['data'];
        } else if (rawHadiths is List) {
          rawList = rawHadiths;
        }
      }

      // Fallback: If no results, try opposite parameter
      if (rawList.isEmpty) {
        final fallbackResponse = await dio.get(
          'https://hadithapi.com/api/hadiths',
          queryParameters: {
            'apiKey': apiKey,
            isUrdu ? 'hadithEnglish' : 'hadithUrdu': trimmedQuery,
            'paginate': 100,
          },
        );
        if (fallbackResponse.statusCode == 200 && fallbackResponse.data != null) {
          final rawHadiths = fallbackResponse.data['hadiths'];
          if (rawHadiths is Map && rawHadiths['data'] is List) {
            rawList = rawHadiths['data'];
          } else if (rawHadiths is List) {
            rawList = rawHadiths;
          }
        }
      }

      if (rawList.isNotEmpty) {
        await localDataSource.cacheHadiths(cacheKey, rawList);
        List<HadithModel> hadiths = rawList.map((e) => HadithModel.fromJson(e)).toList();

        // Relevance Scoring & Sorting for high accuracy on topics / masail
        final queryTokens = trimmedQuery.toLowerCase().split(RegExp(r'\s+'));
        hadiths.sort((a, b) {
          int scoreA = _calculateRelevance(a, queryTokens, isUrdu);
          int scoreB = _calculateRelevance(b, queryTokens, isUrdu);
          return scoreB.compareTo(scoreA); // Highest relevance score first
        });

        return hadiths;
      }
      return [];
    } catch (e) {
      debugPrint("Hadith search error: $e");
      if (cachedData != null && cachedData is List) {
        return cachedData.map((e) => HadithModel.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      return [];
    }
  }

  int _calculateRelevance(HadithEntity hadith, List<String> queryTokens, bool isUrdu) {
    int score = 0;
    final heading = (isUrdu ? hadith.headingUrdu : hadith.headingEnglish).toLowerCase();
    final text = (isUrdu ? hadith.urduText : hadith.englishText).toLowerCase();
    final altHeading = (isUrdu ? hadith.headingEnglish : hadith.headingUrdu).toLowerCase();
    final altText = (isUrdu ? hadith.englishText : hadith.urduText).toLowerCase();

    for (var token in queryTokens) {
      if (token.isEmpty) continue;
      if (heading.contains(token)) score += 15; // Heading/Topic match is paramount
      if (text.contains(token)) score += 4;
      if (altHeading.contains(token)) score += 8;
      if (altText.contains(token)) score += 2;
    }
    return score;
  }
}
