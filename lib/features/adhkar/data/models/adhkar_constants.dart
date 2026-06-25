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
      arabic: 'آيَةُ الْكُرْسِي',
      english: 'Ayatul Kursi',
      urdu: 'آیت الکرسی',
      reference: 'Sahih al-Bukhari 2311',
      fazilatEnglish: """ who recites Ayat-al-Kursi (Al-Baqara:255) becomes safe
from Shaitan and Jinn and a guard is appointed for his
safety.""",
      fazilatUrdu: """255 پڑھنے والا شیطان اور جنات سے حفوظ ہو
جاتا ہے اور اُسکی حفاظت کیلئے ان ایک محافظ مقرر کر دیا جاتا ہے""",
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm2',
      arabic:
          'قُلْ هُوَ اللَّهُ أَحَدٌ،'
          ' قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ،'
          ' قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
      english: 'Recitation of the Three Muawwidhat',
      urdu: 'تینوں معوذات کی تلاوت',
      reference: 'Jami` at-Tirmidhi 3575, Sunan Abi Dawud 5082',
      fazilatEnglish:
          'The recitation of Muawwidhat will suffice you against everything (against Jinn and magic).',
      fazilatUrdu:
          'معوذات کی تلاوت (جنات اور جادو کے خلاف) ہر شے سے کافی ہو جاتی ہے۔',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm3',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      english:
          'There is none worthy of worship but Allah alone with no partner or associate, He is the dominion, to Him is praise and He has power over all things.',
      urdu:
          'نہیں کوئی معبود مگر اللہ، وہ اکیلا ہے، نہیں کوئی شریک اُسکا، اُسی کی بادشاہی ہے، اور اسی کے لئے سب تعریفیں ہیں، اور وہ ہر شے پر پوری طرح قدرت رکھتا ہے۔',
      reference: 'Sahih Muslim 6844, Sunan Abi Dawud 5077',
      fazilatEnglish:
          'The one who recites these words gets reward of freeing 4 slaves. And he is guarded against every dangerous thing and Shaitan during the entire day and night. (Note: Reciting 100 times everyday is the best practice - Bukhari: 6403, Muslim: 6842)',
      fazilatUrdu:
          'کلمات پڑھنے والے کو 4 غلام آزاد کرنے کا ثواب ملتا ہے اور تمام دن رات میں ہر خطرناک چیز اور شیطان کے خلاف اُسکا بچاؤ ہو جاتا ہے۔ (نوٹ: ہر روز 100 بار پڑھنا فضل ترین عمل ہے - بخاری: 6403، مسلم: 6842)',
      count: 0,
      targetCount: 10,
    ),
    DhikrEntity(
      id: 'm4',
      arabic:
          'رَضِيتُ بِاللهِ رَبَّا وَ بِالْإِسْلَامِ دِينًا وَبِمُحَمَّدٍ نَّبِيًّا',
      english:
          'We are pleased with Allah as our Lord, Islam as our religion, and Muhammad as our Messenger.',
      urdu:
          'راضی ہوں میں اللہ کے رب ہونے پر، اور اسلام کے دین ہونے پر، اور محمد ﷺ کے نبی ہونے پر۔',
      reference: 'Sunan Abi Dawud 5072, Musnad Ahmad 18990',
      fazilatEnglish:
          'The one who recites these words will surely get the Heaven and Allah will please him on the Day of Judgment. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے پر جنت واجب ہو جائیگی اور قیامت والے دن اللہ اسے خوش کر دے گا۔ (3 مرتبہ صبح اور شام)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm5',
      arabic:
          'بِسْمِ اللهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      english:
          'In the name of Allah with whose name nothing on earth or in the heaven can cause harm and He is the Hearing, the Knowing.',
      urdu:
          'اللہ کے نام کے ساتھ، جس کے نام کے ساتھ زمین و آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی، اور وہی سننے والا جاننے والا ہے۔',
      reference: 'Jami` at-Tirmidhi 3388, Sunan Abi Dawud 5088',
      fazilatEnglish:
          'Nothing can harm the person who recites these words nor will any sudden disaster reach him. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نہ تو کوئی شے نقصان پہنچا سکتی ہے اور نہ ہی کوئی اچانک ناگہانی مصیبت اُسے پہنچے گی۔ (3 مرتبہ صبح اور شام)',
      count: 0,
      targetCount: 3,
    ), // Number 6
    DhikrEntity(
      id: 'm6',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      english:
          'I seek refuge (of Allah) in the Perfect Words of Allah from the evil of that which He has created.',
      urdu:
          'میں اللہ کے کلماتِ کاملہ کی پناہ پکڑتا ہوں ہر اس چیز کے شر سے جو اُس نے پیدا کی۔',
      reference: 'Muslim 6880, Musnad Ahmad 7885',
      fazilatEnglish:
          'The sting of the poisonous animal will not cause harm to the person who recites these words. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زہریلے جانور کا ڈنگ نقصان نہیں پہنچا سکے گا۔ (3 مرتبہ صبح)',
      count: 0,
      targetCount: 3,
    ),
    // Number 7
    DhikrEntity(
      id: 'm7',
      arabic:
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَى نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
      english:
          'Glory and praise is to Allah, as much as the number of His creation, as much as pleases Him, as much as the weight of His Throne and as much as the ink of His words.',
      urdu:
          'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے، اپنی مخلوق کی گنتی کے برابر، اور اپنے نفس کی رضا کے برابر، اور اپنے عرش کے وزن کے برابر، اور اپنے کلمات کی سیاہی کے برابر۔',
      reference: 'Muslim 6913',
      fazilatEnglish:
          'The one who recites these words gets more reward than the person who worships continuously from the Fajr prayer till forenoon. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نمازِ فجر سے لے کر اشراق تک مسلسل عبادت کرنے والے شخص سے بھی زیادہ ثواب حاصل ہوتا ہے۔ (3 مرتبہ صبح)',
      count: 0,
      targetCount: 3,
    ),
    // Number 8
    DhikrEntity(
      id: 'm8',
      arabic:
          'اسْتَغْفِرُ اللهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَاتُوبُ إِلَيْهِ',
      english:
          'I seek Allah’s forgiveness. The One besides Whom there is none worthy of worship, the Ever-Living, the Sustainer, and I turn to Him in repentance.',
      urdu:
          'میں اللہ سے مغفرت طلب کرتا ہوں، نہیں کوئی معبود مگر وہ، خود سے زندہ، ہر چیز کو قائم رکھنے والا ہے اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      reference: 'Jami` at-Tirmidhi 3577, Sunan Abi Dawud 1517',
      fazilatEnglish:
          'All sins of the person who recites these words will be forgiven, even if he had fled the battle-field. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کے سارے گناہ معاف کر دیئے جائیں گے اگرچہ وہ شخص میدانِ جنگ سے بزدلی دکھا کر بھاگ چکا ہو۔ (3 مرتبہ صبح)',
      count: 0,
      targetCount: 3,
    ),
    // Number 9
    DhikrEntity(
      id: 'm9',
      arabic: 'اللَّهُمَّ أَجِرْنِي مِنَ النَّارِ',
      english: 'O Allah! Save me from Fire.',
      urdu: 'اے اللہ! بچا لے مجھ کو آگ (دوزخ) سے۔',
      reference: 'Sunan Abi Dawud 5079',
      fazilatEnglish:
          'Whoever recites these words at the end of Fajr prayer before speaking and dies that day, he will be free from the fire of Hell. (7 times, immediately after Fajr prayer.)',
      fazilatUrdu:
          'جو شخص نمازِ فجر کے بعد گفتگو سے پہلے یہ کلمات پڑھے اور اُسی دن اُسے موت آگئی تو دوزخ کی آگ سے آزاد ہوگا۔ (7 مرتبہ فجر کے فوراً بعد)',
      count: 0,
      targetCount: 7,
    ),
    // Number 10
    // 10
    DhikrEntity(
      id: 'm10',
      arabic:
          'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
      english:
          'O Allah! By You we have entered the morning, and by You we have entered the evening, and by You we live, and by You we die, and to You is the return.',
      urdu:
          'اے اللہ! ہم نے تیرے نام کے ساتھ صبح کی، اور تیری ہی طرف سے اٹھنا ہے۔',
      reference: 'Jami` at-Tirmidhi 3391',
      fazilatEnglish:
          'The Messenger of Allah would recite these 6 supplications.',
      fazilatUrdu: 'رسول اللہ ﷺ یہ 6 دُعائیں مانگتے تھے (تمام 1 مرتبہ)',
      count: 0,
      targetCount: 1,
    ),
    // 11
    DhikrEntity(
      id: 'm11',
      arabic:
          'أَصْبَحْنَا عَلَى فِطْرَةِ الْإِسْلامِ وَعَلَى كَلِمَةِ الْإِخْلَاصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيمَ حَنِيفًا مُسلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ',
      english:
          'We have entered the morning while we are on the innateness of Islam, the word of sincere devotion, the religion of our Prophet Muhammad and on the creed of our forefather Abraham, he was upright, and a Muslim. He was not from those who associate partners with Allah.',
      urdu:
          'ہم نے صبح کی فطرتِ اسلام پر، اور کلمہ اخلاص پر، اور ہمارے نبی محمد ﷺ کے دین پر، اور ہمارے باپ ابراہیم علیہ السلام کی ملت پر جو یکسو مسلم تھے اور مشرک نہ تھے۔',
      reference: 'Musnad Ahmad 15397',
      fazilatEnglish: 'Dhikr of the morning.',
      fazilatUrdu: 'صبح کے اذکار میں سے ایک دُعا۔',
      count: 0,
      targetCount: 1,
    ),
    // 12
    DhikrEntity(
      id: 'm12',
      arabic:
          'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابِ فِي الْقَبْرِ',
      english:
          'We have reached the morning and the Dominion belongs to Allah...',
      urdu:
          'ہم نے صبح کی اور اللہ کا ملک صبح ہوا... اے میرے رب! میں تجھ سے اس دن کی خیر مانگتا ہوں...',
      reference: 'Muslim 6908',
      fazilatEnglish: 'Asking for protection and goodness.',
      fazilatUrdu: 'دن بھر کی خیر اور برائی سے بچنے کی دُعا۔',
      count: 0,
      targetCount: 1,
    ), // 13
    DhikrEntity(
      id: 'm13',
      arabic:
          'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيْتُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
      english:
          'O Ever Living One, O Eternal One, by Your mercy I call on You. Set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.',
      urdu:
          'اے خود سے زندہ، ہر چیز کو قائم رکھنے والے میں تیری رحمت کے ساتھ تجھ سے مدد مانگتا ہوں۔ درست فرما دے میرے تمام کام اور مجھے پلک جھپکنے کے برابر بھی میرے نفس کے حوالے نہ کرنا۔',
      reference: 'Al-Mustadrak al-Hakim: 2000',
      count: 0,
      targetCount: 1,
    ),
    // 14
    DhikrEntity(
      id: 'm14',
      arabic:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي',
      english:
          'O Allah, I ask You for well being in this world and in the Hereafter. O Allah, I ask You for forgiveness and well being in my religious commitment, my worldly affairs, my family and my wealth. O Allah, conceal my fault and keep me safe from the things I fear. O Allah, protect me from in front and behind, from my right and my left and from above. I seek refuge in Your might from any unexpected harm coming from beneath me',
      urdu:
          'اے اللہ! میں تجھ سے سوال کرتا ہوں عافیت کا دنیا اور آخرت میں، اے اللہ! میں تجھ سے سوال کرتا ہوں معافی اور عافیت کا میرے دین میں اور میری دنیا میں اور میرے گھر والوں میں اور میرے مال میں۔ اے اللہ! پردہ ڈال میری چھپی چیزوں پر، اور امن دے میری گھبراہٹوں کو۔ اے اللہ! میری حفاظت فرما میرے آگے سے اور میرے پیچھے سے اور میرے دائیں سے اور میرے بائیں سے اور میرے اوپر سے۔ اور میں پناہ میں آتا ہوں تیری عظمت کی کہ اچانک نیچے سے ہلاک کر دیا جاؤں۔',
      reference: 'Sunan Abi Dawud: 5074',
      count: 0,
      targetCount: 1,
    ),
    // 15
    DhikrEntity(
      id: 'm15',
      arabic:
          'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ أَشْهَدُ أَنْ لَّا إِلَهَ إِلَّا أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ',
      english:
          'O Allah! Knower of the Unseen and the Seen, Originator of the heavens and the earth, Lord of everything and its Possessor also, I bear witness that there is none worthy of worship except You, I seek refuge in You from the evil of my soul and from the evil of Shaitan and his participation (in my works).',
      urdu:
          'اے اللہ! جاننے والے غیب اور حاضر کے، پیدا کرنے والے آسمانوں اور زمین کو، پالنے والے ہر چیز کے اور مالک بھی، میں گواہی دیتا ہوں کہ نہیں ہے کوئی معبود مگر تو، میں تیری پناہ میں آتا ہوں اپنے نفس کی برائی سے اور شیطان کے شر سے اور اسکے (میرے کاموں میں) شریک ہونے سے۔',
      reference: 'Jami` at-Tirmidhi: 3392',
      count: 0,
      targetCount: 1,
    ),
    // 16 (Sayyad ul Istighfar)
    DhikrEntity(
      id: 'm16',
      arabic:
          'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      english:
          'O Allah! You are my Lord, None has the right to be worshipped but You. You created me and I am Your slave, and I am faithful to my covenant and my promise (to You) as much as I can. I seek refuge with You from all the evil I have done. I acknowledge before You all the blessings You have bestowed upon me, and I confess to You all my sins. So I entreat You to forgive my sins, for nobody can forgive sins except You.',
      urdu:
          'اے اللہ! تو ہی میرا رب ہے، نہیں ہے کوئی معبود مگر تو، تو نے مجھے پیدا کیا، میں تیرا بندہ ہوں اور میں تیرے عہد اور وعدے پر (قائم) ہوں جس قدر میری طاقت ہے، میں تیری پناہ میں آتا ہوں اُس کے شر سے جو میں نے کیا، اپنے آپ پر تیری نعمت کا اقرار کرتا ہوں، اور اپنے گناہ کا اعتراف کرتا ہوں پس مجھے بخش دے کیونکہ نہیں ہے کوئی گناہوں کو بخشنے والا مگر تو۔',
      reference: 'Bukhari: 6306',
      count: 0,
      targetCount: 1,
    ),
    // 17
    DhikrEntity(
      id: 'm17',
      arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      english: 'Glory and praise is to Allah.',
      urdu: 'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے۔',
      reference: 'Bukhari: 6405, Muslim: 6842, 6843',
      count: 0,
      targetCount: 100,
    ),
    // 18
    DhikrEntity(
      id: 'm18',
      arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      english: 'I seek Allah’s forgiveness and I turn to Him in repentance.',
      urdu: 'میں اللہ سے مغفرت طلب کرتا ہوں اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      reference: 'Bukhari: 6307, Muslim: 6858',
      count: 0,
      targetCount: 100,
    ),
    // 19
    DhikrEntity(
      id: 'm19',
      arabic: 'سُبْحَانَ اللَّهِ',
      english: 'Glory be to Allah.',
      urdu: 'سبحان اللہ (100 غلام آزاد کرنے کا ثواب)',
      reference: 'Sunan an-Nasa\'i: 10680',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'm19_b',
      arabic: 'الْحَمْدُ لِلهِ',
      english: 'Praise be to Allah.',
      urdu: 'الحمد للہ (100 گھوڑے جہاد میں بھیجنے کا ثواب)',
      reference: 'Sunan an-Nasa\'i: 10680',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'm19_c',
      arabic: 'اللهُ أَكْبَرُ',
      english: 'Allah is the Greatest.',
      urdu: 'اللہ اکبر (100 اونٹ اللہ کی راہ میں قربان کرنے کا ثواب)',
      reference: 'Sunan an-Nasa\'i: 10680',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'm19_d',
      arabic: 'لَا إِلَهَ إِلَّا اللهُ',
      english: 'There is none worthy of worship but Allah.',
      urdu: 'لا الہ الا اللہ (زمین و آسمان کو بھر دیتا ہے)',
      reference: 'Sunan an-Nasa\'i: 10680',
      count: 0,
      targetCount: 100,
    ),
    // 20
    DhikrEntity(
      id: 'm20',
      arabic: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      english: 'There is no power and no strength except with Allah.',
      urdu:
          'نہیں ہے گناہ سے بچنے کی ہمت اور نہیں ہے نیکی کرنے کی طاقت مگر اللہ کی توفیق سے۔',
      reference: 'Bukhari: 6409, Muslim: 6862',
      count: 0,
      targetCount: 1,
    ),// 21
    DhikrEntity(id: 'm21', arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ', english: 'Allah is sufficient for us and He is the Best Disposer of Affairs.', urdu: 'ہم نے اللہ پر بھروسہ کیا اور وہی بہترین کارساز ہے۔', reference: 'Al-Imran: 173, Bukhari: 4563', fazilatEnglish: 'Recited by the Prophet in difficult situations.', fazilatUrdu: 'رسول اللہ ﷺ نے مشکل حالات میں یہ کلمات پڑھے۔', count: 0, targetCount: 1),
    // 22
    DhikrEntity(id: 'm22', arabic: 'سورة البقرة (آخری دو آیات)', english: 'Last 2 verses of Surah Al-Baqarah.', urdu: 'سورۃ البقرہ کی آخری آیات', reference: 'Bukhari: 4008, Muslim: 1878', fazilatEnglish: 'Sufficient for the slave.', fazilatUrdu: 'بندہ کے لئے نفع دینے میں کافی ہو جاتی ہے۔', count: 0, targetCount: 1),
    // 23
    DhikrEntity(id: 'm23', arabic: 'سورة الملك', english: 'Surah Al-Mulk.', urdu: 'سورۃ الملک', reference: 'Sunan Abi Dawud: 1400', fazilatEnglish: 'Will intercede for the person.', fazilatUrdu: 'سفارش کرتی رہے گی حتی کہ بخشش ہو جائے۔', count: 0, targetCount: 1),
    // 24
    DhikrEntity(id: 'm24', arabic: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ', english: 'Darood Sharif.', urdu: 'درود شریف (10 مرتبہ)', reference: 'Majma` az-Zawa\'id: 17022', fazilatEnglish: 'Deserves intercession of the Prophet.', fazilatUrdu: 'پڑھنے والا شخص شفاعت کا حقدار ہو جاتا ہے۔', count: 0, targetCount: 10),
    // 25
    DhikrEntity(id: 'm25', arabic: 'الحمد لله والصلاة والسلام على رسول الله', english: 'Praising Allah and sending Salat.', urdu: 'اللہ کی حمد اور درود و سلام', reference: 'Jami` at-Tirmidhi: 593', fazilatEnglish: 'Best source for acceptance of supplications.', fazilatUrdu: 'دُعاؤں کی قبولیت کا بہترین ذریعہ ہے۔', count: 0, targetCount: 1),
  ];

  static List<DhikrEntity> eveningAdhkar = [
    DhikrEntity(
      id: 'e1',
      arabic: 'آيَةُ الْكُرْسِي',
      english: 'Ayatul Kursi (2/255)',
      urdu: 'آیت الکرسی',
      reference: 'Sahih al-Bukhari 2311',
      fazilatEnglish: """ who recites Ayat-al-Kursi (Al-Baqara:255) becomes safe
from Shaitan and Jinn and a guard is appointed for his
safety.""",
      fazilatUrdu: """255 پڑھنے والا شیطان اور جنات سے حفوظ ہو
جاتا ہے اور اُسکی حفاظت کیلئے ان ایک محافظ مقرر کر دیا جاتا ہے""",
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'evening_muawwidhat',
      arabic:
          'قُلْ هُوَ اللَّهُ أَحَدٌ، قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
      english: 'Recitation of the Three Muawwidhat',
      urdu: 'تینوں معوذات کی تلاوت',
      reference: 'Jami` at-Tirmidhi 3575, Sunan Abi Dawud 5082',
      fazilatEnglish:
          'The recitation of Muawwidhat will suffice you against everything (against Jinn and magic).',
      fazilatUrdu:
          'معوذات کی تلاوت (جنات اور جادو کے خلاف) ہر شے سے کافی ہو جاتی ہے۔ (رات کے وقت ہاتھوں پر پھونک کر جسم پر مسح کرنا سنت ہے - بخاری: 5017)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e3',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      english:
          'There is none worthy of worship but Allah alone with no partner or associate, He is the dominion, to Him is praise and He has power over all things.',
      urdu:
          'نہیں کوئی معبود مگر اللہ، وہ اکیلا ہے، نہیں کوئی شریک اُسکا، اُسی کی بادشاہی ہے، اور اسی کے لئے سب تعریفیں ہیں، اور وہ ہر شے پر پوری طرح قدرت رکھتا ہے۔',
      reference: 'Sahih Muslim 6844, Sunan Abi Dawud 5077',
      fazilatEnglish:
          'The one who recites these words gets reward of freeing 4 slaves. And he is guarded against every dangerous thing and Shaitan during the entire day and night. (Note: Reciting 100 times everyday is the best practice - Bukhari: 6403, Muslim: 6842)',
      fazilatUrdu:
          'کلمات پڑھنے والے کو 4 غلام آزاد کرنے کا ثواب ملتا ہے اور تمام دن رات میں ہر خطرناک چیز اور شیطان کے خلاف اُسکا بچاؤ ہو جاتا ہے۔ (نوٹ: ہر روز 100 بار پڑھنا فضل ترین عمل ہے - بخاری: 6403، مسلم: 6842)',
      count: 0,
      targetCount: 10,
    ),
    DhikrEntity(
      id: 'e4',
      arabic:
          'رَضِيتُ بِاللهِ رَبَّا وَ بِالْإِسْلَامِ دِينًا وَبِمُحَمَّدٍ نَّبِيًّا',
      english:
          'We are pleased with Allah as our Lord, Islam as our religion, and Muhammad as our Messenger.',
      urdu:
          'راضی ہوں میں اللہ کے رب ہونے پر، اور اسلام کے دین ہونے پر، اور محمد ﷺ کے نبی ہونے پر۔',
      reference: 'Sunan Abi Dawud 5072, Musnad Ahmad 18990',
      fazilatEnglish:
          'The one who recites these words will surely get the Heaven and Allah will please him on the Day of Judgment. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے پر جنت واجب ہو جائیگی اور قیامت والے دن اللہ اسے خوش کر دے گا۔ (3 مرتبہ صبح اور شام)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e5',
      arabic:
          'بِسْمِ اللهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      english:
          'In the name of Allah with whose name nothing on earth or in the heaven can cause harm and He is the Hearing, the Knowing.',
      urdu:
          'اللہ کے نام کے ساتھ، جس کے نام کے ساتھ زمین و آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی، اور وہی سننے والا جاننے والا ہے۔',
      reference: 'Jami` at-Tirmidhi 3388, Sunan Abi Dawud 5088',
      fazilatEnglish:
          'Nothing can harm the person who recites these words nor will any sudden disaster reach him. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نہ تو کوئی شے نقصان پہنچا سکتی ہے اور نہ ہی کوئی اچانک ناگہانی مصیبت اُسے پہنچے گی۔ (3 مرتبہ صبح اور شام)',
      count: 0,
      targetCount: 3,
    ),
    // Number 6
    DhikrEntity(
      id: 'e6',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      english:
          'I seek refuge (of Allah) in the Perfect Words of Allah from the evil of that which He has created.',
      urdu:
          'میں اللہ کے کلماتِ کاملہ کی پناہ پکڑتا ہوں ہر اس چیز کے شر سے جو اُس نے پیدا کی۔',
      reference: 'Muslim 6880, Musnad Ahmad 7885',
      fazilatEnglish:
          'The sting of the poisonous animal will not cause harm to the person who recites these words. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زہریلے جانور کا ڈنگ نقصان نہیں پہنچا سکے گا۔ (3 مرتبہ شام)',
      count: 0,
      targetCount: 3,
    ),
    // Number 7
    DhikrEntity(
      id: 'e7',
      arabic:
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَى نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
      english:
          'Glory and praise is to Allah, as much as the number of His creation, as much as pleases Him, as much as the weight of His Throne and as much as the ink of His words.',
      urdu:
          'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے، اپنی مخلوق کی گنتی کے برابر، اور اپنے نفس کی رضا کے برابر، اور اپنے عرش کے وزن کے برابر، اور اپنے کلمات کی سیاہی کے برابر۔',
      reference: 'Muslim 6913',
      fazilatEnglish:
          'The one who recites these words gets more reward than the person who worships continuously from the Fajr prayer till forenoon. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زیادہ ثواب حاصل ہوتا ہے۔ (3 مرتبہ شام)',
      count: 0,
      targetCount: 3,
    ),
    // Number 8
    DhikrEntity(
      id: 'e8',
      arabic:
          'اسْتَغْفِرُ اللهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَاتُوبُ إِلَيْهِ',
      english:
          'I seek Allah’s forgiveness. The One besides Whom there is none worthy of worship, the Ever-Living, the Sustainer, and I turn to Him in repentance.',
      urdu:
          'میں اللہ سے مغفرت طلب کرتا ہوں، نہیں کوئی معبود مگر وہ، خود سے زندہ، ہر چیز کو قائم رکھنے والا ہے اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      reference: 'Jami` at-Tirmidhi 3577, Sunan Abi Dawud 1517',
      fazilatEnglish:
          'All sins of the person who recites these words will be forgiven. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کے سارے گناہ معاف کر دیئے جائیں گے۔ (3 مرتبہ شام)',
      count: 0,
      targetCount: 3,
    ),
    // Number 9
    DhikrEntity(
      id: 'e9',
      arabic: 'اللَّهُمَّ أَجِرْنِي مِنَ النَّارِ',
      english: 'O Allah! Save me from Fire.',
      urdu: 'اے اللہ! بچا لے مجھ کو آگ (دوزخ) سے۔',
      reference: 'Sunan Abi Dawud 5079',
      fazilatEnglish:
          'Whoever recites these words at the end of Maghrib prayer before speaking and if he dies that night, he will be free from the fire of Hell. (7 times, immediately after Maghrib prayer.)',
      fazilatUrdu:
          'جو شخص نمازِ مغرب کے بعد گفتگو سے پہلے یہ کلمات پڑھے اور اگر اُسی رات فوت ہو گیا تو دوزخ کی آگ سے آزاد ہوگا۔ (7 مرتبہ مغرب کے فوراً بعد)',
      count: 0,
      targetCount: 7,
    ),
    // Number 10
    // 10
    DhikrEntity(
      id: 'e10',
      arabic:
          'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
      english:
          'O Allah! By You we have entered the evening, and by You we have entered the morning, and by You we live, and by You we die, and to You is the return.',
      urdu:
          'اے اللہ! ہم نے تیرے نام کے ساتھ شام کی، اور تیری ہی طرف لوٹ کر جانا ہے۔',
      reference: 'Jami` at-Tirmidhi 3391',
      fazilatEnglish:
          'The Messenger of Allah would recite these 6 supplications.',
      fazilatUrdu: 'رسول اللہ ﷺ یہ 6 دُعائیں مانگتے تھے (تمام 1 مرتبہ)',
      count: 0,
      targetCount: 1,
    ),
    // 11
    DhikrEntity(
      id: 'e11',
      arabic:
          'أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلامِ وَعَلَى كَلِمَةِ الْإِخْلَاصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيمَ حَنِيفًا مُسلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ',
      english:
          'We have entered the evening while we are on the innateness of Islam...',
      urdu:
          'ہم نے شام کی فطرتِ اسلام پر، اور کلمہ اخلاص پر، اور ہمارے نبی محمد ﷺ کے دین پر...',
      reference: 'Musnad Ahmad 15397',
      fazilatEnglish: 'Dhikr of the evening.',
      fazilatUrdu: 'شام کے اذکار میں سے ایک دُعا۔',
      count: 0,
      targetCount: 1,
    ),
    // 12
    DhikrEntity(
      id: 'e12',
      arabic:
          'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابِ فِي الْقَبْرِ',
      english:
          'We have reached the evening and the Dominion belongs to Allah...',
      urdu:
          'ہم نے شام کی اور اللہ کا ملک شام ہوا... اے میرے رب! میں تجھ سے اس رات کی خیر مانگتا ہوں...',
      reference: 'Muslim 6908',
      fazilatEnglish: 'Asking for protection and goodness.',
      fazilatUrdu: 'رات بھر کی خیر اور برائی سے بچنے کی دُعا۔',
      count: 0,
      targetCount: 1,
    ),// 13
    DhikrEntity(id: 'e13', arabic: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيْتُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ', english: 'O Ever Living One, O Eternal One, by Your mercy I call on You. Set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.', urdu: 'اے خود سے زندہ، ہر چیز کو قائم رکھنے والے میں تیری رحمت کے ساتھ تجھ سے مدد مانگتا ہوں۔ درست فرما دے میرے تمام کام اور مجھے پلک جھپکنے کے برابر بھی میرے نفس کے حوالے نہ کرنا۔', reference: 'Al-Mustadrak al-Hakim: 2000', count: 0, targetCount: 1),
    // 14
    DhikrEntity(id: 'e14', arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي', english: 'O Allah, I ask You for well being in this world and in the Hereafter...', urdu: 'اے اللہ! میں تجھ سے سوال کرتا ہوں عافیت کا دنیا اور آخرت میں...', reference: 'Sunan Abi Dawud: 5074', count: 0, targetCount: 1),
    // 15
    DhikrEntity(id: 'e15', arabic: 'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ أَشْهَدُ أَنْ لَّا إِلَهَ إِلَّا أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ', english: 'O Allah! Knower of the Unseen and the Seen...', urdu: 'اے اللہ! جاننے والے غیب اور حاضر کے، پیدا کرنے والے آسمانوں اور زمین کو...', reference: 'Jami` at-Tirmidhi: 3392', count: 0, targetCount: 1),
    // 16
    DhikrEntity(id: 'e16', arabic: 'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ', english: 'O Allah! You are my Lord...', urdu: 'اے اللہ! تو ہی میرا رب ہے، نہیں ہے کوئی معبود مگر تو...', reference: 'Bukhari: 6306', count: 0, targetCount: 1),
    // 17
    DhikrEntity(id: 'e17', arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', english: 'Glory and praise is to Allah.', urdu: 'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے۔', reference: 'Bukhari: 6405, Muslim: 6842, 6843', count: 0, targetCount: 100),
    // 18
    DhikrEntity(id: 'e18', arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ', english: 'I seek Allah’s forgiveness and I turn to Him in repentance.', urdu: 'میں اللہ سے مغفرت طلب کرتا ہوں اور میں اُسی کی طرف توبہ کرتا ہوں۔', reference: 'Bukhari: 6307, Muslim: 6858', count: 0, targetCount: 100),
    // 19
    DhikrEntity(id: 'e19', arabic: 'سُبْحَانَ اللَّهِ', english: 'Glory be to Allah.', urdu: 'سبحان اللہ (100 غلام آزاد کرنے کا ثواب)', reference: 'Sunan an-Nasa\'i: 10680', count: 0, targetCount: 100),
    DhikrEntity(id: 'e19_b', arabic: 'الْحَمْدُ لِلهِ', english: 'Praise be to Allah.', urdu: 'الحمد للہ (100 گھوڑے جہاد میں بھیجنے کا ثواب)', reference: 'Sunan an-Nasa\'i: 10680', count: 0, targetCount: 100),
    DhikrEntity(id: 'e19_c', arabic: 'اللهُ أَكْبَرُ', english: 'Allah is the Greatest.', urdu: 'اللہ اکبر (100 اونٹ اللہ کی راہ میں قربان کرنے کا ثواب)', reference: 'Sunan an-Nasa\'i: 10680', count: 0, targetCount: 100),
    DhikrEntity(id: 'e19_d', arabic: 'لَا إِلَهَ إِلَّا اللهُ', english: 'There is none worthy of worship but Allah.', urdu: 'لا الہ الا اللہ (زمین و آسمان کو بھر دیتا ہے)', reference: 'Sunan an-Nasa\'i: 10680', count: 0, targetCount: 100),
    // 20
    DhikrEntity(id: 'e20', arabic: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ', english: 'There is no power and no strength except with Allah.', urdu: 'نہیں ہے گناہ سے بچنے کی ہمت اور نہیں ہے نیکی کرنے کی طاقت مگر اللہ کی توفیق سے۔', reference: 'Bukhari: 6409, Muslim: 6862', count: 0, targetCount: 1),

// 21
    DhikrEntity(id: 'e21', arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ', english: 'Allah is sufficient for us and He is the Best Disposer of Affairs.', urdu: 'ہم نے اللہ پر بھروسہ کیا اور وہی بہترین کارساز ہے۔', reference: 'Al-Imran: 173, Bukhari: 4563', fazilatEnglish: 'Recited by the Prophet in difficult situations.', fazilatUrdu: 'رسول اللہ ﷺ نے مشکل حالات میں یہ کلمات پڑھے۔', count: 0, targetCount: 1),
    // 22
    DhikrEntity(id: 'e22', arabic: 'سورة البقرة (آخری دو آیات)', english: 'Last 2 verses of Surah Al-Baqarah (1 time at night).', urdu: 'سورۃ البقرہ کی آخری آیات (رات 1 بار)', reference: 'Bukhari: 4008, Muslim: 1878', fazilatEnglish: 'Sufficient for the slave.', fazilatUrdu: 'بندہ کے لئے نفع دینے میں کافی ہو جاتی ہے۔', count: 0, targetCount: 1),
    // 23
    DhikrEntity(id: 'e23', arabic: 'سورة الملك', english: 'Surah Al-Mulk (1 time at night).', urdu: 'سورۃ الملک (رات 1 بار)', reference: 'Sunan Abi Dawud: 1400', fazilatEnglish: 'Will intercede for the person.', fazilatUrdu: 'سفارش کرتی رہے گی حتی کہ بخشش ہو جائے۔', count: 0, targetCount: 1),
    // 24
    DhikrEntity(id: 'e24', arabic: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ', english: 'Darood Sharif (10 times).', urdu: 'درود شریف (10 مرتبہ شام)', reference: 'Majma` az-Zawa\'id: 17022', fazilatEnglish: 'Deserves intercession of the Prophet.', fazilatUrdu: 'پڑھنے والا شخص شفاعت کا حقدار ہو جاتا ہے۔', count: 0, targetCount: 10),
    // 25
    DhikrEntity(id: 'e25', arabic: 'الحمد لله والصلاة والسلام على رسول الله', english: 'Praising Allah and sending Salat.', urdu: 'اللہ کی حمد اور درود و سلام', reference: 'Jami` at-Tirmidhi: 593', fazilatEnglish: 'Best source for acceptance of supplications.', fazilatUrdu: 'دُعاؤں کی قبولیت کا بہترین ذریعہ ہے۔', count: 0, targetCount: 1),

  ];

  static List<AdhkarCategory> categories = [
    AdhkarCategory(
      id: 'morning',
      titleEn: 'Morning Adhkar',
      titleUr: 'Morning Adhkar',

      dhikrs: morningAdhkar,
    ),
    AdhkarCategory(
      id: 'evening',
      titleEn: 'Evening Adhkar',
      titleUr: 'Evening Adhkar',
      dhikrs: eveningAdhkar,
    ),
  ];
}
