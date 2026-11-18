import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/chapter.dart';
import '../../domain/entities/hadith.dart';
import 'hadith_notifier.dart';

final booksProvider = FutureProvider<List<BookEntity>>((ref) async {
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.getBooks();
});

final chaptersProvider = FutureProvider.family<List<ChapterEntity>, String>((ref, bookSlug) async {
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.getChapters(bookSlug);
});

class SearchParam {
  final String query;
  final bool isUrdu;
  const SearchParam({required this.query, required this.isUrdu});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchParam &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          isUrdu == other.isUrdu;

  @override
  int get hashCode => query.hashCode ^ isUrdu.hashCode;
}

final globalHadithSearchProvider = FutureProvider.family<List<HadithEntity>, SearchParam>((ref, param) async {
  if (param.query.trim().isEmpty) return [];
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.searchHadiths(param.query, param.isUrdu);
});

class BookSearchParam {
  final String bookSlug;
  final String query;
  final bool isUrdu;
  const BookSearchParam({required this.bookSlug, required this.query, required this.isUrdu});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookSearchParam &&
          runtimeType == other.runtimeType &&
          bookSlug == other.bookSlug &&
          query == other.query &&
          isUrdu == other.isUrdu;

  @override
  int get hashCode => bookSlug.hashCode ^ query.hashCode ^ isUrdu.hashCode;
}

final bookHadithSearchProvider = FutureProvider.family<List<HadithEntity>, BookSearchParam>((ref, param) async {
  if (param.query.trim().isEmpty) return [];
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.searchHadithsByBook(param.bookSlug, param.query, param.isUrdu);
});
