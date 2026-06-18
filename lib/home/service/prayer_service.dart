import 'package:adhan_dart/adhan_dart.dart';
import 'package:auraq/home/service/check_ramadhan.dart';
import 'package:hive/hive.dart';

import '../../core/constant/db_consts.dart';

class PrayerService {
  final box = Hive.box(DbConstants.appBox);
  Future<PrayerTimes> getPrayerTime(
    double lat,
    double lng,
    bool isHanafi,
  ) async {
    final coordinates = Coordinates(lat, lng);

    final time = DateTime.now();

    return PrayerTimes(
      date: time,
      coordinates: coordinates,
      calculationParameters: CalculationParameters(
        method: CalculationMethod.ummAlQura,
        fajrAngle: 18.5,
        ishaAngle: 0.0,
        ishaInterval: isRamadhan(time) ? 120 : 90,
        madhab: isHanafi ? Madhab.hanafi : Madhab.shafi,
      ),
    );
  }
}
