class GuideStep {
  final String stepNumber;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final String contentEn;
  final String contentUr;
  final String contentPs;
  final String? arabic;
  final String? translationEn;
  final String? translationUr;
  final String? translationPs;
  final String reference;
  final String? hanafiNoteEn;
  final String? hanafiNoteUr;
  final String? hanafiNotePs;
  final String? shafiNoteEn;
  final String? shafiNoteUr;
  final String? shafiNotePs;

  GuideStep({
    required this.stepNumber,
    required this.titleEn,
    required this.titleUr,
    this.titlePs = '',
    required this.contentEn,
    required this.contentUr,
    this.contentPs = '',
    this.arabic,
    this.translationEn,
    this.translationUr,
    this.translationPs,
    required this.reference,
    this.hanafiNoteEn,
    this.hanafiNoteUr,
    this.hanafiNotePs,
    this.shafiNoteEn,
    this.shafiNoteUr,
    this.shafiNotePs,
  });
}
