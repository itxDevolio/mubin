import 'package:hive/hive.dart';
import '../models/reading_progress_model.dart';
import '../models/verse_model.dart';

abstract class QuranLocalDataSource {
  // Progress Methods
  Future<void> cacheReadingProgress(ReadingProgressModel progress);
  Future<ReadingProgressModel?> getLastReadingProgress();

  // Bookmark Methods
  Future<void> saveBookmark(VerseModel verse);
  Future<void> removeBookmark(int verseId);
  Future<List<VerseModel>> getCachedBookmarks();
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  // Box names ko constants rakhna behtar hai taaki typos na hon
  static const String _progressBoxName = 'quran_progress_box';
  static const String _bookmarkBoxName = 'quran_bookmark_box';

  @override
  Future<void> cacheReadingProgress(ReadingProgressModel progress) async {
    final box = await Hive.openBox<dynamic>(_progressBoxName);
    // Bina generator ke hum direct Map save kar rahe hain
    await box.put('current_progress', progress.toMap());
  }

  @override
  Future<ReadingProgressModel?> getLastReadingProgress() async {
    final box = await Hive.openBox<dynamic>(_progressBoxName);
    final rawData = box.get('current_progress');
    if (rawData != null) {
      // Wapas Map se Model bana rahe hain
      return ReadingProgressModel.fromMap(rawData as Map<dynamic, dynamic>);
    }
    return null;
  }

  @override
  Future<void> saveBookmark(VerseModel verse) async {
    final box = await Hive.openBox<dynamic>(_bookmarkBoxName);
    // Verse ID ko he key bana kar save karenge taaki duplicate na ho aur find karna aasan ho
    await box.put(verse.id, verse.toMap());
  }

  @override
  Future<void> removeBookmark(int verseId) async {
    final box = await Hive.openBox<dynamic>(_bookmarkBoxName);
    await box.delete(verseId);
  }

  @override
  Future<List<VerseModel>> getCachedBookmarks() async {
    final box = await Hive.openBox<dynamic>(_bookmarkBoxName);
    // Box ke tamam values ko list mein convert karke parse kar rahe hain
    return box.values
        .map((rawData) => VerseModel.fromMap(rawData as Map<dynamic, dynamic>))
        .toList();
  }
}
