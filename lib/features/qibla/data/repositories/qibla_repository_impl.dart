import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/repositories/qibla_repository.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  @override
  Stream<CompassEvent> getCompassStream() {
    final stream = FlutterCompass.events;
    if (stream == null) {
      throw Exception("Compass sensors not available on this device.");
    }
    return stream;
  }

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  @override
  double calculateQiblaDirection(double lat, double lng) {
    const double kaabaLat = 21.422487;
    const double kaabaLng = 39.826206;

    double phi1 = lat * (pi / 180.0);
    double lambda1 = lng * (pi / 180.0);
    double phi2 = kaabaLat * (pi / 180.0);
    double lambda2 = kaabaLng * (pi / 180.0);

    double deltaLambda = lambda2 - lambda1;

    double y = sin(deltaLambda);
    double x = cos(phi1) * tan(phi2) - sin(phi1) * cos(deltaLambda);

    double qibla = atan2(y, x);
    return (qibla * 180.0 / pi + 360.0) % 360.0;
  }
}
