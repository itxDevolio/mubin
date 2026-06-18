import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/reading_progress.dart';
import 'quran_di_providers.dart';

class QuranProgressController
    extends StateNotifier<AsyncValue<ReadingProgress>> {
  final Ref _ref;

  QuranProgressController(this._ref) : super(const AsyncValue.loading()) {
    loadProgress();
  }

  Future<void> loadProgress() async {
    try {
      final repo = _ref.read(quranRepositoryProvider);
      final currentProgress = await repo.getReadingProgress();
      state = AsyncValue.data(currentProgress);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProgress(int pageNumber) async {
    try {
      final repo = _ref.read(quranRepositoryProvider);
      await repo.saveReadingProgress(pageNumber);

      // Update local state without full reload if possible, or just refresh
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
    StateNotifierProvider<QuranProgressController, AsyncValue<ReadingProgress>>(
      (ref) {
        return QuranProgressController(ref);
      },
    );
