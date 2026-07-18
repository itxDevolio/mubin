import 'package:adhan_dart/adhan_dart.dart';
import 'package:mubin/home/service/check_ramadhan.dart';
import 'package:hive/hive.dart';
import 'package:mubin/core/services/settings_controller.dart';

import '../../core/constant/db_consts.dart';

class PrayerService {
  final box = Hive.box(DbConstants.appBox);
  
  Future<PrayerTimes> getPrayerTime(
    double lat,
    double lng,
    bool isHanafi, {
    DateTime? date,
    String? methodKey,
  }) async {
    final coordinates = Coordinates(lat, lng);
    final time = date ?? DateTime.now();
    
    final String currentMethod = methodKey ?? box.get('calculationMethod', defaultValue: 'karachi');
    final madhab = isHanafi ? Madhab.hanafi : Madhab.shafi;
    
    final calculationParams = getCalculationParams(currentMethod, madhab);
    
    // Dynamic Ramadhan adjustment for Isha if needed (some methods use fixed angles)
    // Here we respect the selected method's parameters but can override if specifically required.

    return PrayerTimes(
      date: time,
      coordinates: coordinates,
      calculationParameters: calculationParams,
    );
  }
}
