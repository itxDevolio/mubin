import '../entities/reciter.dart';

/// Use case to get all available reciters (only 3)
class GetRecitersUseCase {
  /// Execute the use case
  /// Returns list of all available reciters
  List<Reciter> call() {
    return Reciters.all;
  }

  /// Get the default reciter
  Reciter getDefaultReciter() {
    return Reciters.defaultReciter;
  }

  /// Get reciter by ID
  Reciter? getReciterById(String id) {
    return Reciters.getById(id);
  }

  /// Get reciter by name
  Reciter? getReciterByName(String name) {
    return Reciters.getByName(name);
  }
}