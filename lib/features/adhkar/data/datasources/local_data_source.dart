import 'package:hive/hive.dart';
import '../models/dhikr_model.dart';

class AdhkarLocalDataSource {
  final String boxName = 'adhkar_box';

  Future<Box> _getBox() async {
    return await Hive.openBox(boxName);
  }

  Future<void> updateCount(String id, int newCount) async {
    final box = await _getBox();
    final data = box.get(id);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (data != null) {
      final map = Map<String, dynamic>.from(data);
      map['count'] = newCount;
      map['lastUpdated'] = today;
      await box.put(id, map);
    } else {
      // If it doesn't exist, we just put the count and date
      await box.put(id, {
        'id': id,
        'count': newCount,
        'lastUpdated': today,
      });
    }
  }

  Future<Map<String, dynamic>?> getDhikrData(String id) async {
    final box = await _getBox();
    final data = box.get(id);
    if (data == null) return null;

    final map = Map<String, dynamic>.from(data);
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastUpdated = map['lastUpdated'];

    // If it was updated on a different day, reset the count in memory (and save it)
    if (lastUpdated != today) {
      map['count'] = 0;
      map['lastUpdated'] = today;
      await box.put(id, map);
    }

    return map;
  }
}
