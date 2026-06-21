import 'package:auraq/features/quran/domain/entities/reciter.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

import '../constant/db_consts.dart';

class SettingsState {
  final String language;
  final Reciter currentReciter;

  SettingsState({
    this.language = 'en',
    Reciter? currentReciter,
  }) : currentReciter = currentReciter ?? availableReciters.first;

  SettingsState copyWith({
    String? language,
    Reciter? currentReciter,
  }) {
    return SettingsState(
      language: language ?? this.language,
      currentReciter: currentReciter ?? this.currentReciter,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final box = Hive.box(DbConstants.appBox);

    final String lang = box.get(
      'language',
      defaultValue: 'en',
    );

    final String? reciterName = box.get('reciterName');

    Reciter reciter = availableReciters.first;

    if (reciterName != null) {
      reciter = availableReciters.firstWhere(
            (r) => r.name == reciterName,
        orElse: () => availableReciters.first,
      );
    }

    state = state.copyWith(
      language: lang,
      currentReciter: reciter,
    );
  }

  Future<void> setLanguage(String lang) async {
    final box = Hive.box(DbConstants.appBox);

    await box.put('language', lang);

    state = state.copyWith(
      language: lang,
    );
  }

  Future<void> setReciter(Reciter reciter) async {
    final box = Hive.box(DbConstants.appBox);

    await box.put(
      'reciterName',
      reciter.name,
    );

    state = state.copyWith(
      currentReciter: reciter,
    );
  }
}

final settingsControllerProvider =
StateNotifierProvider<SettingsController, SettingsState>(
      (ref) => SettingsController(),
);