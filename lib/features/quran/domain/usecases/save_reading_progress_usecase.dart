import '../repositories/quran_repository.dart';

class SaveReadingProgressUseCase {
  final QuranRepository repository;

  SaveReadingProgressUseCase(this.repository);

  // Yeh call function integer pageNumber lega aur use save karwayega
  Future<void> call(int pageNumber) async {
    return await repository.saveReadingProgress(pageNumber);
  }
}
