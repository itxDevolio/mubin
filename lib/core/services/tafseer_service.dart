import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TafseerService {
  final Map<String, Map<String, dynamic>> _cache = {};

  Future<Map<String, dynamic>> _loadTafseerMap(String language) async {
    if (_cache.containsKey(language)) {
      return _cache[language]!;
    }

    final String assetPath = language == 'ur'
        ? 'assets/tafseer/tazkiru-quran-ur.json'
        : 'assets/tafseer/tazkirul-quran-en.json';

    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> data = jsonDecode(jsonString);
      _cache[language] = data;
      return data;
    } catch (e) {
      return {};
    }
  }

  Future<String?> getTafseer({
    required int surahNumber,
    required int verseNumber,
    required String language,
  }) async {
    final map = await _loadTafseerMap(language);
    final key = '$surahNumber:$verseNumber';
    dynamic entry = map[key];
    if (entry == null) return null;

    if (entry is String) {
      entry = map[entry];
    }

    final String? rawText = entry is Map ? entry['text'] as String? : null;
    if (rawText == null || rawText.isEmpty) return null;

    return _cleanHtmlText(rawText);
  }

  String _cleanHtmlText(String html) {
    String text = html
        .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'</div\s*>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</h[1-6]\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');

    // Remove remaining HTML tags
    text = text.replaceAll(RegExp(r'<[^>]*>'), '');

    // Unescape common HTML entities
    text = text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ');

    // Normalize multiple newlines and trim
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();

    return text;
  }
}

final tafseerServiceProvider = Provider<TafseerService>((ref) {
  return TafseerService();
});

final verseTafseerProvider =
    FutureProvider.family<
      String?,
      ({int surahNumber, int verseNumber, String language})
    >((ref, arg) async {
      final service = ref.watch(tafseerServiceProvider);
      return service.getTafseer(
        surahNumber: arg.surahNumber,
        verseNumber: arg.verseNumber,
        language: arg.language,
      );
    });
