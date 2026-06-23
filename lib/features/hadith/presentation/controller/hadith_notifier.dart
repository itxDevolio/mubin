import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/hadith.dart';
import '../../domain/repositories/hadith_repository.dart';
import '../../data/repositories/hadith_repository_impl.dart';
import '../../data/datasources/hadith_local_data_source.dart';

// 1. Define State Classes
sealed class HadithState {}
class HadithInitial extends HadithState {}
class HadithLoading extends HadithState {}
class HadithLoaded extends HadithState {
  final List<HadithEntity> hadiths;
  HadithLoaded(this.hadiths);
}
class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}

// 2. Define Notifier Class
class HadithNotifier extends StateNotifier<HadithState> {
  final HadithRepository repository;

  HadithNotifier(this.repository) : super(HadithInitial());

  Future<void> fetchHadiths(String bookSlug, String chapterNumber) async {
    state = HadithLoading();
    try {
      final data = await repository.getHadiths(bookSlug, chapterNumber);
      state = HadithLoaded(data);
    } catch (e) {
      state = HadithError(e.toString());
    }
  }
}

// 3. Providers
final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepositoryImpl(HadithLocalDataSource());
});

final hadithProvider = StateNotifierProvider<HadithNotifier, HadithState>((ref) {
  final repository = ref.read(hadithRepositoryProvider);
  return HadithNotifier(repository);
});