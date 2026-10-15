import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reading_progress.dart';
import 'quran_di_providers.dart';

class QuranProgressController
    extends Notifier<AsyncValue<ReadingProgress>> {
  @override
  AsyncValue<ReadingProgress> build() {
    Future.microtask(() => loadProgress());
    return const AsyncValue.loading();
  }

  Future<void> loadProgress() async {
    try {
      final repo = ref.read(quranRepositoryProvider);
      final currentProgress = await repo.getReadingProgress();
      state = AsyncValue.data(currentProgress);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProgress(int pageNumber) async {
    try {
      final repo = ref.read(quranRepositoryProvider);
      await repo.saveReadingProgress(pageNumber);

      final updatedProgress = ReadingProgress(
        lastReadPage: pageNumber,
        updatedAt: DateTime.now(),
      );
      state = AsyncValue.data(updatedProgress);
    } catch (e) {
      // Background silent failure
    }
  }
}

final quranProgressControllerProvider =
    NotifierProvider<QuranProgressController, AsyncValue<ReadingProgress>>(() {
  return QuranProgressController();
});
