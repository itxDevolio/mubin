import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quran/quran.dart' as quran;

class QuranLine {
  final int pageNumber;
  final int lineNumber;
  final String lineType; // 'ayah', 'surah_name', 'basmallah'
  final bool isCentered;
  final int? surahNumber;
  final String text;
  final List<Map<String, dynamic>> words;

  QuranLine({
    required this.pageNumber,
    required this.lineNumber,
    required this.lineType,
    required this.isCentered,
    this.surahNumber,
    required this.text,
    required this.words,
  });
}

class QuranDbService {
  static final QuranDbService _instance = QuranDbService._internal();
  factory QuranDbService() => _instance;
  QuranDbService._internal();

  Database? _pagesDb;
  Database? _wordsDb;
  final Map<int, List<QuranLine>> _pageLinesCache = {};
  static final Map<int, int> _surahPageCache = {};

  static int getStartingPageForSurahSync(int surahNumber) {
    return _surahPageCache[surahNumber] ?? 1;
  }

  Future<void> initDatabases() async {
    if (_pagesDb != null && _wordsDb != null) return;

    final databasesPath = await getDatabasesPath();
    await Directory(databasesPath).create(recursive: true);

    // 1. Copy taj-indopak-16-lines.db
    final pagesPath = join(databasesPath, 'taj-indopak-16-lines.db');
    if (!await File(pagesPath).exists()) {
      ByteData data = await rootBundle.load('assets/quran/taj-indopak-16-lines.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(pagesPath).writeAsBytes(bytes);
    }

    // 2. Copy indopak-nastaleeq.db
    final wordsPath = join(databasesPath, 'indopak-nastaleeq.db');
    if (!await File(wordsPath).exists()) {
      ByteData data = await rootBundle.load('assets/quran/indopak-nastaleeq.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(wordsPath).writeAsBytes(bytes);
    }

    _pagesDb = await openDatabase(pagesPath);
    _wordsDb = await openDatabase(wordsPath);

    try {
      final surahPages = await _pagesDb!.rawQuery(
        'SELECT surah_number, MIN(page_number) as start_page FROM pages WHERE surah_number > 0 GROUP BY surah_number'
      );
      for (var row in surahPages) {
        final sNum = int.tryParse(row['surah_number'].toString()) ?? 0;
        final pNum = int.tryParse(row['start_page'].toString()) ?? 1;
        if (sNum > 0) {
          _surahPageCache[sNum] = pNum;
        }
      }
    } catch (_) {}
  }

  Future<Map<String, dynamic>?> getWordInfo(int wordId) async {
    await initDatabases();
    if (_wordsDb == null) return null;
    try {
      final results = await _wordsDb!.query(
        'words',
        where: 'id = ?',
        whereArgs: [wordId],
      );
      if (results.isNotEmpty) {
        return results.first;
      }
    } catch (e) {
      print('Error getting word info: $e');
    }
    return null;
  }

  Future<Map<String, int>?> getLineSurahAndAyah(int pageNumber, int lineNumber) async {
    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) return null;

    try {
      final pageRow = await _pagesDb!.query(
        'pages',
        where: 'page_number = ? AND line_number = ?',
        whereArgs: [pageNumber, lineNumber],
      );
      if (pageRow.isEmpty) return null;

      final row = pageRow.first;
      final lineType = row['line_type'] as String?;
      if (lineType == 'surah_name') {
        final sNum = row['surah_number'];
        return {'surah': sNum != null ? int.parse(sNum.toString()) : 1, 'ayah': 1};
      }

      final firstWordId = row['first_word_id'];
      if (firstWordId != null && firstWordId.toString().isNotEmpty) {
        final wId = int.parse(firstWordId.toString());
        final wordInfo = await getWordInfo(wId);
        if (wordInfo != null) {
          final surah = wordInfo['surah'] ?? wordInfo['surah_id'] ?? 1;
          final ayah = wordInfo['ayah'] ?? wordInfo['ayah_id'] ?? 1;
          return {'surah': int.parse(surah.toString()), 'ayah': int.parse(ayah.toString())};
        }
      }
    } catch (e) {
      print('Error getting line surah and ayah: $e');
    }
    return null;
  }

  Future<List<Map<String, int>>> getLineVerses(int pageNumber, int lineNumber) async {
    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) return [];

    try {
      final pageRow = await _pagesDb!.query(
        'pages',
        where: 'page_number = ? AND line_number = ?',
        whereArgs: [pageNumber, lineNumber],
      );
      if (pageRow.isEmpty) return [];

      final row = pageRow.first;
      final lineType = row['line_type'] as String?;
      if (lineType == 'surah_name' || lineType == 'basmallah') {
        final sNum = row['surah_number'];
        return [
          {'surah': sNum != null ? int.parse(sNum.toString()) : 1, 'ayah': 1}
        ];
      }

      final firstWordId = row['first_word_id'];
      final lastWordId = row['last_word_id'];
      if (firstWordId != null && lastWordId != null && firstWordId.toString().isNotEmpty && lastWordId.toString().isNotEmpty) {
        final startId = int.parse(firstWordId.toString());
        final endId = int.parse(lastWordId.toString());

        final wordRows = await _wordsDb!.rawQuery(
          'SELECT DISTINCT surah, ayah FROM words WHERE id BETWEEN ? AND ?',
          [startId, endId],
        );
        return wordRows.map((w) => {
          'surah': int.parse((w['surah'] ?? 1).toString()),
          'ayah': int.parse((w['ayah'] ?? 1).toString()),
        }).toList();
      }
    } catch (e) {
      print('Error getting line verses: $e');
    }
    return [];
  }

  Future<Set<int>> getLinesForVerse(int pageNumber, int surah, int ayah) async {
    await initDatabases();
    Set<int> lines = {};
    for (int l = 1; l <= 16; l++) {
      final verses = await getLineVerses(pageNumber, l);
      for (var v in verses) {
        if (v['surah'] == surah && v['ayah'] == ayah) {
          lines.add(l);
          break;
        }
      }
    }
    return lines;
  }

  Future<bool> doesAyahSpanToNextPage(int currentPage, int surah, int ayah) async {
    if (currentPage >= 548) return false;
    final nextLines = await getLinesForVerse(currentPage + 1, surah, ayah);
    return nextLines.isNotEmpty;
  }

  Future<String> getVerseText(int surah, int ayah) async {
    await initDatabases();
    if (_wordsDb == null) return '';
    try {
      final wordRows = await _wordsDb!.rawQuery(
        'SELECT text FROM words WHERE surah = ? AND ayah = ? ORDER BY id ASC',
        [surah, ayah],
      );
      return wordRows.map((w) => w['text']?.toString() ?? '').join(' ');
    } catch (_) {
      return '';
    }
  }

  Future<List<Map<String, dynamic>>> getLineWords(int pageNumber, int lineNumber) async {
    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) return [];

    try {
      final pageRow = await _pagesDb!.query(
        'pages',
        where: 'page_number = ? AND line_number = ?',
        whereArgs: [pageNumber, lineNumber],
      );
      if (pageRow.isEmpty) return [];

      final row = pageRow.first;
      final lineType = row['line_type'] as String?;
      if (lineType == 'surah_name' || lineType == 'basmallah') {
        return [];
      }

      final firstWordId = row['first_word_id'];
      final lastWordId = row['last_word_id'];
      if (firstWordId != null && lastWordId != null && firstWordId.toString().isNotEmpty && lastWordId.toString().isNotEmpty) {
        final startId = int.parse(firstWordId.toString());
        final endId = int.parse(lastWordId.toString());

        final wordRows = await _wordsDb!.rawQuery(
          'SELECT * FROM words WHERE id BETWEEN ? AND ? ORDER BY id ASC',
          [startId, endId],
        );
        return wordRows;
      }
    } catch (e) {
      print('Error getting line words: $e');
    }
    return [];
  }

  Future<List<QuranLine>> getPageLines(int pageNumber) async {
    if (_pageLinesCache.containsKey(pageNumber)) {
      return _pageLinesCache[pageNumber]!;
    }

    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) {
      throw Exception('Databases not initialized');
    }

    final rawLines = await _pagesDb!.query(
      'pages',
      where: 'page_number = ?',
      whereArgs: [pageNumber],
      orderBy: 'line_number ASC',
    );

    List<QuranLine> lines = [];

    for (var row in rawLines) {
      final lineNumber = row['line_number'] as int;
      final lineType = row['line_type'] as String;
      final isCentered = (row['is_centered'] as int?) == 1;
      final surahNumber = row['surah_number'] != null && row['surah_number'].toString().isNotEmpty
          ? int.tryParse(row['surah_number'].toString())
          : null;

      String text = '';
      List<Map<String, dynamic>> words = [];

      if (lineType == 'surah_name') {
        if (surahNumber != null) {
          text = 'سُورَةُ ${quran.getSurahNameArabic(surahNumber)}';
        } else {
          text = 'سُورَة';
        }
      } else if (lineType == 'basmallah') {
        text = 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِیْمِ';
      } else if (lineType == 'ayah') {
        final firstWordId = row['first_word_id'];
        final lastWordId = row['last_word_id'];
        if (firstWordId != null && lastWordId != null && firstWordId.toString().isNotEmpty && lastWordId.toString().isNotEmpty) {
          final startId = int.parse(firstWordId.toString());
          final endId = int.parse(lastWordId.toString());

          final wordRows = await _wordsDb!.rawQuery(
            'SELECT * FROM words WHERE id BETWEEN ? AND ? ORDER BY id ASC',
            [startId, endId],
          );
          words = wordRows;
          text = wordRows.map((w) => w['text']?.toString() ?? '').join(' ');
        }
      }

      lines.add(QuranLine(
        pageNumber: pageNumber,
        lineNumber: lineNumber,
        lineType: lineType,
        isCentered: isCentered || lineType == 'surah_name' || lineType == 'basmallah',
        surahNumber: surahNumber,
        text: text,
        words: words,
      ));
    }

    _pageLinesCache[pageNumber] = lines;
    return lines;
  }

  Future<int> getStartingPageForSurah(int surahNumber) async {
    if (_surahPageCache.containsKey(surahNumber)) {
      return _surahPageCache[surahNumber]!;
    }
    await initDatabases();
    if (_pagesDb == null) return 1;
    try {
      final result = await _pagesDb!.query(
        'pages',
        columns: ['page_number'],
        where: 'surah_number = ? AND line_type = ?',
        whereArgs: [surahNumber, 'surah_name'],
        orderBy: 'page_number ASC',
        limit: 1,
      );
      if (result.isNotEmpty) {
        return int.parse(result.first['page_number'].toString());
      }

      if (_wordsDb != null) {
        final wordRes = await _wordsDb!.query(
          'words',
          columns: ['id'],
          where: 'surah = ? AND ayah = 1',
          whereArgs: [surahNumber],
          limit: 1,
        );
        if (wordRes.isNotEmpty) {
          final wordId = wordRes.first['id'];
          final pageRes = await _pagesDb!.rawQuery(
            'SELECT page_number FROM pages WHERE first_word_id <= ? AND last_word_id >= ? ORDER BY page_number ASC LIMIT 1',
            [wordId, wordId],
          );
          if (pageRes.isNotEmpty) {
            return int.parse(pageRes.first['page_number'].toString());
          }
        }
      }
    } catch (_) {}
    return 1;
  }

  Future<int> getStartingPageForJuz(int juzNumber) async {
    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) return 1;
    try {
      final Map<int, List<int>> juzData = Map<int, List<int>>.from(
        quran.getSurahAndVersesFromJuz(juzNumber),
      );
      if (juzData.isNotEmpty) {
        int startingSurah = juzData.keys.first;
        int startingVerse = juzData[startingSurah]!.first;

        final wordRes = await _wordsDb!.query(
          'words',
          columns: ['id'],
          where: 'surah = ? AND ayah = ?',
          whereArgs: [startingSurah, startingVerse],
          limit: 1,
        );
        if (wordRes.isNotEmpty) {
          final wordId = wordRes.first['id'];
          final pageRes = await _pagesDb!.rawQuery(
            'SELECT page_number FROM pages WHERE first_word_id <= ? AND last_word_id >= ? ORDER BY page_number ASC LIMIT 1',
            [wordId, wordId],
          );
          if (pageRes.isNotEmpty) {
            return int.parse(pageRes.first['page_number'].toString());
          }
        }
      }
    } catch (_) {}

    const juzPages = [
      1, 20, 38, 56, 74, 92, 110, 128, 146, 164,
      182, 200, 218, 236, 254, 272, 290, 308, 326, 344,
      362, 380, 398, 416, 434, 452, 470, 488, 506, 524
    ];
    if (juzNumber >= 1 && juzNumber <= 30) {
      return juzPages[juzNumber - 1];
    }
    return 1;
  }

  Future<int> getPageForVerse(int surah, int ayah) async {
    await initDatabases();
    if (_pagesDb == null || _wordsDb == null) return 1;
    try {
      final wordRes = await _wordsDb!.query(
        'words',
        columns: ['id'],
        where: 'surah = ? AND ayah = ?',
        whereArgs: [surah, ayah],
        limit: 1,
      );
      if (wordRes.isNotEmpty) {
        final wordId = wordRes.first['id'];
        final pageRes = await _pagesDb!.rawQuery(
          'SELECT page_number FROM pages WHERE first_word_id <= ? AND last_word_id >= ? ORDER BY page_number ASC LIMIT 1',
          [wordId, wordId],
        );
        if (pageRes.isNotEmpty) {
          return int.parse(pageRes.first['page_number'].toString());
        }
      }
    } catch (_) {}
    return 1;
  }
}
