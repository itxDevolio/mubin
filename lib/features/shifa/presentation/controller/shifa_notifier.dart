import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/shifa_entity.dart';
import '../../domain/repositories/shifa_repository.dart';
import '../../data/repositories/shifa_repository_impl.dart';
import '../../data/models/shifa_constants.dart';

// State classes
sealed class ShifaState {}
class ShifaInitial extends ShifaState {}
class ShifaLoading extends ShifaState {}
class ShifaLoaded extends ShifaState {
  final List<ShifaCategory> categories;
  final List<ShifaEntity> searchedDuas;
  final String searchQuery;
  
  ShifaLoaded({
    required this.categories, 
    this.searchedDuas = const [],
    this.searchQuery = '',
  });

  ShifaLoaded copyWith({
    List<ShifaCategory>? categories,
    List<ShifaEntity>? searchedDuas,
    String? searchQuery,
  }) {
    return ShifaLoaded(
      categories: categories ?? this.categories,
      searchedDuas: searchedDuas ?? this.searchedDuas,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ShifaNotifier extends StateNotifier<ShifaState> {
  final ShifaRepository repository;

  ShifaNotifier(this.repository) : super(ShifaInitial()) {
    loadCategories();
  }

  void loadCategories() {
    state = ShifaLoading();
    final categories = repository.getCategories();
    state = ShifaLoaded(categories: categories);
  }

  void searchDuas(String query) {
    if (state is ShifaLoaded) {
      final currentState = state as ShifaLoaded;
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

final shifaProvider = StateNotifierProvider<ShifaNotifier, ShifaState>((ref) {
  final repository = ref.watch(shifaRepositoryProvider);
  return ShifaNotifier(repository);
});
