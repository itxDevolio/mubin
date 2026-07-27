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
}