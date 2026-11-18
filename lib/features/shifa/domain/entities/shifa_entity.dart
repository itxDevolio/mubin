class ShifaEntity {
  final String id;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final String arabic;
  final String translationEn;
  final String translationUr;
  final String translationPs;
  final String instructionEn;
  final String instructionUr;
  final String instructionPs;
  final String reference;
  final int targetCount;

  ShifaEntity({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    this.titlePs = '',
    required this.arabic,
    required this.translationEn,
    required this.translationUr,
    this.translationPs = '',
    required this.instructionEn,
    required this.instructionUr,
    this.instructionPs = '',
    required this.reference,
    this.targetCount = 1,
  });
}
