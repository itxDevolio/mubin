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
      arabic: 'بِاسْمِ اللَّهِ (ثَلَاثاً) أَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ (سَبْعاً)',
      translationEn: 'In the name of Allah (3 times). I seek refuge in Allah and His Power from the evil of what I find and of what I fear (7 times).',
      translationUr: 'اللہ کے نام کے ساتھ (3 مرتبہ)۔ میں اللہ اور اس کی قدرت کی پناہ مانگتا ہوں اس چیز کے شر سے جسے میں پاتا ہوں اور جس سے ڈرتا ہوں (7 مرتبہ)۔',
      instructionEn: 'Place your hand on the place where you feel pain and recite.',
      instructionUr: 'جس جگہ درد ہو وہاں ہاتھ رکھ کر پڑھیں۔',
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
      targetCount: 1,
    ),
    ShifaEntity(
      id: 's2',
      titleEn: 'Surah Al-Fatihah (The Cure)',
      titleUr: 'سورہ فاتحہ (شفاء)',
      arabic: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1) الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
      translationEn: 'In the name of Allah, the Entirely Merciful, the Especially Merciful. [All] praise is [due] to Allah, Lord of the worlds... (Complete Surah)',
      translationUr: 'شروع اللہ کے نام سے جو بڑا مہربان نہایت رحم والا ہے۔ سب تعریفیں اللہ ہی کے لیے ہیں جو تمام جہانوں کا رب ہے... (مکمل سورہ)',
      instructionEn: 'Recite 7 times and blow on the patient or water.',
      instructionUr: '7 مرتبہ پڑھ کر مریض یا پانی پر دم کریں۔',
      targetCount: 7,
    ),
  ];

  static List<ShifaEntity> protection = [
    ShifaEntity(
      id: 'pr1',
      titleEn: 'The Mu\'awwidhatayn',
      titleUr: 'معوذتین (سورہ فلق اور سورہ ناس)',
      arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ... قُلْ أَعُوذُ بِرَبِّ النَّاسِ...',
      translationEn: 'Say, "I seek refuge in the Lord of daybreak..." and Say, "I seek refuge in the Lord of mankind..."',
      translationUr: 'کہہ دیجئے! میں صبح کے رب کی پناہ مانگتا ہوں... کہہ دیجئے! میں لوگوں کے رب کی پناہ مانگتا ہوں...',
      instructionEn: 'Recite 3 times each and blow over your body.',
      instructionUr: '3، 3 مرتبہ پڑھ کر پورے جسم پر دم کریں۔',
      targetCount: 3,
    ),
  ];

  static List<ShifaCategory> categories = [
    ShifaCategory(id: 'pain', titleEn: 'Physical Pain', titleUr: 'جسمانی درد', duas: physicalPain),
    ShifaCategory(id: 'eye', titleEn: 'Evil Eye & Magic', titleUr: 'نظرِ بد اور جادو', duas: evilEye),
    ShifaCategory(id: 'sick', titleEn: 'Sickness & Healing', titleUr: 'بیماری اور شفا', duas: sickness),
    ShifaCategory(id: 'protect', titleEn: 'General Protection', titleUr: 'عمومی حفاظت', duas: protection),
  ];
  
  static List<ShifaEntity> allDuas = [
    ...physicalPain,
    ...evilEye,
    ...sickness,
    ...protection,
  ];
}
