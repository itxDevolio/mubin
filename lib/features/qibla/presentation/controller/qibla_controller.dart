import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/repositories/qibla_repository_impl.dart';
import '../../domain/repositories/qibla_repository.dart';
import '../../domain/entities/qibla_state.dart';

final qiblaRepositoryProvider = Provider<QiblaRepository>((ref) {
  return QiblaRepositoryImpl();
});

final qiblaProvider = StateNotifierProvider<QiblaNotifier, QiblaState>((ref) {
  return QiblaNotifier(ref.watch(qiblaRepositoryProvider));
});

class QiblaNotifier extends StateNotifier<QiblaState> {
  final QiblaRepository _repository;
  StreamSubscription? _compassSubscription;
  double _qiblaDirection = 0;

  QiblaNotifier(this._repository) : super(QiblaState.initial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      state = state.copyWith(isLoading: true);
      
      final position = await _repository.getCurrentLocation();
      _updateDirection(position);
      
      double smoothedHeading = 0;
      const double alpha = 0.15; // Smoothing factor (0.1 to 0.3 is typical)

      _compassSubscription = _repository.getCompassStream().listen((event) {
        final heading = event.heading;
        if (heading == null) return;

        // Exponential Moving Average (EMA) for pinpoint stability
        // Handling the 0/360 degree wrap-around during smoothing
        if (state.currentHeading == 0 && smoothedHeading == 0) {
          smoothedHeading = heading;
        } else {
          double diff = heading - smoothedHeading;
          if (diff > 180) diff -= 360;
          if (diff < -180) diff += 360;
          smoothedHeading = (smoothedHeading + alpha * diff + 360) % 360;
        }

        final offset = (_qiblaDirection - smoothedHeading + 360) % 360;
        // Pinpoint accuracy threshold (1.5 degrees)
        bool isAligned = (offset < 1.5 || offset > 358.5);
        
        if (isAligned && !state.isAligned) {
          HapticFeedback.mediumImpact();
        }

        state = state.copyWith(
          currentHeading: smoothedHeading,
          offset: offset,
          isAligned: isAligned,
          isLoading: false,
          sensorAccuracy: event.accuracy,
        );
      });
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void _updateDirection(Position position) {
    _qiblaDirection = _repository.calculateQiblaDirection(
      position.latitude,
      position.longitude,
    );
    state = state.copyWith(qiblaDirection: _qiblaDirection);
  }

  void showCalibration() {
    state = state.copyWith(needsCalibration: true);
  }

  void dismissCalibration() {
    state = state.copyWith(needsCalibration: false);
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }
}
