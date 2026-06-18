import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/quran_local_data_source.dart';
import '../../data/datasources/quran_remote_data_source.dart';
import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/usecases/get_bookmarks_usecase.dart';
import '../../domain/usecases/get_juz_list_usecase.dart';
import '../../domain/usecases/get_reading_progress_usercase.dart';
import '../../domain/usecases/get_surahs_usecase.dart';
import '../../domain/usecases/save_reading_progress_usecase.dart';
import '../../domain/usecases/toggle_bookmark_usecase.dart';

// 1. Data Sources Providers
final quranLocalDataSourceProvider = Provider<QuranLocalDataSource>((ref) {
  return QuranLocalDataSourceImpl();
});

final quranRemoteDataSourceProvider = Provider<QuranRemoteDataSource>((ref) {
  return QuranRemoteDataSourceImpl();
});

// 2. Repository Provider (Binds Implementation to Contract)
final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepositoryImpl(
    localDataSource: ref.watch(quranLocalDataSourceProvider),
  );
});

// 3. Use Cases Providers
final getSurahsUseCaseProvider = Provider(
  (ref) => GetSurahsUseCase(ref.watch(quranRepositoryProvider)),
);
final getJuzListUseCaseProvider = Provider(
  (ref) => GetJuzListUseCase(ref.watch(quranRepositoryProvider)),
);
final getReadingProgressUseCaseProvider = Provider(
  (ref) => GetReadingProgressUseCase(ref.watch(quranRepositoryProvider)),
);
final saveReadingProgressUseCaseProvider = Provider(
  (ref) => SaveReadingProgressUseCase(ref.watch(quranRepositoryProvider)),
);
final toggleBookmarkUseCaseProvider = Provider(
  (ref) => ToggleBookmarkUseCase(ref.watch(quranRepositoryProvider)),
);
final getBookmarksUseCaseProvider = Provider(
  (ref) => GetBookmarksUseCase(ref.watch(quranRepositoryProvider)),
);
