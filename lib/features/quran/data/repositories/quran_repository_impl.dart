import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;

import '../../domain/entities/juz.dart';
import '../../domain/entities/reading_progress.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/verse.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_data_source.dart';
import '../datasources/mushaf_database_service.dart';
import '../models/reading_progress_model.dart';
import '../models/verse_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  Map<String, dynamic>? _pashtoTarjamaCache;
  Map<String, dynamic>? _juzMetadataCache;

  Future<String> _getPashtoTranslation(int surah, int verse) async {
    if (_pashtoTarjamaCache == null) {
      try {
        final jsonString = await rootBundle.loadString(
          'assets/tafseer/pashto_tarjama.json',
        );
        _pashtoTarjamaCache = jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        _pashtoTarjamaCache = {};
      }
    }
    final key = '$surah:$verse';
    final entry = _pashtoTarjamaCache![key];
    if (entry is Map && entry.containsKey('t')) {
      return entry['t'] as String? ?? '';
    }
    return '';
  }

  @override
  Future<List<Surah>> getSurahs({String lang = 'en'}) async {
    try {
      List<Surah> surahList = [];
      for (int i = 1; i <= quran.totalSurahCount; i++) {
        surahList.add(
          Surah(
            number: i,
            nameArabic: quran.getSurahNameArabic(i),
            nameEnglish: quran.getSurahNameEnglish(i),
            totalVerses: quran.getVerseCount(i),
          ),
        );
      }
      return surahList;
    } catch (e) {
      throw Exception("Error parsing data from quran package: $e");
    }
  }

  @override
  Future<List<Juz>> getJuzList({String lang = 'en'}) async {
    try {
      if (_juzMetadataCache == null) {
        try {
          final jsonString = await rootBundle.loadString(
            'assets/quran/quran-metadata-juz.json',
          );
          _juzMetadataCache = jsonDecode(jsonString) as Map<String, dynamic>;
        } catch (e) {
          _juzMetadataCache = {};
        }
      }

      List<Juz> totalJuzList = [];
      for (int i = 1; i <= 30; i++) {
        final juzData =
            _juzMetadataCache?[i.toString()] as Map<String, dynamic>?;
        List<Verse> juzVerses = [];
        if (juzData != null && juzData.containsKey('verse_mapping')) {
          final mapping = juzData['verse_mapping'] as Map<String, dynamic>?;
          if (mapping != null) {
            for (var entry in mapping.entries) {
              final surahNum = int.tryParse(entry.key) ?? 1;
              final rangeStr = entry.value.toString();
              final parts = rangeStr.split('-');
              if (parts.length == 2) {
                final start = int.tryParse(parts[0]) ?? 1;
                final end = int.tryParse(parts[1]) ?? start;
                for (int v = start; v <= end; v++) {
                  juzVerses.add(
                    Verse(
                      id: surahNum * 1000 + v,
                      surahNumber: surahNum,
                      verseNumber: v,
                      textArabic: quran.getVerse(
                        surahNum,
                        v,
                        verseEndSymbol: true,
                      ),
                      translation: '',
                      audioUrl: quran.getAudioURLByVerse(surahNum, v),
                      juzNumber: i,
                      pageNumber: quran.getPageNumber(surahNum, v),
                    ),
                  );
                }
              }
            }
          }
        }

        totalJuzList.add(Juz(number: i, verses: juzVerses));
      }
      return totalJuzList;
    } catch (e) {
      throw Exception("Error compiling Juz list from json: $e");
    }
  }

  @override
  Future<void> saveReadingProgress(int pageNumber, {int? verseId}) async {
    final existing = await getReadingProgress();
    final progressModel = ReadingProgressModel(
      lastReadPage: pageNumber,
      lastReadVerseId: verseId ?? existing.lastReadVerseId,
      updatedAt: DateTime.now(),
    );
    await localDataSource.cacheReadingProgress(progressModel);
  }

  @override
  Future<ReadingProgress> getReadingProgress() async {
    final localProgress = await localDataSource.getLastReadingProgress();
    if (localProgress != null) {
      return localProgress;
    }
    return ReadingProgress.initial();
  }

  @override
  Future<void> toggleBookmark(Verse verse) async {
    final bookmarks = await localDataSource.getCachedBookmarks();
    final isBookmarked = bookmarks.any((b) => b.id == verse.id);

    if (isBookmarked) {
      await localDataSource.removeBookmark(verse.id);
    } else {
      await localDataSource.saveBookmark(VerseModel.fromEntity(verse));
    }
  }

  @override
  Future<List<Verse>> getBookmarkedVerses() async {
    final bookmarks = await localDataSource.getCachedBookmarks();
    return bookmarks;
  }

  @override
  Future<List<Verse>> getVerses(int page, {String lang = 'en'}) async {
    try {
      final dbLines = await MushafDatabaseService.getPageLines(page);
      if (dbLines.isNotEmpty) {
        List<Verse> verses = [];
        for (int i = 0; i < dbLines.length; i++) {
          final row = dbLines[i];

          int surahNumber = 1;
          int verseNumber = i + 1;
          for (var key in ['surah', 'surah_number', 'sura', 'sura_id']) {
            if (row.containsKey(key) && row[key] != null) {
              final val = row[key];
              if (val is num) {
                surahNumber = val.toInt();
              } else if (val is String) {
                surahNumber = int.tryParse(val) ?? 1;
              }
              break;
            }
          }
          for (var key in [
            'ayah',
            'ayah_number',
            'aya',
            'verse',
            'verse_number',
          ]) {
            if (row.containsKey(key) && row[key] != null) {
              final val = row[key];
              if (val is num) {
                verseNumber = val.toInt();
              } else if (val is String) {
                verseNumber = int.tryParse(val) ?? 1;
              }
              break;
            }
          }

          String text = '';
          for (var key in [
            'text',
            'content',
            'line_text',
            'arabic',
            'verse_text',
            'ayah_text',
            'line',
          ]) {
            if (row.containsKey(key) && row[key] != null) {
              text = row[key].toString();
              break;
            }
          }
          if (text.isEmpty) {
            text = row.values
                .where((v) => v is String && v.isNotEmpty)
                .join(' ');
          }
          if (text.isEmpty && surahNumber > 0 && verseNumber > 0) {
            text = quran.getVerse(
              surahNumber,
              verseNumber,
              verseEndSymbol: true,
            );
          }

          final String translationText = lang == 'ps'
              ? await _getPashtoTranslation(surahNumber, verseNumber)
              : quran.getVerseTranslation(
                  surahNumber,
                  verseNumber,
                  translation: lang == 'ur'
                      ? quran.Translation.urdu
                      : quran.Translation.enSaheeh,
                );

          verses.add(
            Verse(
              id: page * 100 + i,
              surahNumber: surahNumber,
              verseNumber: verseNumber,
              textArabic: text,
              translation: translationText,
              audioUrl: quran.getAudioURLByVerse(surahNumber, verseNumber),
              juzNumber: quran.getJuzNumber(surahNumber, verseNumber),
              pageNumber: page,
            ),
          );
        }
        if (verses.isNotEmpty) {
          return verses;
        }
      }

      // Fallback to quran package page data
      final List<dynamic> rawPageData = quran.getPageData(page);
      List<Verse> verses = [];

      for (var element in rawPageData) {
        final Map<String, dynamic> data = element as Map<String, dynamic>;
        final int surah = data['surah'] as int;
        final int start = data['start'] as int;
        final int end = data['end'] as int;

        for (int v = start; v <= end; v++) {
          final String translationText = lang == 'ps'
              ? await _getPashtoTranslation(surah, v)
              : quran.getVerseTranslation(
                  surah,
                  v,
                  translation: lang == 'ur'
                      ? quran.Translation.urdu
                      : quran.Translation.enSaheeh,
                );

          verses.add(
            Verse(
              id: surah * 1000 + v,
              surahNumber: surah,
              verseNumber: v,
              textArabic: quran.getVerse(surah, v, verseEndSymbol: true),
              translation: translationText,
              audioUrl: quran.getAudioURLByVerse(surah, v),
              juzNumber: quran.getJuzNumber(surah, v),
              pageNumber: quran.getPageNumber(surah, v),
            ),
          );
        }
      }
      return verses;
    } catch (e) {
      throw Exception("Error fetching verses for page $page: $e");
    }
  }
}
