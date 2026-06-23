import '../../domain/entities/hadith.dart';

class HadithModel extends HadithEntity {
  HadithModel({
    required super.id,
    required super.hadithNumber,
    required super.chapterNumber,
    required super.englishText,
    required super.urduText,
    required super.arabicText,
    required super.status,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'].toString(),
      hadithNumber: json['hadithNumber'].toString(),
      chapterNumber: json['chapter'].toString(),
      englishText: json['englishText'] ?? '',
      urduText: json['urduText'] ?? '',
      arabicText: json['arab'] ?? '',
      status: json['status'] ?? '',
    );
  }
}