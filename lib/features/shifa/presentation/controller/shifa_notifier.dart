import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/shifa_entity.dart';
import '../../domain/repositories/shifa_repository.dart';
import '../../data/repositories/shifa_repository_impl.dart';
import '../../data/models/shifa_constants.dart';

// State classes
sealed class ShifaState {}
class ShifaInitial extends ShifaState {}
class ShifaLoading extends ShifaState {}
class ShifaLoaded extends ShifaState {
  final List<ShifaEntity> allDuas;
  final List<ShifaEntity> searchedDuas;
  final String searchQuery;
  
  ShifaLoaded({
    required this.allDuas, 
    this.searchedDuas = const [],
    this.searchQuery = '',
  });

  ShifaLoaded copyWith({
    List<ShifaEntity>? allDuas,
    List<ShifaEntity>? searchedDuas,
    String? searchQuery,
  }) {
    return ShifaLoaded(
      allDuas: allDuas ?? this.allDuas,
      searchedDuas: searchedDuas ?? this.searchedDuas,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ShifaNotifier extends Notifier<ShifaState> {
  @override
  ShifaState build() {
    Future.microtask(() => loadDuas());
    return ShifaInitial();
  }

  void loadDuas() {
    state = ShifaLoading();
    final repository = ref.read(shifaRepositoryProvider);
    final duas = repository.getAllDuas();
    state = ShifaLoaded(allDuas: duas);
  }

  void searchDuas(String query) {
    if (state is ShifaLoaded) {
      final currentState = state as ShifaLoaded;
      final repository = ref.read(shifaRepositoryProvider);
      if (query.isEmpty) {
        state = currentState.copyWith(searchedDuas: [], searchQuery: '');
      } else {
        final results = repository.searchDuas(query);
        state = currentState.copyWith(searchedDuas: results, searchQuery: query);
      }
    }
  }
}

// Providers
final shifaRepositoryProvider = Provider<ShifaRepository>((ref) {
  return ShifaRepositoryImpl();
});

final shifaProvider = NotifierProvider<ShifaNotifier, ShifaState>(() {
  return ShifaNotifier();
});
