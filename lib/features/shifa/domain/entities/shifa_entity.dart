class ShifaEntity {
  final String id;
  final String titleEn;
  final String titleUr;
  final String arabic;
  final String translationEn;
  final String translationUr;
  final String instructionEn;
  final String instructionUr;
  final int targetCount;

  ShifaEntity({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.arabic,
    required this.translationEn,
    required this.translationUr,
    required this.instructionEn,
    required this.instructionUr,
    this.targetCount = 1,
  });
}
