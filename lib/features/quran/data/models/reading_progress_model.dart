import '../../domain/entities/reading_progress.dart';

class ReadingProgressModel extends ReadingProgress {
  const ReadingProgressModel({
    required super.lastReadPage,
    required super.updatedAt,
  });

  // Hive/Map se Data nikal kar Model banane ke liye
  factory ReadingProgressModel.fromMap(Map<dynamic, dynamic> map) {
    return ReadingProgressModel(
      lastReadPage: map['lastReadPage'] as int? ?? 1,
      updatedAt: DateTime.parse(
        map['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  // Model ko Map mein convert karne ke liye taaki Hive mein save ho sake
  Map<String, dynamic> toMap() {
    return {
      'lastReadPage': lastReadPage,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Entity ko Model mein convert karne ka helper (Repository ke liye)
  factory ReadingProgressModel.fromEntity(ReadingProgress entity) {
    return ReadingProgressModel(
      lastReadPage: entity.lastReadPage,
      updatedAt: entity.updatedAt,
    );
  }
}
