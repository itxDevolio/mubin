import '../../domain/entities/reading_progress.dart';

class ReadingProgressModel extends ReadingProgress {
  const ReadingProgressModel({
    required super.lastReadPage,
    super.lastReadVerseId,
    required super.updatedAt,
  });

  factory ReadingProgressModel.fromMap(Map<dynamic, dynamic> map) {
    return ReadingProgressModel(
      lastReadPage: map['lastReadPage'] as int? ?? 1,
      lastReadVerseId: map['lastReadVerseId'] as int?,
      updatedAt: DateTime.parse(
        map['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lastReadPage': lastReadPage,
      'lastReadVerseId': lastReadVerseId,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ReadingProgressModel.fromEntity(ReadingProgress entity) {
    return ReadingProgressModel(
      lastReadPage: entity.lastReadPage,
      lastReadVerseId: entity.lastReadVerseId,
      updatedAt: entity.updatedAt,
    );
  }
}
