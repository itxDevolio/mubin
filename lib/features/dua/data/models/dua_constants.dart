import '../../domain/entities/dua_entity.dart';

class DuaCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final List<DuaEntity> duas;

  DuaCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.duas,
  });
}

class DuaConstants {
  static List<DuaEntity> morningDuas = [
    DuaEntity(
      id: 'm1',
      titleEn: 'Upon Waking Up',
      titleUr: 'سو کر اٹھنے کی دعا',
      arabic: 'الْحَمْدُ للهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      translationEn: 'Praise is to Allah who gave us life after He had caused us to die and to Him is the return.',
      translationUr: 'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں مارنے (سلانے) کے بعد زندہ کیا اور اسی کی طرف لوٹ کر جانا ہے۔',
      reference: 'Sahih Bukhari',
    ),
  ];

  static List<DuaEntity> dailyDuas = [
    DuaEntity(
      id: 'd1',
      titleEn: 'Before Sleeping',
      titleUr: 'سونے کی دعا',
      arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      translationEn: 'In Your name, O Allah, I die and I live.',
      translationUr: 'اے اللہ! تیرے ہی نام کے ساتھ میں مرتا ہوں اور جیتا ہوں۔',
      reference: 'Sahih Bukhari',
    ),
    DuaEntity(
      id: 'd2',
      titleEn: 'Before Eating',
      titleUr: 'کھانا شروع کرنے کی دعا',
      arabic: 'بِسْمِ اللهِ',
      translationEn: 'In the name of Allah.',
      translationUr: 'اللہ کے نام سے۔',
      reference: 'Abu Dawud',
    ),
    DuaEntity(
      id: 'd3',
      titleEn: 'After Eating',
      titleUr: 'کھانے کے بعد کی دعا',
      arabic: 'الْحَمْدُ للهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
      translationEn: 'Praise is to Allah who has fed us and given us drink and made us Muslims.',
      translationUr: 'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں کھلایا اور پلایا اور ہمیں مسلمان بنایا۔',
      reference: 'Abu Dawud & Tirmidhi',
    ),
  ];

  static List<DuaEntity> toiletDuas = [
    DuaEntity(
      id: 't1',
      titleEn: 'Entering the Toilet',
      titleUr: 'بیت الخلا میں داخل ہونے کی دعا',
      arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
      translationEn: 'O Allah, I seek refuge in You from the male and female evil spirits.',
      translationUr: 'اے اللہ! میں تیری پناہ مانگتا ہوں خبیث جنوں اور جنیوں سے۔',
      reference: 'Sahih Bukhari & Muslim',
    ),
    DuaEntity(
      id: 't2',
      titleEn: 'Leaving the Toilet',
      titleUr: 'بیت الخلا سے نکلنے کی دعا',
      arabic: 'غُفْرَانَكَ',
      translationEn: 'I seek Your forgiveness.',
      translationUr: 'میں تجھ سے بخشش مانگتا ہوں۔',
      reference: 'Abu Dawud & Tirmidhi',
    ),
  ];

  static List<DuaCategory> categories = [
    DuaCategory(id: 'daily', titleEn: 'Daily Life', titleUr: 'روزمرہ کی دعائیں', duas: dailyDuas),
    DuaCategory(id: 'morning', titleEn: 'Morning & Evening', titleUr: 'صبح و شام', duas: morningDuas),
    DuaCategory(id: 'toilet', titleEn: 'Toilet', titleUr: 'بیت الخلا', duas: toiletDuas),
  ];

  static List<DuaEntity> allDuas = [
    ...dailyDuas,
    ...morningDuas,
    ...toiletDuas,
  ];
}
