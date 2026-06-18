import '../entities/verse.dart';
import '../repositories/quran_repository.dart';

class GetBookmarksUseCase {
  final QuranRepository repository;

  GetBookmarksUseCase(this.repository);

  Future<List<Verse>> call() async {
    return await repository.getBookmarkedVerses();
  }
}
