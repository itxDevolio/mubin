// lib/features/quran/data/models/surah_model.dart
import '../../domain/entities/surah.dart';
import 'verse_model.dart';

class SurahModel extends Surah {
  const SurahModel({
    required super.number,
    required super.nameArabic,
    required super.nameEnglish,
    required super.totalVerses,
    super.verses,
  });

  factory SurahModel.fromMap(Map<String, dynamic> map) {
    return SurahModel(
      number: map['number'] as int,
      nameArabic: map['nameArabic'] as String,
      nameEnglish: map['nameEnglish'] as String,
      totalVerses: map['totalVerses'] as int,
      verses: map['verses'] != null
          ? (map['verses'] as List)
                .map((v) => VerseModel.fromMap(v as Map))
                .toList()
          : const [],
    );
  }
}
