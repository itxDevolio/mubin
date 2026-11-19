import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_data_source.dart';

final adhkarDataSourceProvider = Provider((ref) => AdhkarLocalDataSource());

final adhkarCountProvider = NotifierProvider.family<DhikrNotifier, int, String>(DhikrNotifier.new);

class DhikrNotifier extends Notifier<int> {
  final String id;
  DhikrNotifier(this.id);

  @override
  int build() {
    _loadCount(id);
    return 0;
  }

  Future<void> _loadCount(String id) async {
    final dataSource = ref.read(adhkarDataSourceProvider);
    final data = await dataSource.getDhikrData(id);
    if (data != null) {
      state = data['count'] ?? 0;
    }
  }

  void increment() {
    state++;
    ref.read(adhkarDataSourceProvider).updateCount(id, state);
  }

  void reset() {
    state = 0;
    ref.read(adhkarDataSourceProvider).updateCount(id, 0);
  }
}
