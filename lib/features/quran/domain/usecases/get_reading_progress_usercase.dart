import '../entities/reading_progress.dart';
import '../repositories/quran_repository.dart';

class GetReadingProgressUseCase {
  final QuranRepository repository;

  GetReadingProgressUseCase(this.repository);

  Future<ReadingProgress> call() async {
    return await repository.getReadingProgress();
  }
}
