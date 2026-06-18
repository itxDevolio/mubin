import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetJuzListUseCase {
  final QuranRepository repository;

  GetJuzListUseCase(this.repository);

  Future<List<Juz>> call() async {
    return await repository.getJuzList();
  }
}
