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
        ? 'assets/tafseer/urdo_tarjma.json'
        : (language == 'ps'
            ? 'assets/tafseer/pashto_tarjama.json'
            : 'assets/tafseer/english_translation.json');

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
        String? rawText;
        if (entry is String) rawText = entry;
        if (entry is Map) {
          if (entry.containsKey('t')) {
            rawText = entry['t']?.toString();
          } else if (entry.containsKey('text')) {
            rawText = entry['text']?.toString();
          } else if (entry.containsKey('translation')) {
            rawText = entry['translation']?.toString();
          }
        }
        if (rawText != null) {
          return _cleanHtmlText(rawText);
        }
      }
    }

    // Fallback to quran package if not found in json
    try {
      final res = quran.getVerseTranslation(
        surah,
        ayah,
        translation: language == 'ur'
            ? quran.Translation.urdu
            : quran.Translation.enSaheeh,
      );
      return _cleanHtmlText(res);
    } catch (_) {
      return 'Translation not available ($surah:$ayah)';
    }
  }

  String _cleanHtmlText(String html) {
    String text = html
        .replaceAll('&lt;p&gt;', '\n\n')
        .replaceAll('&lt;/p&gt;', '\n\n')
        .replaceAll('&lt;br&gt;', '\n')
        .replaceAll('&lt;br/&gt;', '\n')
        .replaceAll('&lt;br /&gt;', '\n')
        .replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<div[^>]*>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</div\s*>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<h[1-6][^>]*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'</h[1-6]\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');

    text = text.replaceAll(RegExp(r'<[^>]*>'), '');

    text = text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ');

    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }
}
