import '../entities/shifa_entity.dart';
import '../../data/models/shifa_constants.dart';

abstract class ShifaRepository {
  List<ShifaCategory> getCategories();
  List<ShifaEntity> getDuasByCategory(String categoryId);
  List<ShifaEntity> searchDuas(String query);
}
