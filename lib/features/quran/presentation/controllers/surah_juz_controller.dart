import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/surah.dart';
import 'quran_di_providers.dart';

class SurahJuzState {
  final AsyncValue<List<Surah>> surahs;
  final List<Surah> filteredSurahs;
  final int selectedVerseId;

  SurahJuzState({
    required this.surahs,
    this.filteredSurahs = const [],
    this.selectedVerseId = -1,
  });

  SurahJuzState copyWith({
    AsyncValue<List<Surah>>? surahs,
    List<Surah>? filteredSurahs,
    int? selectedVerseId,
  }) {
    return SurahJuzState(
      surahs: surahs ?? this.surahs,
      filteredSurahs: filteredSurahs ?? this.filteredSurahs,
      selectedVerseId: selectedVerseId ?? this.selectedVerseId,
    );
  }
}

class SurahJuzController extends StateNotifier<SurahJuzState> {
  final Ref _ref;

  SurahJuzController(this._ref)
    : super(SurahJuzState(surahs: const AsyncValue.loading())) {
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    try {
      final repo = _ref.read(quranRepositoryProvider);
      final list = await repo.getSurahs();
      state = state.copyWith(
        surahs: AsyncValue.data(list),
        filteredSurahs: list,
      );
    } catch (e, stack) {
      state = state.copyWith(surahs: AsyncValue.error(e, stack));
    }
  }

  void searchSurah(String query) {
    state.surahs.whenData((list) {
      if (query.isEmpty) {
        state = state.copyWith(filteredSurahs: list);
      } else {
        final filtered = list
            .where(
              (s) =>
                  s.nameEnglish.toLowerCase().contains(query.toLowerCase()) ||
                  s.number.toString() == query,
            )
            .toList();
        state = state.copyWith(filteredSurahs: filtered);
      }
    });
  }

  void selectVerse(int verseId) {
    state = state.copyWith(selectedVerseId: verseId);
  }
}

final surahJuzControllerProvider =
    StateNotifierProvider<SurahJuzController, SurahJuzState>((ref) {
      return SurahJuzController(ref);
    });
