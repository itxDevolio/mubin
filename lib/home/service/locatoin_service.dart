import 'package:auraq/home/service/check_location_permission.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> locationService() async {
  final isGranted = await checkLocationPermission();
  if (isGranted) {
    var position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        distanceFilter: 100,
        accuracy: LocationAccuracy.best,
      ),
    );
    return position;
  } else {
    return null;
  }
}
