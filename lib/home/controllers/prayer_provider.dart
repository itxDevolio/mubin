import 'package:adhan_dart/adhan_dart.dart';
import 'package:mubin/core/constant/db_consts.dart';
import 'package:mubin/core/services/notification_service.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/home/service/locatoin_service.dart';
import 'package:mubin/home/service/prayer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

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
  final settings = ref.watch(settingsControllerProvider);
  final isHanafi = settings.madhab == 'hanafi';
  final prayerService = PrayerService();

  final double? savedLat = box.get('lat');
  final double? savedLng = box.get('lng');

  if (savedLat != null && savedLng != null) {
    // Background mein location silent refresh karne ke liye trigger kiya
    ref.read(locationProvider.future).then((position) async {
      if (position != null) {
        final double oldLat = savedLat;
        final double oldLng = savedLng;
        
        if ((position.latitude - oldLat).abs() > 0.01 || (position.longitude - oldLng).abs() > 0.01) {
          await box.put('lat', position.latitude);
          await box.put('lng', position.longitude);
          // Location significant change hui, notifications reschedule karo
          await NotificationService().scheduleAllNotifications();
        }
      }
    });

    // 🔥 Target date ke sath offline calculation return ki
    return await prayerService.getPrayerTime(savedLat, savedLng, isHanafi);
  }

  final position = await ref.watch(locationProvider.future);
  if (position != null) {
    await box.put('lat', position.latitude);
    await box.put('lng', position.longitude);
    // 🔥 Target date ke sath fresh computation return ki
    return await prayerService.getPrayerTime(
      position.latitude,
      position.longitude,
      isHanafi,
    );
  }

  return null;
});
