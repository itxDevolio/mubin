class BookEntity {
  final String slug;
  final String bookName;
  final String bookNameUrdu;
  final String writerName; // Optional: API response mein ho to add karein
  final String totalHadith;

  BookEntity({
    required this.slug,
    required this.bookName,
    required this.bookNameUrdu,
    required this.writerName,
    required this.totalHadith,
  });
}