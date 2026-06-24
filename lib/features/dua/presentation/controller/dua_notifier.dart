import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/dua_entity.dart';
import '../../domain/repositories/dua_repository.dart';
import '../../data/repositories/dua_repository_impl.dart';
import '../../data/models/dua_constants.dart';

sealed class DuaState {}
class DuaInitial extends DuaState {}
class DuaLoading extends DuaState {}
class DuaLoaded extends DuaState {
  final List<DuaCategory> categories;
  final List<DuaEntity> searchedDuas;
  final String searchQuery;
  
  DuaLoaded({
    required this.categories, 
    this.searchedDuas = const [],
    this.searchQuery = '',
  });

  DuaLoaded copyWith({
    List<DuaCategory>? categories,
    List<DuaEntity>? searchedDuas,
    String? searchQuery,
  }) {
    return DuaLoaded(
      categories: categories ?? this.categories,
      searchedDuas: searchedDuas ?? this.searchedDuas,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class DuaNotifier extends StateNotifier<DuaState> {
  final DuaRepository repository;

  DuaNotifier(this.repository) : super(DuaInitial()) {
    loadCategories();
  }

  void loadCategories() {
    state = DuaLoading();
    final categories = repository.getCategories();
    state = DuaLoaded(categories: categories);
  }

  void searchDuas(String query) {
    if (state is DuaLoaded) {
      final currentState = state as DuaLoaded;
      if (query.isEmpty) {
        state = currentState.copyWith(searchedDuas: [], searchQuery: '');
      } else {
        final results = repository.searchDuas(query);
        state = currentState.copyWith(searchedDuas: results, searchQuery: query);
      }
    }
  }
}

final duaRepositoryProvider = Provider<DuaRepository>((ref) {
  return DuaRepositoryImpl();
});

final duaProvider = StateNotifierProvider<DuaNotifier, DuaState>((ref) {
  final repository = ref.watch(duaRepositoryProvider);
  return DuaNotifier(repository);
});
