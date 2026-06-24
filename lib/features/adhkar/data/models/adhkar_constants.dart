import '../../domain/entities/dhikr_entity.dart';

class AdhkarCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final List<DhikrEntity> dhikrs;

  AdhkarCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.dhikrs,
  });
}

class AdhkarConstants {
  static List<DhikrEntity> morningAdhkar = [
    DhikrEntity(
      id: 'm1',
      arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى کُلِّ شَیْءٍ قَدِیرٌ',
      english: 'We have entered a new day and with it all dominion is Allah\'s. All praise is due to Allah. None has the right to be worshipped but Allah alone, Who has no partner.',
      urdu: 'ہم نے صبح کی اور اللہ کے ملک نے صبح کی، اور تمام تعریفیں اللہ ہی کے لیے ہیں، اللہ کے سوا کوئی معبود نہیں وہ اکیلا ہے اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کی تعریف ہے اور وہ ہر چیز پر قادر ہے۔',
      reference: 'Sahih Muslim',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm2',
      arabic: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
      english: 'O Allah, by You we enter the morning and by You we enter the evening, by You we live and by You we die, and to You is the Final Return.',
      urdu: 'اے اللہ! تیری ہی مدد سے ہم نے صبح کی اور تیری ہی مدد سے ہم نے شام کی، اور تیری ہی مرضی سے ہم جیتے ہیں اور تیری ہی مرضی سے ہم مریں گے اور تیری ہی طرف اٹھ کر جانا ہے۔',
      reference: 'Tirmidhi',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm3',
      arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ',
      english: 'Glory is to Allah and praise is to Him, by the multitude of His creation, by His Pleasure, by the weight of His Throne, and by the extent of His Words.',
      urdu: 'اللہ پاک ہے اپنی تعریف کے ساتھ، اپنی مخلوق کی تعداد کے برابر، اپنی رضا کے مطابق، اپنے عرش کے وزن کے برابر اور اپنے کلمات کی سیاہی کے برابر۔',
      reference: 'Sahih Muslim',
      targetCount: 3,
    ),
  ];

  static List<DhikrEntity> eveningAdhkar = [
    DhikrEntity(
      id: 'e1',
      arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى کُلِّ شَیْءٍ قَدِیرٌ',
      english: 'We have entered the evening and with it all dominion is Allah\'s. All praise is due to Allah. None has the right to be worshipped but Allah alone.',
      urdu: 'ہم نے شام کی اور اللہ کے ملک نے شام کی، اور تمام تعریفیں اللہ ہی کے لیے ہیں، اللہ کے سوا کوئی معبود نہیں وہ اکیلا ہے اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کی تعریف ہے اور وہ ہر چیز پر قادر ہے۔',
      reference: 'Sahih Muslim',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e2',
      arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
      english: 'O Allah, by You we enter the evening and by You we enter the morning, by You we live and by You we die, and to You is the Final Return.',
      urdu: 'اے اللہ! تیری ہی مدد سے ہم نے شام کی اور تیری ہی مدد سے ہم نے صبح کی، اور تیری ہی مرضی سے ہم جیتے ہیں اور تیری ہی مرضی سے ہم مریں گے اور تیری ہی طرف لوٹنا ہے۔',
      reference: 'Tirmidhi',
      targetCount: 1,
    ),
  ];

  static List<DhikrEntity> generalAdhkar = [
    DhikrEntity(
      id: 'g1',
      arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
      english: 'Glory is to Allah and praise is to Him.',
      urdu: 'پاک ہے اللہ اپنی تعریف کے ساتھ۔',
      reference: 'Sahih Bukhari',
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'g2',
      arabic: 'أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ',
      english: 'I seek Allah\'s forgiveness and turn to Him in repentance.',
      urdu: 'میں اللہ سے بخشش مانگتا ہوں اور اسی کی طرف توبہ کرتا ہوں۔',
      reference: 'Sahih Bukhari & Muslim',
      targetCount: 100,
    ),
  ];

  static List<AdhkarCategory> categories = [
    AdhkarCategory(id: 'morning', titleEn: 'Morning Adhkar', titleUr: 'صبح کے اذکار', dhikrs: morningAdhkar),
    AdhkarCategory(id: 'evening', titleEn: 'Evening Adhkar', titleUr: 'شام کے اذکار', dhikrs: eveningAdhkar),
  ];
}
