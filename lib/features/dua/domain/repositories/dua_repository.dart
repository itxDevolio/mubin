import '../entities/dua_entity.dart';
import '../../data/models/dua_constants.dart';

abstract class DuaRepository {
  List<DuaCategory> getCategories();
  List<DuaEntity> searchDuas(String query);
}
