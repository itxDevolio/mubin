import '../../domain/entities/chapter.dart';

class ChapterModel extends ChapterEntity {
  ChapterModel({
    required super.chapterNumber,
    required super.chapterEnglish,
    required super.chapterUrdu,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      chapterNumber: json['chapterNumber'].toString(),
      chapterEnglish: json['chapterEnglish'] ?? '',
      chapterUrdu: json['chapterUrdu'] ?? '',
    );
  }
}