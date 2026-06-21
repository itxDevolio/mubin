import '../entities/reciter.dart';
import '../entities/download_status.dart';

/// Repository interface for Quran audio operations
/// All audio data is sourced from the quran package
abstract class QuranAudioRepository {
  /// Get the current selected reciter
  Reciter getCurrentReciter();

  /// Set the current reciter
  Future<void> setCurrentReciter(Reciter reciter);

  /// Get audio URL for a specific Surah by reciter
  String getSurahAudioUrl(int surahNumber, Reciter reciter);

  /// Get audio URL for a specific verse by reciter
  String getVerseAudioUrl(int surahNumber, int verseNumber, Reciter reciter);

  /// Download a Surah for offline playback
  Future<void> downloadSurah(int surahNumber, Reciter reciter, {
    void Function(double progress)? onProgress,
  });

  /// Cancel an ongoing download
  Future<void> cancelDownload(int surahNumber);

  /// Delete a downloaded Surah
  Future<void> deleteDownloadedSurah(int surahNumber, Reciter reciter);

  /// Delete all downloaded Surahs for a reciter
  Future<void> deleteAllDownloads(Reciter reciter);

  /// Check if a Surah is downloaded
  Future<bool> isSurahDownloaded(int surahNumber, Reciter reciter);

  /// Get download status for a Surah
  Future<DownloadStatus> getDownloadStatus(int surahNumber, Reciter reciter);

  /// Get list of all downloaded Surah numbers for a reciter
  Future<List<int>> getDownloadedSurahs(Reciter reciter);

  /// Get total storage size used by downloads in bytes
  Future<int> getDownloadStorageSize(Reciter reciter);

  /// Get local file path for a downloaded Surah
  Future<String?> getLocalSurahPath(int surahNumber, Reciter reciter);

  /// Check if local file exists for a Surah
  Future<bool> hasLocalSurahFile(int surahNumber, Reciter reciter);
}