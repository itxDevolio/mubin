class ReadingProgress {
  final int lastReadPage; // 1 se 604 tak konsa page aakhri dafa parha tha
  final DateTime
  updatedAt; // Kis waqt update hua (helpful for future Firebase sync logic)

  const ReadingProgress({required this.lastReadPage, required this.updatedAt});

  // Initial state ke liye ek helper constructor (jab user ne abhi tak parhna shuru na kiya ho)
  factory ReadingProgress.initial() {
    return ReadingProgress(lastReadPage: 1, updatedAt: DateTime.now());
  }
}
