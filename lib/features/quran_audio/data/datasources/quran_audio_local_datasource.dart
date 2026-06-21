import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/reciter.dart';
import '../../domain/entities/download_status.dart';

/// Local data source for Quran audio operations
/// Handles local storage, downloads, and caching
abstract class QuranAudioLocalDataSource {
  /// Get the directory path for storing audio files
  Future<Directory> getAudioDirectory(Reciter reciter);

  /// Get the local file path for a Surah
  Future<File> getSurahFile(int surahNumber, Reciter reciter);

  /// Check if a Surah file exists locally
  Future<bool> hasSurahFile(int surahNumber, Reciter reciter);

  /// Save download status
  Future<void> saveDownloadStatus(int surahNumber, Reciter reciter, DownloadStatus status);

  /// Get download status
  Future<DownloadStatus?> getDownloadStatus(int surahNumber, Reciter reciter);

  /// Delete a Surah file
  Future<void> deleteSurahFile(int surahNumber, Reciter reciter);

  /// Delete all Surah files for a reciter
  Future<void> deleteAllSurahFiles(Reciter reciter);

  /// Get list of downloaded Surah numbers
  Future<List<int>> getDownloadedSurahNumbers(Reciter reciter);

  /// Get total storage size used by downloads
  Future<int> getStorageSize(Reciter reciter);

  /// Get cached reciter ID
  Future<String?> getCachedReciterId();

  /// Cache reciter ID
  Future<void> cacheReciterId(String reciterId);
}

/// Implementation of QuranAudioLocalDataSource
class QuranAudioLocalDataSourceImpl implements QuranAudioLocalDataSource {
  static const String _reciterBoxName = 'quran_audio_settings';
  static const String _reciterIdKey = 'current_reciter_id';

  String _getDownloadBoxName(Reciter reciter) => 'quran_audio_downloads_${reciter.id}';

  @override
  Future<Directory> getAudioDirectory(Reciter reciter) async {
    final baseDir = await getApplicationDocumentsDirectory();
    final reciterDir = Directory('${baseDir.path}/quran_audio/${reciter.id}');
    
    if (!await reciterDir.exists()) {
      await reciterDir.create(recursive: true);
    }
    
    return reciterDir;
  }

  @override
  Future<File> getSurahFile(int surahNumber, Reciter reciter) async {
    final dir = await getAudioDirectory(reciter);
    return File('${dir.path}/surah_${surahNumber.toString().padLeft(3, '0')}.mp3');
  }

  @override
  Future<bool> hasSurahFile(int surahNumber, Reciter reciter) async {
    try {
      final file = await getSurahFile(surahNumber, reciter);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveDownloadStatus(
    int surahNumber,
    Reciter reciter,
    DownloadStatus status,
  ) async {
    final boxName = _getDownloadBoxName(reciter);
    final box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
    
    await box.put(
      surahNumber.toString(),
      {
        'state': status.state.index,
        'progress': status.progress,
        'errorMessage': status.errorMessage,
      },
    );
  }

  @override
  Future<DownloadStatus?> getDownloadStatus(
    int surahNumber,
    Reciter reciter,
  ) async {
    try {
      final boxName = _getDownloadBoxName(reciter);
      final box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
      
      final data = box.get(surahNumber.toString());
      if (data == null) return null;

      // Check if file actually exists
      final fileExists = await hasSurahFile(surahNumber, reciter);
      
      return DownloadStatus(
        state: fileExists 
            ? DownloadState.downloaded 
            : DownloadState.values[data['state'] as int],
        progress: data['progress'] as double,
        errorMessage: data['errorMessage'] as String?,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteSurahFile(int surahNumber, Reciter reciter) async {
    try {
      final file = await getSurahFile(surahNumber, reciter);
      if (await file.exists()) {
        await file.delete();
      }
      
      // Clear download status
      final boxName = _getDownloadBoxName(reciter);
      final box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
      await box.delete(surahNumber.toString());
    } catch (e) {
      // File might not exist, ignore
    }
  }

  @override
  Future<void> deleteAllSurahFiles(Reciter reciter) async {
    try {
      final dir = await getAudioDirectory(reciter);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      
      // Clear all download statuses
      final boxName = _getDownloadBoxName(reciter);
      final box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
      await box.clear();
    } catch (e) {
      // Directory might not exist, ignore
    }
  }

  @override
  Future<List<int>> getDownloadedSurahNumbers(Reciter reciter) async {
    final List<int> downloaded = [];
    
    try {
      final dir = await getAudioDirectory(reciter);
      if (await dir.exists()) {
        await for (final entity in dir.list()) {
          if (entity is File && entity.path.endsWith('.mp3')) {
            // Extract surah number from filename
            final fileName = entity.path.split('/').last;
            final match = RegExp(r'surah_(\d+)\.mp3').firstMatch(fileName);
            if (match != null) {
              downloaded.add(int.parse(match.group(1)!));
            }
          }
        }
      }
    } catch (e) {
      // Return empty list on error
    }
    
    return downloaded;
  }

  @override
  Future<int> getStorageSize(Reciter reciter) async {
    int totalSize = 0;
    
    try {
      final dir = await getAudioDirectory(reciter);
      if (await dir.exists()) {
        await for (final entity in dir.list()) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (e) {
      // Return 0 on error
    }
    
    return totalSize;
  }

  @override
  Future<String?> getCachedReciterId() async {
    try {
      final box = await Hive.openBox<dynamic>(_reciterBoxName);
      return box.get(_reciterIdKey) as String?;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheReciterId(String reciterId) async {
    final box = await Hive.openBox<dynamic>(_reciterBoxName);
    await box.put(_reciterIdKey, reciterId);
  }
}