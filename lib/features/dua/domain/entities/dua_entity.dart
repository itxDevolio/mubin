class DuaEntity {
  final String id;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final String arabic;
  final String translationEn;
  final String translationUr;
  final String translationPs;
  final String reference;

  DuaEntity({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    this.titlePs = '',
    required this.arabic,
    required this.translationEn,
    required this.translationUr,
    this.translationPs = '',
    required this.reference,
  });
}

class DuaCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final List<DuaEntity> duas;

  DuaCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    this.titlePs = '',
    required this.duas,
  });
}
