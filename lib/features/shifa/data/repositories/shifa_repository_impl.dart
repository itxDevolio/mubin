import '../../domain/entities/shifa_entity.dart';
import '../../domain/repositories/shifa_repository.dart';
import '../models/shifa_constants.dart';

class ShifaRepositoryImpl implements ShifaRepository {
  @override
  List<ShifaCategory> getCategories() {
    return ShifaConstants.categories;
  }

  @override
  List<ShifaEntity> getDuasByCategory(String categoryId) {
    return ShifaConstants.categories
        .firstWhere((cat) => cat.id == categoryId,
            orElse: () => ShifaCategory(id: '', titleEn: '', titleUr: '', duas: []))
        .duas;
  }

  @override
  List<ShifaEntity> searchDuas(String query) {
    if (query.isEmpty) return ShifaConstants.allDuas;
    final lowerQuery = query.toLowerCase();
    return ShifaConstants.allDuas.where((dua) {
      return dua.titleEn.toLowerCase().contains(lowerQuery) ||
          dua.titleUr.contains(query) ||
          dua.translationEn.toLowerCase().contains(lowerQuery) ||
          dua.translationUr.contains(query);
    }).toList();
  }
}
