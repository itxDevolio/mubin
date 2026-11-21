import 'dart:convert';
import 'package:flutter/services.dart';

class LineMarker {
  final int lineNumber;
  final String type; // 'ruku' or 'rub'
  final String text;
  
  const LineMarker({
    required this.lineNumber,
    required this.type,
    required this.text,
  });
}

class QuranMetadataService {
  static final QuranMetadataService _instance = QuranMetadataService._internal();
  factory QuranMetadataService() => _instance;
  QuranMetadataService._internal();

  Map<String, dynamic>? _rukuMap;
  Map<String, dynamic>? _rubMap;

  Future<void> init() async {
    if (_rukuMap != null) return;
    try {
      final rukuStr = await rootBundle.loadString('assets/quran/quran-metadata-ruku.json');
      _rukuMap = json.decode(rukuStr);
    } catch (_) {
      _rukuMap = {};
    }
    try {
      final rubStr = await rootBundle.loadString('assets/quran/quran-metadata-rub.json');
      _rubMap = json.decode(rubStr);
    } catch (_) {
      _rubMap = {};
    }
  }

  // Exact 16-line IndoPak Mushaf 548-page Juz starting page mapping
  int getJuzForIndoPakPage(int pageNumber) {
    if (pageNumber < 20) return 1;
    if (pageNumber < 38) return 2;
    if (pageNumber < 56) return 3;
    if (pageNumber < 74) return 4;
    if (pageNumber < 92) return 5;
    if (pageNumber < 110) return 6;
    if (pageNumber < 128) return 7;
    if (pageNumber < 146) return 8;
    if (pageNumber < 164) return 9;
    if (pageNumber < 182) return 10;
    if (pageNumber < 200) return 11;
    if (pageNumber < 218) return 12;
    if (pageNumber < 236) return 13;
    if (pageNumber < 254) return 14;
    if (pageNumber < 272) return 15;
    if (pageNumber < 290) return 16;
    if (pageNumber < 308) return 17;
    if (pageNumber < 326) return 18;
    if (pageNumber < 344) return 19;
    if (pageNumber < 362) return 20;
    if (pageNumber < 380) return 21;
    if (pageNumber < 398) return 22;
    if (pageNumber < 416) return 23;
    if (pageNumber < 434) return 24;
    if (pageNumber < 452) return 25;
    if (pageNumber < 470) return 26;
    if (pageNumber < 488) return 27;
    if (pageNumber < 506) return 28;
    if (pageNumber < 524) return 29;
    return 30;
  }

  Future<Map<int, List<LineMarker>>> getLineMarkersForPage(
    int pageNumber,
    Future<List<Map<String, int>>> Function(int page, int line) getLineVerses,
  ) async {
    await init();
    Map<int, List<LineMarker>> lineMarkers = {};

    Map<String, String> rukuEndVerses = {};
    Map<String, String> rubStartVerses = {};

    try {
      if (_rukuMap != null) {
        for (var entry in _rukuMap!.entries) {
          final val = entry.value;
          final lastVerseKey = val['last_verse_key']?.toString();
          final rukuNum = val['ruku_number']?.toString() ?? '';
          if (lastVerseKey != null) {
            rukuEndVerses[lastVerseKey] = rukuNum;
          }
        }
      }

      if (_rubMap != null) {
        for (var entry in _rubMap!.entries) {
          final val = entry.value;
          final firstVerseKey = val['first_verse_key']?.toString();
          final rubNum = int.tryParse(val['rub_number'].toString()) ?? 1;
          if (firstVerseKey != null) {
            String marker = 'ربع';
            if (rubNum % 4 == 2) {
              marker = 'نصف';
            } else if (rubNum % 4 == 3) {
              marker = 'ثلاثة';
            } else if (rubNum % 4 == 0) {
              marker = 'حزب';
            }
            rubStartVerses[firstVerseKey] = marker;
          }
        }
      }

      int? lastRukuLine;
      String? lastRukuText;

      int? firstRubLine;
      String? firstRubText;

      for (int l = 1; l <= 16; l++) {
        final verses = await getLineVerses(pageNumber, l);
        for (var v in verses) {
          final surah = v['surah'];
          final ayah = v['ayah'];
          if (surah != null && ayah != null) {
            final key = '$surah:$ayah';

            if (rukuEndVerses.containsKey(key)) {
              lastRukuLine = l;
              lastRukuText = rukuEndVerses[key]!;
            }

            if (rubStartVerses.containsKey(key)) {
              firstRubLine ??= l;
              firstRubText ??= rubStartVerses[key]!;
            }
          }
        }
      }

      if (lastRukuLine != null && lastRukuText != null) {
        lineMarkers.putIfAbsent(lastRukuLine, () => []).add(
          LineMarker(lineNumber: lastRukuLine, type: 'ruku', text: lastRukuText)
        );
      }

      if (firstRubLine != null && firstRubText != null) {
        lineMarkers.putIfAbsent(firstRubLine, () => []).add(
          LineMarker(lineNumber: firstRubLine, type: 'rub', text: firstRubText)
        );
      }
    } catch (_) {}

    return lineMarkers;
  }
}
