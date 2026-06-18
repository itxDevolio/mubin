class Verse {
  final int id;
  final int surahNumber;
  final int verseNumber;
  final int juzNumber;
  final int pageNumber;
  final String textArabic;
  final String translation;
  final String audioUrl;
  final String? bookmarkName; // Added field for named bookmarks

  const Verse({
    required this.id,
    required this.surahNumber,
    required this.verseNumber,
    required this.juzNumber,
    required this.pageNumber,
    required this.textArabic,
    required this.translation,
    required this.audioUrl,
    this.bookmarkName,
  });

  Verse copyWith({String? bookmarkName}) {
    return Verse(
      id: id,
      surahNumber: surahNumber,
      verseNumber: verseNumber,
      juzNumber: juzNumber,
      pageNumber: pageNumber,
      textArabic: textArabic,
      translation: translation,
      audioUrl: audioUrl,
      bookmarkName: bookmarkName ?? this.bookmarkName,
    );
  }
}
