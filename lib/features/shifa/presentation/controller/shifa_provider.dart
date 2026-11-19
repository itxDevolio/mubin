import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/shifa_local_data_source.dart';

final shifaDataSourceProvider = Provider((ref) => ShifaLocalDataSource());

final shifaCountProvider = NotifierProvider.family<ShifaNotifier, int, String>(ShifaNotifier.new);

class ShifaNotifier extends Notifier<int> {
  final String id;
  ShifaNotifier(this.id);

  @override
  int build() {
    _loadCount(id);
    return 0;
  }

  Future<void> _loadCount(String id) async {
    final dataSource = ref.read(shifaDataSourceProvider);
    final data = await dataSource.getShifaData(id);
    if (data != null) {
      state = data['count'] ?? 0;
    }
  }

  void increment() {
    state++;
    ref.read(shifaDataSourceProvider).updateCount(id, state);
  }

  void reset() {
    state = 0;
    ref.read(shifaDataSourceProvider).updateCount(id, 0);
  }
}
