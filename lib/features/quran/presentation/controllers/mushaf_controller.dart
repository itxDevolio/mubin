import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/verse.dart';
import '../../../../core/services/settings_controller.dart';
import 'quran_di_providers.dart';

class MushafController extends Notifier<Map<int, AsyncValue<List<Verse>>>> {
  @override
  Map<int, AsyncValue<List<Verse>>> build() {
    return const {};
  }

  Future<void> loadVersesForPage(int pageNumber, {bool silent = false}) async {
    // Basic range check
    if (pageNumber < 1 || pageNumber > 604) return;

    // Skip if already loading or has data (unless error, then allow retry)
    final current = state[pageNumber];
    if (current != null && (current.isLoading || (current.hasValue && !current.hasError))) {
      return;
    }

    if (!silent) {
      // Delaying state update slightly to avoid Riverpod build cycle conflicts
      Future.microtask(() {
        state = {...state, pageNumber: const AsyncValue.loading()};
      });
    }

    try {
      final repo = ref.read(quranRepositoryProvider);
      final lang = ref.read(settingsControllerProvider).language;
      final verses = await repo.getVerses(pageNumber, lang: lang);
      
      state = {...state, pageNumber: AsyncValue.data(verses)};
    } catch (e, stack) {
      state = {...state, pageNumber: AsyncValue.error(e, stack)};
    }
  }

  void clearCache() {
    state = const {};
  }
}

final mushafControllerProvider =
    NotifierProvider<MushafController, Map<int, AsyncValue<List<Verse>>>>(() {
  return MushafController();
});
