import '../entities/reciter.dart';
import '../repositories/quran_audio_repository.dart';

/// Use case to get audio URL for a Surah
class GetSurahAudioUrlUseCase {
  final QuranAudioRepository repository;

  GetSurahAudioUrlUseCase(this.repository);

  /// Execute the use case
  /// Returns the audio URL for the given Surah and reciter
  String call(int surahNumber, {Reciter? reciter}) {
    final currentReciter = reciter ?? repository.getCurrentReciter();
    return repository.getSurahAudioUrl(surahNumber, currentReciter);
  }
}