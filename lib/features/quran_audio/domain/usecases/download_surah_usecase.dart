  import '../entities/reciter.dart';
import '../repositories/quran_audio_repository.dart';

/// Use case to download a Surah for offline playback
class DownloadSurahUseCase {
  final QuranAudioRepository repository;

  DownloadSurahUseCase(this.repository);

  /// Execute the download
  /// [surahNumber] - The Surah number to download
  /// [reciter] - Optional reciter, uses current if not provided
  /// [onProgress] - Callback for download progress (0.0 to 1.0)
  Future<void> call(
    int surahNumber, {
    Reciter? reciter,
    void Function(double progress)? onProgress,
  }) {
    final currentReciter = reciter ?? repository.getCurrentReciter();
    return repository.downloadSurah(
      surahNumber,
      currentReciter,
      onProgress: onProgress,
    );
  }
}