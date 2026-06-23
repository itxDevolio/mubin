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
    return BookModel(
      slug: json['bookSlug'] ?? '',
      bookName: json['bookName'] ?? '',
      bookNameUrdu: json['bookNameUrdu'] ?? '',
      writerName: json['writerName'] ?? '',
      totalHadith: json['totalHadith']?.toString() ?? '0',
    );
  }
}