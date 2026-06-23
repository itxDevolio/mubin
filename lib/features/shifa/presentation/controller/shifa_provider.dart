import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/shifa_local_data_source.dart';

final shifaDataSourceProvider = Provider((ref) => ShifaLocalDataSource());

final shifaCountProvider = StateNotifierProvider.family<ShifaNotifier, int, String>((ref, id) {
  final dataSource = ref.watch(shifaDataSourceProvider);
  return ShifaNotifier(id, dataSource);
});

class ShifaNotifier extends StateNotifier<int> {
  final String id;
  final ShifaLocalDataSource dataSource;

  ShifaNotifier(this.id, this.dataSource) : super(0) {
    _loadCount();
  }

  Future<void> _loadCount() async {
    final data = await dataSource.getShifaData(id);
    if (data != null) {
      state = data['count'] ?? 0;
    }
  }

  void increment() {
    state++;
    dataSource.updateCount(id, state);
  }

  void reset() {
    state = 0;
    dataSource.updateCount(id, 0);
  }
}
