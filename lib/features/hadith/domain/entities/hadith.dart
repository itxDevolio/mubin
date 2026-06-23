class HadithEntity {
  final String id;
  final String hadithNumber;
  final String chapterNumber;
  final String englishText;
  final String urduText;
  final String arabicText;
  final String status;

  HadithEntity({
    required this.id,
    required this.hadithNumber,
    required this.chapterNumber,
    required this.englishText,
    required this.urduText,
    required this.arabicText,
    required this.status,
  });
}