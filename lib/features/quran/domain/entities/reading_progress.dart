class ReadingProgress {
  final int lastReadPage;
  final int? lastReadVerseId;
  final DateTime updatedAt;

  const ReadingProgress({
    required this.lastReadPage,
    this.lastReadVerseId,
    required this.updatedAt,
  });

  factory ReadingProgress.initial() {
    return ReadingProgress(
      lastReadPage: 1,
      lastReadVerseId: null,
      updatedAt: DateTime.now(),
    );
  }
}
