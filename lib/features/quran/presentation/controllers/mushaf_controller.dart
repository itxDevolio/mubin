import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/verse.dart';
import '../../../../core/services/settings_controller.dart';
import 'quran_di_providers.dart';

class MushafController extends StateNotifier<Map<int, AsyncValue<List<Verse>>>> {
  final Ref _ref;

  MushafController(this._ref) : super(const {});

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
      final repo = _ref.read(quranRepositoryProvider);
      final lang = _ref.read(settingsControllerProvider).language;
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
    StateNotifierProvider<MushafController, Map<int, AsyncValue<List<Verse>>>>((ref) {
      return MushafController(ref);
    });
