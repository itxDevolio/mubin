import '../../domain/entities/hadith.dart';

class HadithModel extends HadithEntity {
  HadithModel({
    required super.id,
    required super.hadithNumber,
    required super.chapterNumber,
    required super.bookSlug,
    required super.headingEnglish,
    required super.headingUrdu,
    required super.englishText,
    required super.urduText,
    required super.arabicText,
    required super.status,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    String slug = (json['bookSlug'] ?? json['book_slug'] ?? '').toString();
    if (slug.isEmpty && json['book'] != null && json['book'] is Map) {
      slug = (json['book']['bookSlug'] ?? json['book']['book_slug'] ?? '').toString();
    }

    String headingEn = (json['headingEnglish'] ?? json['heading_english'] ?? json['chapterTitle'] ?? '').toString();
    if (headingEn.isEmpty && json['chapter'] != null && json['chapter'] is Map) {
      headingEn = (json['chapter']['chapterEnglish'] ?? '').toString();
    }

    String headingUr = (json['headingUrdu'] ?? json['heading_urdu'] ?? '').toString();
    if (headingUr.isEmpty && json['chapter'] != null && json['chapter'] is Map) {
      headingUr = (json['chapter']['chapterUrdu'] ?? '').toString();
    }

    return HadithModel(
      id: (json['id'] ?? json['hadithNumber'] ?? '0').toString(),
      hadithNumber: (json['hadithNumber'] ?? json['hadith_number'] ?? '0').toString(),
      chapterNumber: (json['chapterNumber'] ?? json['chapter'] ?? '0').toString(),
      bookSlug: slug,
      headingEnglish: headingEn,
      headingUrdu: headingUr,
      englishText: (json['hadithEnglish'] ?? json['englishText'] ?? '').toString(),
      urduText: (json['hadithUrdu'] ?? json['urduText'] ?? '').toString(),
      arabicText: (json['hadithArabic'] ?? json['arabicText'] ?? json['arab'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
    );
  }

  static String getBookNameFromSlug(String slug, bool isUrdu) {
    final Map<String, (String, String)> books = {
      'sahih-bukhari': ('Sahih Bukhari', 'صحیح بخاری'),
      'sahih-muslim': ('Sahih Muslim', 'صحیح مسلم'),
      'al-tirmidhi': ('Jami\' At-Tirmidhi', 'جامع ترمذی'),
      'abu-dawood': ('Sunan Abu Dawud', 'سنن ابی داؤد'),
      'sunan-nasai': ('Sunan An-Nasa\'i', 'سنن نسائی'),
      'ibn-e-majah': ('Sunan Ibn Majah', 'سنن ابن ماجہ'),
    };
    final match = books[slug];
    if (match != null) {
      return isUrdu ? match.$2 : match.$1;
    }
    return slug;
  }
}
