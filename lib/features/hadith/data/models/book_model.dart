import '../../domain/entities/book.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.slug,
    required super.bookName,
    required super.bookNameUrdu,
    required super.writerName,
    required super.totalHadith,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final slug = json['bookSlug'] ?? '';
    return BookModel(
      slug: slug,
      bookName: json['bookName'] ?? '',
      bookNameUrdu: _getUrduName(slug, json['bookName'] ?? ''),
      writerName: json['writerName'] ?? '',
      totalHadith: (json['hadiths_count'] ?? json['totalHadith'])?.toString() ?? '0',
    );
  }

  static String _getUrduName(String slug, String defaultName) {
    final Map<String, String> urduNames = {
      'sahih-bukhari': 'صحیح بخاری',
      'sahih-muslim': 'صحیح مسلم',
      'al-tirmidhi': 'جامع ترمذی',
      'abu-dawood': 'سنن ابی داؤد',
      'sunan-nasai': 'سنن نسائی',
      'ibn-e-majah': 'سنن ابن ماجہ',
      'mishkat': 'مشکوۃ المصابیح',
    };
    return urduNames[slug] ?? defaultName;
  }

  static String getUrduWriterName(String slug, String defaultWriter) {
    final Map<String, String> urduWriters = {
      'sahih-bukhari': 'امام بخاریؒ',
      'sahih-muslim': 'امام مسلمؒ',
      'al-tirmidhi': 'امام ترمذیؒ',
      'abu-dawood': 'امام ابو داؤدؒ',
      'sunan-nasai': 'امام نسائیؒ',
      'ibn-e-majah': 'امام ابن ماجہؒ',
    };
    return urduWriters[slug] ?? defaultWriter;
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
