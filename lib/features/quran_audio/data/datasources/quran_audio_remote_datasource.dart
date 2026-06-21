import 'package:dio/dio.dart';
import 'package:quran/quran.dart' as quran;
import '../../domain/entities/reciter.dart';

/// Remote data source for Quran audio operations
/// Handles streaming URLs and online operations
abstract class QuranAudioRemoteDataSource {
  /// Get audio URL for a Surah from the reciter's server
  String getSurahAudioUrl(int surahNumber, Reciter reciter);

  /// Get audio URL for a specific verse
  String getVerseAudioUrl(int surahNumber, int verseNumber, Reciter reciter);

  /// Download a file from URL to save path with progress tracking
  Future<void> downloadFile({
    required String url,
    required String savePath,
    required void Function(double progress) onProgress,
    required CancelToken cancelToken,
  });

  /// Check if a URL is accessible
  Future<bool> isUrlAccessible(String url);
}

/// Implementation of QuranAudioRemoteDataSource
class QuranAudioRemoteDataSourceImpl implements QuranAudioRemoteDataSource {
  final Dio _dio;

  QuranAudioRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  String getSurahAudioUrl(int surahNumber, Reciter reciter) {
    // Format surah number with leading zeros (001, 002, ... 114)
    final surahStr = surahNumber.toString().padLeft(3, '0');
    return '${reciter.audioUrlPrefix}$surahStr.mp3';
  }

  @override
  String getVerseAudioUrl(int surahNumber, int verseNumber, Reciter reciter) {
    // For verse-by-verse audio, we use the quran package's built-in method
    // as it provides individual verse audio URLs
    try {
      return quran.getAudioURLByVerse(surahNumber, verseNumber);
    } catch (e) {
      // Fallback to surah audio URL if verse audio not available
      return getSurahAudioUrl(surahNumber, reciter);
    }
  }

  @override
  Future<void> downloadFile({
    required String url,
    required String savePath,
    required void Function(double progress) onProgress,
    required CancelToken cancelToken,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(progress);
          }
        },
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        // Download was cancelled, rethrow to handle
        rethrow;
      }
      throw Exception('Download failed: ${e.message}');
    } catch (e) {
      throw Exception('Download failed: $e');
    }
  }

  @override
  Future<bool> isUrlAccessible(String url) async {
    try {
      final response = await _dio.head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}