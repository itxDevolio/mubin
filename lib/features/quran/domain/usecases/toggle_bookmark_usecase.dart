import '../entities/verse.dart';
import '../repositories/quran_repository.dart';

class ToggleBookmarkUseCase {
  final QuranRepository repository;

  ToggleBookmarkUseCase(this.repository);

  Future<void> call(Verse verse) async {
    return await repository.toggleBookmark(verse);
  }
}
