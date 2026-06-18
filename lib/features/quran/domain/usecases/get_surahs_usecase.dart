import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetSurahsUseCase {
  final QuranRepository repository;

  GetSurahsUseCase(this.repository);

  Future<List<Surah>> call() async {
    return await repository.getSurahs();
  }
}
