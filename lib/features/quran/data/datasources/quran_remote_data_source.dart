import '../models/reading_progress_model.dart';
import '../models/verse_model.dart';

abstract class QuranRemoteDataSource {
  Future<void> uploadProgressToFirebase(ReadingProgressModel progress);
  Future<void> syncBookmarksToFirebase(List<VerseModel> bookmarks);
}

// Jab Firebase setup ho jaye, toh is class ke andar Firebase Firestore ka code aayega.
// Abhi ke liye hum isko khali chhor rahe hain ya unimplemented errors de sakte hain.
class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  @override
  Future<void> uploadProgressToFirebase(ReadingProgressModel progress) async {
    // TODO: Implement Firebase Sync later
  }

  @override
  Future<void> syncBookmarksToFirebase(List<VerseModel> bookmarks) async {
    // TODO: Implement Firebase Sync later
  }
}
