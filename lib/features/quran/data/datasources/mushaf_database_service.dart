import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MushafDatabaseService {
  static Database? _tajDb;
  static Database? _nastaleeqDb;

  static Future<Database> getTajDatabase() async {
    if (_tajDb != null) return _tajDb!;
    _tajDb = await _initDatabase('assets/quran/taj-indopak-16-lines.db');
    return _tajDb!;
  }

  static Future<Database> getNastaleeqDatabase() async {
    if (_nastaleeqDb != null) return _nastaleeqDb!;
    _nastaleeqDb = await _initDatabase('assets/quran/indopak-nastaleeq.db');
    return _nastaleeqDb!;
  }

  static Future<Database> _initDatabase(String assetPath) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, basename(assetPath));

    bool exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(assetPath);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    final db = await openDatabase(path);
    
    if (kDebugMode) {
      try {
        final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
        debugPrint('=== DATABASE SCHEMA FOR $assetPath ===');
        for (var t in tables) {
          final tableName = t['name'] as String;
          final cols = await db.rawQuery("PRAGMA table_info($tableName);");
          debugPrint('Table: $tableName, Columns: $cols');
          final sample = await db.query(tableName, limit: 2);
          debugPrint('Sample data in $tableName: $sample');
        }
      } catch (e) {
        debugPrint('Error inspecting $assetPath: $e');
      }
    }

    return db;
  }

  // Fetch 16 lines for a given page number from taj-indopak-16-lines.db or indopak-nastaleeq.db
  static Future<List<Map<String, dynamic>>> getPageLines(int pageNumber) async {
    try {
      // First try taj database
      final db = await getTajDatabase();
      final lines = await _queryPageFromDb(db, pageNumber);
      if (lines.isNotEmpty) return lines;

      // Then try nastaleeq database
      final db2 = await getNastaleeqDatabase();
      final lines2 = await _queryPageFromDb(db2, pageNumber);
      if (lines2.isNotEmpty) return lines2;
    } catch (e) {
      debugPrint('Error getting page lines for page $pageNumber: $e');
    }
    return [];
  }

  static Future<List<Map<String, dynamic>>> _queryPageFromDb(Database db, int pageNumber) async {
    try {
      final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
      for (var t in tables) {
        final tableName = t['name'] as String;
        if (tableName == 'sqlite_sequence') continue;

        final cols = await db.rawQuery("PRAGMA table_info($tableName);");
        final colNames = cols.map((c) => c['name'] as String).toSet();

        String? pageCol;
        for (final c in ['page', 'page_number', 'page_id', 'pg', 'page_no']) {
          if (colNames.contains(c)) {
            pageCol = c;
            break;
          }
        }

        if (pageCol != null) {
          String? lineCol;
          for (final c in ['line', 'line_number', 'row_number', 'idx', 'line_no']) {
            if (colNames.contains(c)) {
              lineCol = c;
              break;
            }
          }

          final results = await db.query(
            tableName,
            where: '$pageCol = ?',
            whereArgs: [pageNumber],
            orderBy: lineCol != null ? '$lineCol ASC' : null,
          );

          if (results.isNotEmpty) {
            return results;
          }
        }
      }
    } catch (e) {
      debugPrint('Error querying db: $e');
    }
    return [];
  }
}
