import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/dua_entity.dart';
import '../../domain/repositories/dua_repository.dart';
import '../../data/repositories/dua_repository_impl.dart';
import '../../data/models/dua_constants.dart';

sealed class DuaState {}
class DuaInitial extends DuaState {}
class DuaLoading extends DuaState {}
class DuaLoaded extends DuaState {
  final List<DuaEntity> allDuas;
  final List<DuaEntity> searchedDuas;
  final String searchQuery;
  
  DuaLoaded({
    required this.allDuas, 
    this.searchedDuas = const [],
    this.searchQuery = '',
  });

  DuaLoaded copyWith({
    List<DuaEntity>? allDuas,
    List<DuaEntity>? searchedDuas,
    String? searchQuery,
  }) {
    return DuaLoaded(
      allDuas: allDuas ?? this.allDuas,
      searchedDuas: searchedDuas ?? this.searchedDuas,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class DuaNotifier extends Notifier<DuaState> {
  @override
  DuaState build() {
    Future.microtask(() => loadDuas());
    return DuaInitial();
  }

  void loadDuas() {
    state = DuaLoading();
    final repository = ref.read(duaRepositoryProvider);
    final duas = repository.getAllDuas();
    state = DuaLoaded(allDuas: duas);
  }

  void searchDuas(String query) {
    if (state is DuaLoaded) {
      final currentState = state as DuaLoaded;
      final repository = ref.read(duaRepositoryProvider);
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

final duaProvider = NotifierProvider<DuaNotifier, DuaState>(() {
  return DuaNotifier();
});
