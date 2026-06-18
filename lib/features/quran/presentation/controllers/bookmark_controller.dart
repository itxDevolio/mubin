import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/verse.dart';
import 'quran_di_providers.dart'; // Make sure this contains the provider declaration below

class BookmarkController extends StateNotifier<AsyncValue<List<Verse>>> {
  final Ref _ref;

  BookmarkController(this._ref) : super(const AsyncValue.loading()) {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      // FIX: Changed getQuranRepositoryProvider to quranRepositoryProvider
      final list = await _ref
          .read(quranRepositoryProvider)
          .getBookmarkedVerses();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleBookmarkState(Verse verse) async {
    try {
      // FIX: Changed getQuranRepositoryProvider to quranRepositoryProvider
      await _ref.read(quranRepositoryProvider).toggleBookmark(verse);
      await loadBookmarks(); // Re-fetch updated items from local disk
    } catch (e) {
      // Graceful error handling
    }
  }
}

final bookmarkControllerProvider =
    StateNotifierProvider<BookmarkController, AsyncValue<List<Verse>>>((ref) {
      return BookmarkController(ref);
    });
