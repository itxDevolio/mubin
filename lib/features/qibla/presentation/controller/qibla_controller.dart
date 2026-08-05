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
      
      // Fetch fresh location for pinpoint accuracy
      final position = await _repository.getCurrentLocation();
      _updateDirection(position);
      
      _compassSubscription = _repository.getCompassStream().listen((event) {
        final heading = event.heading;
        if (heading == null) return;

        final offset = (_qiblaDirection - heading + 360) % 360;
        bool isAligned = (offset < 2 || offset > 358);
        
        if (isAligned && !state.isAligned) {
          HapticFeedback.heavyImpact();
        }

        state = state.copyWith(
          currentHeading: heading,
          offset: offset,
          isAligned: isAligned,
          isLoading: false,
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
