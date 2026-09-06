class QiblaState {
  final double qiblaDirection;
  final double currentHeading;
  final double offset;
  final bool isAligned;
  final bool needsCalibration;
  final bool isLoading;
  final double? sensorAccuracy; // New field

  QiblaState({
    required this.qiblaDirection,
    required this.currentHeading,
    required this.offset,
    required this.isAligned,
    this.needsCalibration = false,
    this.isLoading = true,
    this.sensorAccuracy,
  });

  factory QiblaState.initial() {
    return QiblaState(
      qiblaDirection: 0,
      currentHeading: 0,
      offset: 0,
      isAligned: false,
      needsCalibration: false,
      isLoading: true,
      sensorAccuracy: null,
    );
  }

  QiblaState copyWith({
    double? qiblaDirection,
    double? currentHeading,
    double? offset,
    bool? isAligned,
    bool? needsCalibration,
    bool? isLoading,
    double? sensorAccuracy,
  }) {
    return QiblaState(
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
      currentHeading: currentHeading ?? this.currentHeading,
      offset: offset ?? this.offset,
      isAligned: isAligned ?? this.isAligned,
      needsCalibration: needsCalibration ?? this.needsCalibration,
      isLoading: isLoading ?? this.isLoading,
      sensorAccuracy: sensorAccuracy ?? this.sensorAccuracy,
    );
  }
}
