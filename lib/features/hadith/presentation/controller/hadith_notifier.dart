import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/hadith.dart';
import '../../domain/repositories/hadith_repository.dart';
import '../../data/repositories/hadith_repository_impl.dart';
import '../../data/datasources/hadith_local_data_source.dart';
import '../../../../core/services/settings_controller.dart';

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
class HadithNotifier extends Notifier<HadithState> {
  @override
  HadithState build() => HadithInitial();

  Future<void> fetchHadiths(String bookSlug, String chapterNumber) async {
    state = HadithLoading();
    try {
      final repository = ref.read(hadithRepositoryProvider);
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

final hadithProvider = NotifierProvider<HadithNotifier, HadithState>(() {
  return HadithNotifier();
});

class HadithLanguageNotifier extends Notifier<String> {
  String? _userSelectedLang;

  @override
  String build() {
    final settings = ref.watch(settingsControllerProvider);
    if (settings.language == 'en') {
      return 'en';
    } else if (settings.language == 'ur') {
      return 'ur';
    } else if (settings.language == 'ps') {
      return 'ps';
    } else {
      return _userSelectedLang ?? 'ur';
    }
  }

  void setHadithLanguage(String lang) {
    _userSelectedLang = lang;
    state = lang;
  }
}

final hadithLanguageProvider = NotifierProvider<HadithLanguageNotifier, String>(() {
  return HadithLanguageNotifier();
});
