// Books Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/chapter.dart';
import 'hadith_notifier.dart';

final booksProvider = FutureProvider<List<BookEntity>>((ref) async {
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.getBooks(); // API: /books
});

// Chapters Provider (Auto-dispose use karein taake nayi book par reset ho)
final chaptersProvider = FutureProvider.family<List<ChapterEntity>, String>((ref, bookSlug) async {
  final repo = ref.read(hadithRepositoryProvider);
  return await repo.getChapters(bookSlug); // API: /$bookSlug/chapters
});