import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/verse.dart';
import 'quran_di_providers.dart';

class BookmarkController extends Notifier<AsyncValue<List<Verse>>> {
  @override
  AsyncValue<List<Verse>> build() {
    Future.microtask(() => loadBookmarks());
    return const AsyncValue.loading();
  }

  Future<void> loadBookmarks() async {
    try {
      final list = await ref
          .read(quranRepositoryProvider)
          .getBookmarkedVerses();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleBookmarkState(Verse verse) async {
    try {
      await ref.read(quranRepositoryProvider).toggleBookmark(verse);
      await loadBookmarks();
    } catch (e) {
      // Graceful error handling
    }
  }
}

final bookmarkControllerProvider =
    NotifierProvider<BookmarkController, AsyncValue<List<Verse>>>(() {
  return BookmarkController();
});
