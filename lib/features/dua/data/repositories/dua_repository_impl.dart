import '../../domain/entities/dua_entity.dart';
import '../../domain/repositories/dua_repository.dart';
import '../models/dua_constants.dart';

class DuaRepositoryImpl implements DuaRepository {
  @override
  List<DuaCategory> getCategories() {
    return DuaConstants.categories;
  }

  @override
  List<DuaEntity> searchDuas(String query) {
    if (query.isEmpty) return DuaConstants.allDuas;
    final lowerQuery = query.toLowerCase();
    return DuaConstants.allDuas.where((dua) {
      return dua.titleEn.toLowerCase().contains(lowerQuery) ||
          dua.titleUr.contains(query) ||
          dua.translationEn.toLowerCase().contains(lowerQuery) ||
          dua.translationUr.contains(query);
    }).toList();
  }
}
