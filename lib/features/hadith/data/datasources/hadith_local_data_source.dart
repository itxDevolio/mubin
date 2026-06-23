import 'package:hive/hive.dart';
import '../models/hadith_model.dart';

class HadithLocalDataSource {
  final Box _box = Hive.box('hadith_cache');

  // Data save karna (Map mein convert karke)
  Future<void> cacheHadiths(String key, List<dynamic> hadiths) async {
    await _box.put(key, hadiths);
  }

  // Data fetch karna
  List<dynamic>? getCachedHadiths(String key) {
    return _box.get(key);
  }
}