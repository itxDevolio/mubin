import 'verse.dart';

class Surah {
  final int number; // Surah number (1-114)
  final String nameArabic; // Surah ka Arabic naam (e.g., الفاتحة)
  final String
  nameEnglish; // Surah ka English transliteration (e.g., Al-Fatiha)
  final int totalVerses; // Surah mein kul kitni aayatein hain
  final List<Verse>
  verses; // Is Surah ki tamam verses ki list (optional loading ke liye)

  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.totalVerses,
    this.verses = const [],
  });
}
