import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;

class TranslationService {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  final Map<String, Map<String, dynamic>> _cache = {};

  Future<Map<String, dynamic>> _loadMap(String language) async {
    if (_cache.containsKey(language)) {
      return _cache[language]!;
    }

    final String assetPath = language == 'ur'
        ? 'assets/tafseer/tazkiru-quran-ur.json'
        : (language == 'ps'
            ? 'assets/tafseer/pashto_tarjama.json'
            : 'assets/tafseer/tazkirul-quran-en.json');

    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final decoded = json.decode(jsonString);
      if (decoded is Map<String, dynamic>) {
        _cache[language] = decoded;
      } else if (decoded is Map) {
        _cache[language] = decoded.map((k, v) => MapEntry(k.toString(), v));
      } else {
        _cache[language] = {};
      }
    } catch (e) {
      _cache[language] = {};
    }
    return _cache[language]!;
  }

  Future<String?> getTranslation(int surah, int ayah, {String language = 'en'}) async {
    final map = await _loadMap(language);
    final keysToTry = [
      '$surah:$ayah',
      '$surah.$ayah',
      '${surah.toString().padLeft(3, '0')}:${ayah.toString().padLeft(3, '0')}',
    ];

    for (var k in keysToTry) {
      if (map.containsKey(k)) {
        final entry = map[k];
        if (entry is String) return entry;
        if (entry is Map) {
          if (entry.containsKey('t')) return entry['t']?.toString();
          if (entry.containsKey('text')) return entry['text']?.toString();
          if (entry.containsKey('translation')) return entry['translation']?.toString();
        }
      }
    }

    // Fallback to quran package if not found in json
    try {
      return quran.getVerseTranslation(
        surah,
        ayah,
        translation: language == 'ur'
            ? quran.Translation.urdu
            : quran.Translation.enSaheeh,
      );
    } catch (_) {
      return 'Translation not available ($surah:$ayah)';
    }
  }
}
