import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/tasbeeh_local_data_source.dart';
import '../../data/repositories/tasbeeh_repository_impl.dart';
import '../../domain/usecases/increment_tasbeeh_usecase.dart';
import '../../domain/usecases/reset_tasbeeh_usecase.dart';

// 1. Data Source Provider
final tasbeehDataSourceProvider = Provider((ref) => TasbeehLocalDataSource());

// 2. Repository Provider
final tasbeehRepositoryProvider = Provider((ref) => TasbeehRepositoryImpl(ref.read(tasbeehDataSourceProvider)));

// 3. UseCase Providers
final incrementUseCaseProvider = Provider((ref) => IncrementTasbeehUseCase(ref.read(tasbeehRepositoryProvider)));
final resetUseCaseProvider = Provider((ref) => ResetTasbeehUseCase(ref.read(tasbeehRepositoryProvider)));

// 4. State Management
final tasbeehProvider = NotifierProvider.family<TasbeehNotifier, int, String>(TasbeehNotifier.new);

class TasbeehNotifier extends Notifier<int> {
  final String id;
  TasbeehNotifier(this.id);

  @override
  int build() {
    return ref.read(tasbeehRepositoryProvider).getCount(id);
  }

  Future<void> increment() async {
    state = (state >= 999999) ? 0 : state + 1;
    final incrementUseCase = ref.read(incrementUseCaseProvider);
    await incrementUseCase.call(id, state);
  }

  Future<void> reset() async {
    state = 0;
    final resetUseCase = ref.read(resetUseCaseProvider);
    await resetUseCase.call(id);
  }
}
