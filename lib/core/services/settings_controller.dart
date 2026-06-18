import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../constant/db_consts.dart';

class SettingsState {
  final String language; // 'en' or 'ur'

  SettingsState({this.language = 'en'});

  SettingsState copyWith({String? language}) {
    return SettingsState(language: language ?? this.language);
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final box = Hive.box(DbConstants.appBox);
    final lang = box.get('language', defaultValue: 'en');
    state = state.copyWith(language: lang);
  }

  Future<void> setLanguage(String lang) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('language', lang);
    state = state.copyWith(language: lang);
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      return SettingsController();
    });
