import 'package:adhan_dart/adhan_dart.dart';
import 'package:auraq/core/constant/db_consts.dart';
import 'package:auraq/home/service/locatoin_service.dart';
import 'package:auraq/home/service/prayer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

final isShafiProvider = StateProvider<bool>((ref) => true);

final locationProvider = FutureProvider<Position?>((ref) async {
  try {
    return await locationService();
  } catch (_) {
    return null;
  }
});

// 🔥 FutureProvider.family bana diya jo input mein DateTime accept karta hai
final prayerTimesProvider = FutureProvider.family<PrayerTimes?, DateTime>((
  ref,
  targetDate,
) async {
  ref.keepAlive();

  final box = Hive.box(DbConstants.appBox);
  final isShafi = ref.watch(isShafiProvider);
  final prayerService = PrayerService();

  final double? savedLat = box.get('lat');
  final double? savedLng = box.get('lng');

  if (savedLat != null && savedLng != null) {
    // Background mein location silent refresh karne ke liye trigger kiya
    ref.read(locationProvider.future).then((position) async {
      if (position != null) {
        await box.put('lat', position.latitude);
        await box.put('lng', position.longitude);
      }
    });

    // 🔥 Target date ke sath offline calculation return ki
    return await prayerService.getPrayerTime(
      savedLat,
      savedLng,
      isShafi,
    );
  }

  final position = await ref.watch(locationProvider.future);
  if (position != null) {
    await box.put('lat', position.latitude);
    await box.put('lng', position.longitude);
    // 🔥 Target date ke sath fresh computation return ki
    return await prayerService.getPrayerTime(
      position.latitude,
      position.longitude,
      isShafi,
    );
  }

  return null;
});
