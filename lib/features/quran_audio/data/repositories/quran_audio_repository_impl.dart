import 'package:dio/dio.dart';
import '../datasources/quran_audio_local_datasource.dart';
import '../datasources/quran_audio_remote_datasource.dart';
import '../../domain/entities/reciter.dart';
import '../../domain/entities/download_status.dart';
import '../../domain/repositories/quran_audio_repository.dart';

/// Implementation of QuranAudioRepository
/// Combines local and remote data sources for complete audio functionality
class QuranAudioRepositoryImpl implements QuranAudioRepository {
  final QuranAudioLocalDataSource localDataSource;
  final QuranAudioRemoteDataSource remoteDataSource;

  Reciter? _currentReciter;
  final Map<int, CancelToken> _activeDownloads = {};

  QuranAudioRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Reciter getCurrentReciter() {
    if (_currentReciter != null) {
      return _currentReciter!;
    }
    
    // Try to load from cache
    final cachedIdFuture = localDataSource.getCachedReciterId();
    if (cachedIdFuture != null) {
      // Note: This is a simplified sync fallback
      final reciter = Reciters.defaultReciter;
      if (reciter != null) {
        _currentReciter = reciter;
        return reciter;
      }
    }
    
    // Return default reciter
    _currentReciter = Reciters.defaultReciter;
    return _currentReciter!;
  }

  @override
  Future<void> setCurrentReciter(Reciter reciter) async {
    _currentReciter = reciter;
    await localDataSource.cacheReciterId(reciter.id);
  }

  @override
  String getSurahAudioUrl(int surahNumber, Reciter reciter) {
    return remoteDataSource.getSurahAudioUrl(surahNumber, reciter);
  }

  @override
  String getVerseAudioUrl(int surahNumber, int verseNumber, Reciter reciter) {
    return remoteDataSource.getVerseAudioUrl(surahNumber, verseNumber, reciter);
  }

  @override
  Future<void> downloadSurah(
    int surahNumber,
    Reciter reciter, {
    void Function(double progress)? onProgress,
  }) async {
    // Check if already downloaded
    if (await isSurahDownloaded(surahNumber, reciter)) {
      return;
    }

    // Check if already downloading
    if (_activeDownloads.containsKey(surahNumber)) {
      return;
    }

    // Create cancel token for this download
    final cancelToken = CancelToken();
    _activeDownloads[surahNumber] = cancelToken;

    try {
      // Get audio URL
      final url = getSurahAudioUrl(surahNumber, reciter);
      
      // Get save path
      final file = await localDataSource.getSurahFile(surahNumber, reciter);
      
      // Save download status as downloading
      await localDataSource.saveDownloadStatus(
        surahNumber,
        reciter,
        const DownloadStatus(state: DownloadState.downloading, progress: 0.0),
      );

      // Download file
      await remoteDataSource.downloadFile(
        url: url,
        savePath: file.path,
        onProgress: (progress) {
          onProgress?.call(progress);
          localDataSource.saveDownloadStatus(
            surahNumber,
            reciter,
            DownloadStatus(state: DownloadState.downloading, progress: progress),
          );
        },
        cancelToken: cancelToken,
      );

      // Verify download
      if (await file.exists()) {
        await localDataSource.saveDownloadStatus(
          surahNumber,
          reciter,
          const DownloadStatus(state: DownloadState.downloaded, progress: 1.0),
        );
      } else {
        throw Exception('Downloaded file not found');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        // Download was cancelled
        await localDataSource.saveDownloadStatus(
          surahNumber,
          reciter,
          const DownloadStatus(state: DownloadState.notDownloaded, progress: 0.0),
        );
        return;
      }
      
      await localDataSource.saveDownloadStatus(
        surahNumber,
        reciter,
        DownloadStatus(
          state: DownloadState.failed,
          progress: 0.0,
          errorMessage: e.message,
        ),
      );
      rethrow;
    } catch (e) {
      await localDataSource.saveDownloadStatus(
        surahNumber,
        reciter,
        DownloadStatus(
          state: DownloadState.failed,
          progress: 0.0,
          errorMessage: e.toString(),
        ),
      );
      rethrow;
    } finally {
      _activeDownloads.remove(surahNumber);
    }
  }

  @override
  Future<void> cancelDownload(int surahNumber) async {
    final cancelToken = _activeDownloads[surahNumber];
    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel();
      _activeDownloads.remove(surahNumber);
    }
  }

  @override
  Future<void> deleteDownloadedSurah(int surahNumber, Reciter reciter) async {
    await localDataSource.deleteSurahFile(surahNumber, reciter);
  }

  @override
  Future<void> deleteAllDownloads(Reciter reciter) async {
    // Cancel all active downloads first
    for (final entry in _activeDownloads.entries) {
      if (!entry.value.isCancelled) {
        entry.value.cancel();
      }
    }
    _activeDownloads.clear();

    await localDataSource.deleteAllSurahFiles(reciter);
  }

  @override
  Future<bool> isSurahDownloaded(int surahNumber, Reciter reciter) async {
    return await localDataSource.hasSurahFile(surahNumber, reciter);
  }

  @override
  Future<DownloadStatus> getDownloadStatus(int surahNumber, Reciter reciter) async {
    // Check if currently downloading
    if (_activeDownloads.containsKey(surahNumber)) {
      final status = await localDataSource.getDownloadStatus(surahNumber, reciter);
      if (status != null) {
        return status.copyWith(state: DownloadState.downloading);
      }
    }

    // Check if file exists
    final fileExists = await localDataSource.hasSurahFile(surahNumber, reciter);
    if (fileExists) {
      return const DownloadStatus(state: DownloadState.downloaded, progress: 1.0);
    }

    // Get saved status
    final status = await localDataSource.getDownloadStatus(surahNumber, reciter);
    return status ?? const DownloadStatus(state: DownloadState.notDownloaded);
  }

  @override
  Future<List<int>> getDownloadedSurahs(Reciter reciter) async {
    return await localDataSource.getDownloadedSurahNumbers(reciter);
  }

  @override
  Future<int> getDownloadStorageSize(Reciter reciter) async {
    return await localDataSource.getStorageSize(reciter);
  }

  @override
  Future<String?> getLocalSurahPath(int surahNumber, Reciter reciter) async {
    if (await isSurahDownloaded(surahNumber, reciter)) {
      final file = await localDataSource.getSurahFile(surahNumber, reciter);
      return file.path;
    }
    return null;
  }

  @override
  Future<bool> hasLocalSurahFile(int surahNumber, Reciter reciter) async {
    return await isSurahDownloaded(surahNumber, reciter);
  }
}