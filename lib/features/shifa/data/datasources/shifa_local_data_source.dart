import 'package:hive/hive.dart';

class ShifaLocalDataSource {
  final String boxName = 'shifa_box';

  Future<Box> _getBox() async {
    return await Hive.openBox(boxName);
  }

  Future<void> updateCount(String id, int newCount) async {
    final box = await _getBox();
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    await box.put(id, {
      'id': id,
      'count': newCount,
      'lastUpdated': today,
    });
  }

  Future<Map<String, dynamic>?> getShifaData(String id) async {
    final box = await _getBox();
    final data = box.get(id);
    if (data == null) return null;
    
    final map = Map<String, dynamic>.from(data);
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastUpdated = map['lastUpdated'];
    
    if (lastUpdated != today) {
      map['count'] = 0;
      map['lastUpdated'] = today;
      await box.put(id, map);
    }
    
    return map;
  }
}
