import 'package:adhan_dart/adhan_dart.dart';
import 'package:auraq/home/service/locatoin_service.dart';
import 'package:auraq/home/service/prayer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';

final isShafiProvider = StateProvider<bool>((ref) => true);

final locationProvider = FutureProvider<Position?>((ref) async {
  return await locationService();
});

final prayerTimesProvider = FutureProvider<PrayerTimes?>((ref) async {
  final position = await ref.watch(locationProvider.future);
  final isHanafi = ref.watch(isShafiProvider);

  if (position != null) {
    final prayerService = PrayerService();
    return await prayerService.getPrayerTime(
      position.latitude,
      position.longitude,
      isHanafi,
    );
  }
  return null;
});
