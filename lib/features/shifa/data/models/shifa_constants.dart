import '../../domain/entities/shifa_entity.dart';

class ShifaCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final List<ShifaEntity> duas;

  ShifaCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.duas,
  });
}

class ShifaConstants {
  static List<ShifaEntity> physicalPain = [
    ShifaEntity(
      id: 'p1',
      titleEn: 'Pain in Body',
      titleUr: 'جسمانی درد کے لیے',
      arabic: 'بِاسْمِ اللَّهِ (3x)\nأَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ (7x)',
      translationEn: 'In the name of Allah (3 times). I seek refuge in Allah and His Power from the evil of what I find and of what I fear (7 times).',
      translationUr: 'اللہ کے نام کے ساتھ (3 مرتبہ)۔ میں اللہ اور اس کی قدرت کی پناہ مانگتا ہوں اس چیز کے شر سے جسے میں پاتا ہوں اور جس سے ڈرتا ہوں (7 مرتبہ)۔',
      instructionEn: 'Place your hand on the place where you feel pain and recite.',
      instructionUr: 'جس جگہ درد ہو وہاں ہاتھ رکھ کر پڑھیں۔',
      reference: 'Sahih Muslim',
      targetCount: 7,
    ),
  ];

  static List<ShifaEntity> evilEye = [
    ShifaEntity(
      id: 'e1',
      titleEn: 'Protection from Evil Eye',
      titleUr: 'نظرِ بد سے حفاظت',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ وَمِنْ كُلِّ عَيْنٍ لَامَّةٍ',
      translationEn: 'I seek refuge in the perfect words of Allah from every devil and every poisonous reptile, and from every evil eye.',
      translationUr: 'میں اللہ کے کامل کلمات کی پناہ مانگتا ہوں ہر شیطان اور زہریلے جانور سے اور ہر لگ جانے والی نظرِ بد سے۔',
      instructionEn: 'Recite and blow on the person or child.',
      instructionUr: 'پڑھ کر مریض یا بچے پر دم کریں۔',
      reference: 'Sahih Bukhari',
      targetCount: 3,
    ),
  ];

  static List<ShifaEntity> sickness = [
    ShifaEntity(
      id: 's1',
      titleEn: 'For Sickness/Fever',
      titleUr: 'بیماری اور بخار کے لیے',
      arabic: 'أَذْهِبِ الْبَاسَ رَبَّ النَّاسِ وَاشْفِ أَنْتَ الشَّافِي لَا شِفَاءَ إِلَّا شِفَاؤُكَ شِفَاءً لَا يُغَادِرُ سَقَماً',
      translationEn: 'Remove the suffering, O Lord of mankind, and heal, for You are the Healer. There is no healing but Your healing, a healing that leaves no illness.',
      translationUr: 'اے لوگوں کے رب! تکلیف دور کر دے اور شفا دے دے، تو ہی شفا دینے والا ہے، تیری شفا کے سوا کوئی شفا نہیں، ایسی شفا دے جو کوئی بیماری نہ چھوڑے۔',
      instructionEn: 'Recite and blow on the patient.',
      instructionUr: 'پڑھ کر مریض پر دم کریں۔',
      reference: 'Sahih Bukhari & Muslim',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 's2',
      titleEn: 'Visiting the Sick',
      titleUr: 'مریض کی عیادت کی دعا',
      arabic: 'لَا بَأْسَ طَهُورٌ إِنْ شَاءَ اللَّهُ',
      translationEn: 'No need to worry, it is a purification, if Allah wills.',
      translationUr: 'گھبرانے کی کوئی بات نہیں، یہ (بیماری) گناہوں سے پاک کرنے والی ہے، اگر اللہ نے چاہا۔',
      instructionEn: 'Say this when visiting a sick person.',
      instructionUr: 'مریض کی عیادت کرتے وقت یہ کہیں۔',
      reference: 'Sahih Bukhari',
      targetCount: 1,
    ),
  ];

  static List<ShifaCategory> categories = [
    ShifaCategory(id: 'pain', titleEn: 'Physical Pain', titleUr: 'جسمانی درد', duas: physicalPain),
    ShifaCategory(id: 'eye', titleEn: 'Evil Eye & Magic', titleUr: 'نظرِ بد اور جادو', duas: evilEye),
    ShifaCategory(id: 'sick', titleEn: 'Sickness & Healing', titleUr: 'بیماری اور شفا', duas: sickness),
  ];
  
  static List<ShifaEntity> allDuas = [
    ...physicalPain,
    ...evilEye,
    ...sickness,
  ];
}
