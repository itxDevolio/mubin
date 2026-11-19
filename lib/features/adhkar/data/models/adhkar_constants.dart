import '../../domain/entities/dhikr_entity.dart';

class AdhkarCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final List<DhikrEntity> dhikrs;

  AdhkarCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.titlePs,
    required this.dhikrs,
  });
}

class AdhkarConstants {
  static List<DhikrEntity> morningAdhkar = [
    DhikrEntity(
      id: 'm1',
      arabic:
          'اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      english: 'Ayatul Kursi (Al-Baqara 2:255)',
      urdu: 'آیت الکرسی (سورۃ البقرہ: 255)',
      pashto: 'د آیت الکرسی تلاوت (سورة البقرة: ۲۵۵)',
      reference: 'Sahih al-Bukhari 2311',
      fazilatEnglish:
          """Who recites Ayat-al-Kursi becomes safe from Shaitan and Jinn and a guard is appointed for his safety.""",
      fazilatUrdu:
          """آیت الکرسی پڑھنے والا شیطان اور جنات سے محفوظ ہوجاتا ہے اور اُسکی حفاظت کیلئے اللہ کی طرف سے ایک محافظ مقرر کر دیا جاتا ہے۔""",
      fazilatPashto:
          """څوک چې آیت الکرسی ووایي د شیطان او پجنې (جناتو) څخه په امن وي او د هغه د ساتنې لپاره به یو ساتونکی وټاکل شي.""",
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm2',
      arabic:
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَٰهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ',
      english:
          'Recitation of the Three Muawwidhat (Surah Al-Ikhlas, Al-Falaq, An-Nas)',
      urdu: 'تینوں معوذات کی تلاوت (سورۃ الاخلاص، سورۃ الفلق، سورۃ الناس)',
      pashto:
          'د دریو واړو معوذاتو تلاوت (سورة الإخلاص، سورة الفلق، سورة الناس)',
      reference: 'Jami` at-Tirmidhi 3575',
      fazilatEnglish:
          'The recitation of Muawwidhat will suffice you against everything (against Jinn and magic).',
      fazilatUrdu:
          'تینوں معوذات کی تلاوت (جنات اور جادو کے خلاف) ہر شے سے کافی ہو جاتی ہے (صبح و شام 3 مرتبہ)',
      fazilatPashto:
          'د معوذاتو تلاوت به د هر شي (د جناتو او جادو) په وړاندې ستاسو لپاره بسنه وکړي (سهار او ماښام ۳ ځله).',
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
      pashto:
          'له الله پرته بل د عبادت لائق نشته، هغه یو دی، هیڅ شریک نه لري، ټول اختیار د هغه دی، او ټول تعریفونہ د هغه دي، او هغه پر هر شی پوره اختیار لري.',
      reference: '',
      fazilatEnglish:
          'The one who recites these words gets reward of freeing 10 slaves from the descendants of Ismail (peace be upon him). And he is guarded against every dangerous thing and Shaitan during the entire day and night. (Note: Reciting 100 times everyday is the best practice - Bukhari: 6403, Muslim: 6842)',
      fazilatUrdu:
          'کلمات پڑھنے والے کو اولادِ اسماعیل علیہ السلام میں سے 10 غلام آزاد کرنے کا ثواب ملتا ہے اور تمام دن رات میں ہر خطرناک چیز اور شیطان کے خلاف اُسکا بچاؤ ہو جاتا ہے۔ (نوٹ: ہر روز 100 بار پڑھنا فضل ترین عمل ہے - بخاری: 6403، مسلم: 6842)',
      fazilatPashto:
          'چا چې دا کلمات وویل، د اسماعیل علیه السلام د اولاد څخه د ۱۰ غلامانو د آزادولو ثواب ورته ورکول کیږي. او د ټولې ورځې او شپې لپاره د هر خطرناک شی او شیطان څخه ساتل کیږي. (نوټ: هره ورځ ۱۰۰ ځله لوستل غوره عمل دی - بخاری: ۶۴۰۳، مسلم: ۶۸۴۲)',
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
      pashto:
          'موږ راضي یو په دې چې الله زموږ رب دی، اسلام زموږ دین دی، او محمد زموږ پیغمبر دی.',
      reference: 'Sunan Abi Dawud 5072, Musnad Ahmad 18990',
      fazilatEnglish:
          'The one who recites these words will surely get the Heaven and Allah will please him on the Day of Judgment. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے پر جنت واجب ہو جائیگی اور قیامت والے دن اللہ اسے خوش کر دے گا۔ (3 مرتبہ صبح اور شام)',
      fazilatPashto:
          'څوک چې دا کلمات ووایي، جنت به یې حتماً په برخه شي او الله به د قیامت په ورځ خوښ کړي. (سهار او ماښام ۳ ځله)',
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
      pashto:
          'د هغه الله په نوم، چې د نوم سره یې په ځمکه او اسمان کې هېڅ شی نقصان نه شي رسولی، او هغه هر څه اورېدونکی او پر هر څه پوه دی.',
      reference: 'Jami` at-Tirmidhi 3388, Sunan Abi Dawud 5088',
      fazilatEnglish:
          'Nothing can harm the person who recites these words nor will any sudden disaster reach him. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نہ تو کوئی شے نقصان پہنچا سکتی ہے اور نہ ہی کوئی اچانک ناگہانی مصیبت اُسے پہنچے گی۔ (3 مرتبہ صبح اور شام)',
      fazilatPashto:
          'هغه کس ته چې دا کلمات ووایي هیڅ شی زیان نه شي رسولی او نه به کومه ناڅاپي بلا ورته ورسیږي. (سهار او ماښام ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm6',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      english:
          'I seek refuge (of Allah) in the Perfect Words of Allah from the evil of that which He has created.',
      urdu:
          'میں اللہ کے کلماتِ کاملہ کی پناہ پکڑتا ہوں ہر اس چیز کے شر سے جو اُس نے پیدا کی۔',
      pashto:
          'زه د الله په  کلماتو پناه غواړم د هر هغه شي له شره چې هغه پیدا کړی دی.',
      reference: 'Muslim 6880',
      fazilatEnglish:
          'The sting of the poisonous animal will not cause harm to the person who recites these words. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زہریلے جانور کا ڈنگ نقصان نہیں پہنچا سکے گا۔ (3 مرتبہ صبح)',
      fazilatPashto:
          'د زهرجن څاروي چیچلو به هغه کس ته زیان ونه رسوي چې دا کلمات ووایي. (سهار ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm7',
      arabic:
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَى نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
      english:
          'Glory and praise is to Allah, as much as the number of His creation, as much as pleases Him, as much as the weight of His Throne and as much as the ink of His words.',
      urdu:
          'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے، اپنی مخلوق کی گنتی کے برابر، اور اپنے نفس کی رضا کے برابر، اور اپنے عرش کے وزن کے برابر، اور اپنے کلمات کی سیاہی کے برابر۔',
      pashto:
          'پاکۍ او ستاینه د الله لپاره ده، د هغه د مخلوقاتو د شمیر په اندازه، د هغه د ځان د رضا په اندازه، د هغه د عرش د وزن په اندازه او د هغه د کلماتو د سیاهی په اندازه.',
      reference: 'Muslim 6913',
      fazilatEnglish:
          'The one who recites these words gets more reward than the person who worships continuously from the Fajr prayer till forenoon. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نمازِ فجر سے لے کر اشراق تک مسلسل عبادت کرنے والے شخص سے بھی زیادہ ثواب حاصل ہوتا ہے۔ (3 مرتبہ صبح)',
      fazilatPashto:
          'چا چې دا کلمات ووایي، د هغه چا په پرتله ډیر ثواب ترلاسه کوي چې د فجر له لمانځه څخه تر غرمې پورې په پرله پسې توګه عبادت کوي. (سهار ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm8',
      arabic:
          'اسْتَغْفِرُ اللهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَاتُوبُ إِلَيْهِ',
      english:
          'I seek Allah’s forgiveness. The One besides Whom there is none worthy of worship, the Ever-Living, the Sustainer, and I turn to Him in repentance.',
      urdu:
          'میں اللہ سے مغفرت طلب کرتا ہوں، نہیں کوئی معبود مگر وہ، خود سے زندہ، ہر چیز کو قائم رکھنے والا ہے اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      pashto:
          'زه له الله څخه بخښنه غواړم، هغه ذات چې له هغه پرته بل د عبادت وړ نشته، تل ژوندی، د هر څه قائم ساتونکی دی، او زه د هغه په لور توبه وباسم.',
      reference: 'Jami` at-Tirmidhi 3577, Sunan Abi Dawud 1517',
      fazilatEnglish:
          'All sins of the person who recites these words will be forgiven, even if he had fled the battle-field. (Recite 3 times in the morning.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کے سارے گناہ معاف کر دیئے جائیں گے اگرچہ وہ شخص میدانِ جنگ سے بزدلی دکھا کر بھاگ چکا ہو۔ (3 مرتبہ صبح)',
      fazilatPashto:
          'د هغه چا ټول ګناهونه به وبښل شي چې دا کلمات ووایي، که څه هم هغه د جګړې له ډګره تښتیدلی وي. (سهار ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'm9',
      arabic: 'اللَّهُمَّ أَجِرْنِي مِنَ النَّارِ',
      english: 'O Allah! Save me from Fire.',
      urdu: 'اے اللہ! بچا لے مجھ کو آگ (دوزخ) سے۔',
      pashto: 'اې الله! ما د اور (دوزخ) له عذابه وژغوره.',
      reference: 'Sunan Abi Dawud 5079',
      fazilatEnglish:
          'Whoever recites these words at the end of Fajr prayer before speaking and dies that day, he will be free from the fire of Hell. (7 times, immediately after Fajr prayer.)',
      fazilatUrdu:
          'جو شخص نمازِ فجر کے بعد گفتگو سے پہلے یہ کلمات پڑھے اور اُسی دن اُسے موت آگئی تو دوزخ کی آگ سے آزاد ہوگا۔ (7 مرتبہ فجر کے فوراً بعد)',
      fazilatPashto:
          'څوک چې دا کلمات د فجر له لمانځه وروسته له خبرو کولو مخکې ۷ ځله ووایي او په همغه ورځ مړ شي، د دوزخ له اوره به آزاد شي.',
      count: 0,
      targetCount: 7,
    ),
    DhikrEntity(
      id: 'm10',
      arabic:
          'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
      english:
          'O Allah! By You we have entered the morning, and by You we have entered the evening, and by You we live, and by You we die, and to You is the return.',
      urdu:
          'اے اللہ! ہم نے تیرے نام کے ساتھ صبح کی، اور تیری ہی طرف سے اٹھنا ہے۔',
      pashto:
          'اې الله! ستاسو په برکت موږ سهار وکړ، او ستاسو په برکت موږ ماښام وکړ، او ستاسو په برکت موږ ژوندي یو، او ستاسو په برکت موږ مړه کیږو، او ستاسو په لور ورتګ دی.',
      reference: 'Jami` at-Tirmidhi 3391',
      fazilatEnglish:
          'The Messenger of Allah would recite these 6 supplications.',
      fazilatUrdu: 'رسول اللہ ﷺ یہ 6 دُعائیں مانگتے تھے (تمام 1 مرتبہ)',
      fazilatPashto: 'رسول الله ﷺ دا ۶ دعاوې لوستلې.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm11',
      arabic:
          'أَصْبَحْنَا عَلَى فِطْرَةِ الْإِسْلامِ وَعَلَى كَلِمَةِ الْإِخْلَاصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيمَ حَنِيفًا مُسلِمًا وَمَا کَانَ مِنَ الْمُشْرِكِينَ',
      english:
          'We have entered the morning while we are on the innateness of Islam, the word of sincere devotion, the religion of our Prophet Muhammad and on the creed of our forefather Abraham, he was upright, and a Muslim. He was not from those who associate partners with Allah.',
      urdu:
          'ہم نے صبح کی فطرتِ اسلام پر، اور کلمہ اخلاص پر، اور ہمارے نبی محمد ﷺ کے دین پر، اور ہمارے باپ ابراہیم علیہ السلام کی ملت پر جو یکسو مسلم تھے اور مشرک نہ تھے۔',
      pashto:
          'موږ د اسلام په فطرت، د اخلاص په کلمه، زموږ د پیغمبر محمد ﷺ په دین، او زموږ د نیکه ابراهیم په ملت چې حنیف او مسلمان و، او له مشرکینو نه و، سهار وکړ.',
      reference: 'Musnad Ahmad 15360',
      fazilatEnglish: 'Dhikr of the morning.',
      fazilatUrdu: 'صبح کے اذکار میں سے ایک دُعا۔',
      fazilatPashto: 'د سهار اذکارو څخه یوه دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm12',
      arabic:
          'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابِ فِي الْقَبْرِ',
      english:
          'We have reached the morning and the Dominion belongs to Allah, and all praise is for Allah. There is no deity worthy of worship except Allah, alone, without partner. To Him belongs the dominion and to Him belongs all praise, and He is over all things Omnipotent. My Lord, I ask You for the good of this day and the good of what follows it, and I seek refuge in You from the evil of this day and the evil of what follows it. My Lord, I seek refuge in You from laziness and the hardships of old age. My Lord, I seek refuge in You from the punishment of the Fire and the punishment of the grave.',
      urdu:
          'ہم نے صبح کی اور صبح کے وقت سارا ملک اللہ ہی کا رہا، اور تمام تعریفیں اللہ ہی کے لیے ہیں۔ اللہ کے سوا کوئی معبودِ برحق نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تعریف ہے، اور وہ ہر چیز پر کامل قدرت رکھتا ہے۔ اے میرے رب! میں تجھ سے اس دن کی خیر اور اس کے بعد کی خیر کا سوال کرتا ہوں، اور میں اس دن کے شر اور اس کے بعد کے شر سے تیری پناہ مانگتا ہوں۔ اے میرے رب! میں سستی اور بڑھاپے کی خرابیوں سے تیری پناہ مانگتا ہوں۔ اے میرے رب! میں دوزخ کے عذاب سے اور قبر کے عذاب سے تیری پناہ مانگتا ہوں۔',
      pashto:
          'موږ سهار وکړ او ټول واک د الله لپاره دی، او ټول ستاینې د الله لپاره دي. له الله پرته بل د عبادت وړ نشته، هغه یو دی، شریک نه لري، ټول واک او ستاینې د هغه دي، او هغه پر هر شی واک لري. اې ربه! زه له تا څخه د دې ورځې او وروسته د خیر غوښتنه کوم، او د دې ورځې او وروسته د شر څخه پناه غواړم. اې ربه! زه له سستۍ او د زړښت له بدو شیانو پناه غواړم. اې ربه! زه د اور او قبر له عذابه پناه غواړم.',
      reference: 'Sahih Muslim 6908',
      fazilatEnglish:
          'A comprehensive prophetic morning prayer for general safety, well-being, and seeking refuge from physical and spiritual harms throughout the day.',
      fazilatUrdu:
          'دن بھر کی خیر و برکت پانے، اور سستی، برے بڑھاپے، عذابِ قبر و دوزخ سے بچنے کی بہترین مسنون دُعا۔',
      fazilatPashto:
          'د سهار جامع مسنون دعا د امن، برکت او د هر ډول شر څخه د پناه لپاره.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm13',
      arabic:
          'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيْتُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
      english:
          'O Ever Living One, O Eternal One, by Your mercy I call on You. Set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.',
      urdu:
          'اے خود سے زندہ، ہر چیز کو قائم رکھنے والے میں تیری رحمت کے ساتھ تجھ سے مدد مانگتا ہوں۔ درست فرما دے میرے تمام کام اور مجھے پلک جھپکنے کے برابر بھی میرے نفس کے حوالے نہ کرنا۔',
      pashto:
          'اې تل ژوندی، اې د هر څه ساتونکې، په خپله رحمت سره ستا مرسته غواړم. زما ټول کارونه سم کړه او د سترګو د پټولو په اندازه هم ما خپل نفس ته مه سپاره.',
      reference: 'Al-Mustadrak al-Hakim: 2000',
      fazilatPashto: 'د رسول الله ﷺ له خوا ویل شوې دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm14',
      arabic:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي',
      english:
          'O Allah, I ask You for well being in this world and in the Hereafter. O Allah, I ask You for forgiveness and well being in my religious commitment, my worldly affairs, my family and my wealth. O Allah, conceal my fault and keep me safe from the things I fear. O Allah, protect me from in front and behind, from my right and my left and from above. I seek refuge in Your might from any unexpected harm coming from beneath me',
      urdu:
          'اے اللہ! میں تجھ سے سوال کرتا ہوں عافیت کا دنیا اور آخرت میں، اے اللہ! میں تجھ سے سوال کرتا ہوں معافی اور عافیت کا میرے دین میں اور میری دنیا میں اور میرے گھر والوں میں اور میرے مال میں۔ اے اللہ! پردہ ڈال میری چھپی چیزوں پر، اور امن دے میری گھبراہٹوں کو۔ اے اللہ! میری حفاظت فرما میرے آگے سے اور میرے پیچھے سے اور میرے دائیں سے اور میرے بائیں سے اور میرے اوپر سے۔ اور میں پناہ میں آتا ہوں تیری عظمت کی کہ اچانک نیچے سے ہلاک کر دیا جاؤں۔',
      pashto:
          'اې الله! زه په دنیا او آخرت کې له تا څخه عافیت غواړم. اې الله! زه په خپل دین، دنیا، کورنۍ او مال کې له تا څخه بخښنه او عافیت غواړم. اې الله! زما عیبونه پټ کړه او زما ویرې په امن کړه. اې الله! زما مخکې، وروسته، ښي، کیڼ او پاس څخه زما ساتنه وکړه، او د ځمکې له لاندې څخه په ناڅاپي توګه د هلاکیدو څخه په ستا لویۍ پناه غواړم.',
      reference: 'Sunan Abi Dawud: 5074',
      fazilatPashto: 'د دنیا او آخرت د عافیت جامع دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm15',
      arabic:
          'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ أَشْهَدُ أَنْ لَّا إِلَهَ إِلَّا أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ',
      english:
          'O Allah! Knower of the Unseen and the Seen, Originator of the heavens and the earth, Lord of everything and its Possessor also, I bear witness that there is none worthy of worship except You, I seek refuge in You from the evil of my soul and from the evil of Shaitan and his participation (in my works).',
      urdu:
          'اے اللہ! جاننے والے غیب اور حاضر کے، پیدا کرنے والے آسمانوں اور زمین کو، پالنے والے ہر چیز کے اور مالک بھی، میں گواہی دیتا ہوں کہ نہیں ہے کوئی معبود مگر تو، میں تیری پناہ میں آتا ہوں اپنے نفس کی برائی سے اور شیطان کے شر سے اور اسکے (میرے کاموں میں) شریک ہونے سے۔',
      pashto:
          'اې الله! د پټو او ښکاره پوهه، د اسمانونو او ځمکې پیدا کونکي، د هر شی رب او مالک، زه شهادت ورکوم چې له تا پرته بل خدای نشته، زه د خپل نفس او د شیطان او د هغه د شریکولو له شره په تا پناه غواړم.',
      reference: 'Jami` at-Tirmidhi: 3392',
      fazilatPashto: 'د غیب او شهادت د پوه په دربار کې پناه غوښتنه.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm16',
      arabic:
          'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      english:
          'O Allah! You are my Lord, None has the right to be worshipped but You. You created me and I am Your slave, and I am faithful to my covenant and my promise (to You) as much as I can. I seek refuge with You from all the evil I have done. I acknowledge before You all the blessings You have bestowed upon me, and I confess to You all my sins. So I entreat You to forgive my sins, for nobody can forgive sins except You.',
      urdu:
          'اے اللہ! تو ہی میرا رب ہے، نہیں ہے کوئی معبود مگر تو، تو نے مجھے پیدا کیا، میں تیرا بندہ ہوں اور میں تیرے عہد اور وعدے پر (قائم) ہوں جس قدر میری طاقت ہے، میں تیری پناہ میں آتا ہوں اُس کے شر سے جو میں نے کیا، اپنے آپ پر تیری نعمت کا اقرار کرتا ہوں، اور اپنے گناہ کا اعتراف کرتا ہوں پس مجھے بخش دے کیونکہ نہیں ہے کوئی گناہوں کو بخشنے والا مگر تو۔',
      pashto:
          'اې الله! ته زما رب یې، له تا پرته بل معبود نشته، ته ما پیدا کړی او زه بنده ستا یم، او زه تر هغه ځایه چې توان لرم د خپل عهد او ژمنې په سر ولاړ یم. زه له هر هغه شر څخه چې ما کړی دی په تا پناه غواړم. په ما باندې د ستا نعمتونو او په خپل ځان د ګناه اعتراف کوم، نو ما وبښه ځکه چې له تا پرته بل څوک ګناهونه نه بخښي.',
      reference: 'Bukhari: 6306',
      fazilatPashto: 'سید الاستغفار (په سهار او ماښام کې لوستل کیږي).',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm17',
      arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      english: 'Glory and praise is to Allah.',
      urdu: 'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے۔',
      pashto: 'پاکۍ او ستاینه د الله لپاره ده.',
      reference: 'Bukhari: 6405, Muslim: 6842, 6843',
      fazilatPashto: 'د الله ذکر.',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'm18',
      arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      english: 'I seek Allah’s forgiveness and I turn to Him in repentance.',
      urdu: 'میں اللہ سے مغفرت طلب کرتا ہوں اور میں اُسی کی طرف توبہ کرتا ہو۔',
      pashto: 'زه له الله څخه بخښنه غواړم او د هغه په لور توبه وباسم.',
      reference: 'Bukhari: 6307, Muslim: 6858',
      fazilatPashto: 'استغفار.',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'm19',
      arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      english:
          'Allah is sufficient for us and He is the Best Disposer of Affairs.',
      urdu: 'ہم نے اللہ پر بھروسہ کیا اور وہی بہترین کارساز ہے۔',
      pashto: 'الله موږ ته بس دی او هغه تر ټولو ښه کارساز دی.',
      reference: 'Al-Imran: 173, Bukhari: 4563',
      fazilatEnglish: 'Recited by the Prophet in difficult situations.',
      fazilatUrdu: 'رسول اللہ ﷺ نے مشکل حالات میں یہ کلمات پڑھے۔',
      fazilatPashto: 'په سختو حالاتو کې د پیغمبر لخوا لوستل کیده.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'm20',
      arabic: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
      english: 'O Allah, send blessings and peace upon our Prophet Muhammad.',
      urdu: 'اے اللہ! ہمارے نبی محمد ﷺ پر رحمتیں اور سلامتی نازل فرما۔',
      pashto: 'اې الله! زموږ پر پیغمبر محمد ﷺ درود او سلام نازل کړه.',
      reference: 'Al-Mu\'jam al-Kabir lilt-Tabarani, Hisn al-Muslim 91',
      fazilatEnglish:
          'Whoever recites it 10 times in the morning and 10 times in the evening will attain the intercession of the Prophet on the Day of Resurrection.',
      fazilatUrdu:
          'جو شخص صبح اور شام 10، 10 مرتبہ درود بھیجے گا، قیامت کے دن اسے رسول اللہ ﷺ کی شفاعت نصیب ہوگی۔',
      fazilatPashto:
          'څوک چې دا په سهار او ماښام ۱۰ ځله ووایي، د قیامت په ورځ به د پیغمبر شفاعت ترلاسه کړي.',
      count: 0,
      targetCount: 10,
    ),
  ];

  static List<DhikrEntity> eveningAdhkar = [
    DhikrEntity(
      id: 'e1',
      arabic:
          'اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      english: 'Ayatul Kursi (Al-Baqara 2:255)',
      urdu: 'آیت الکرسی (سورۃ البقرہ: 255)',
      pashto: 'د آیت الکرسی تلاوت (سورة البقرة: ۲۵۵)',
      reference: 'Sahih al-Bukhari 2311',
      fazilatEnglish:
          """Who recites Ayat-al-Kursi becomes safe from Shaitan and Jinn and a guard is appointed for his safety.""",
      fazilatUrdu:
          """آیت الکرسی پڑھنے والا شیطان اور جنات سے محفوظ ہوجاتا ہے اور اُسکی حفاظت کیلئے اللہ کی طرف سے ایک محافظ مقرر کر دیا جاتا ہے۔""",
      fazilatPashto:
          """څوک چې آیت الکرسی ووایي د شیطان او پجنې (جناتو) څخه په امن وي او د هغه د ساتنې لپاره به یو ساتونکی وټاکل شي.""",
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'evening_muawwidhat',
      arabic:
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَٰهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ',
      english:
          'Recitation of the Three Muawwidhat (Surah Al-Ikhlas, Al-Falaq, An-Nas)',
      urdu: 'تینوں معوذات کی تلاوت (سورۃ الاخلاص، سورۃ الفلق، سورۃ الناس)',
      pashto:
          'د دریو واړو معوذاتو تلاوت (سورة الإخلاص، سورة الفلق، سورة الناس)',
      reference: 'Jami` at-Tirmidhi 3575',
      fazilatEnglish:
          'The recitation of Muawwidhat will suffice you against everything (against Jinn and magic).',
      fazilatUrdu:
          'معوذات کی تلاوت (جنات اور جادو کے خلاف) هر شے سے کافی ہو جاتی ہے (صبح و شام 3 مرتبہ)',
      fazilatPashto:
          'د معوذاتو تلاوت به د هر شي (د جناتو او جادو) په وړاندې ستاسو لپاره بسنه وکړي (سهار او ماښام ۳ ځله).',
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
      pashto:
          'له الله پرته بل د عبادت لائق نشته، هغه یو دی، هیڅ شریک نه لري، ټول اختیار د هغه دی، او ټول تعریفونہ د هغه دي، او هغه پر هر شی پوره اختیار لري.',
      reference: 'Sahih Muslim 6844, Sunan Abi Dawud 5082',
      fazilatEnglish:
          'The one who recites these words gets reward of freeing 4 slaves. And he is guarded against every dangerous thing and Shaitan during the entire day and night.',
      fazilatUrdu:
          'کلمات پڑھنے والے کو 4 غلام آزاد کرنے کا ثواب ملتا ہے اور تمام دن رات میں ہر خطرناک چیز اور شیطان کے خلاف اُسکا بچاؤ ہو جاتا ہے۔',
      fazilatPashto:
          'چا چې دا کلمات وویل، د ۴ غلامانو د آزادولو ثواب ورته ورکول کیږي. او د ټولې ورځې او شپې لپاره د هر خطرناک شی او شیطان څخه ساتل کیږي.',
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
      pashto:
          'موږ راضي یو په دې چې الله زموږ رب دی، اسلام زموږ دین دی، او محمد زموږ پیغمبر دی.',
      reference: 'Sunan Abi Dawud 5072, Musnad Ahmad 18990',
      fazilatEnglish:
          'The one who recites these words will surely get the Heaven and Allah will please him on the Day of Judgment. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے پر جنت واجب ہو جائیگی اور قیامت والے دن اللہ اسے خوش کر دے گا۔ (3 مرتبہ صبح اور شام)',
      fazilatPashto:
          'څوک چې دا کلمات ووایي، جنت به یې حتماً په برخه شي او الله به د قیامت په ورځ خوښ کړي. (سهار او ماښام ۳ ځله)',
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
      pashto:
          "'د هغه الله په نوم، چې د نوم سره یې په ځمکه او اسمان کې هېڅ شی نقصان نه شي رسولی، او هغه هر څه اورېدونکی او پر هر څه پوه دی.',",
      reference: 'Sunan Abi Dawud 5088',
      fazilatEnglish:
          'Nothing can harm the person who recites these words nor will any sudden disaster reach him. (Recite 3 times in the morning and in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو نہ تو کوئی شے نقصان پہنچا سکتی ہے اور نہ ہی کوئی اچانک ناگہانی مصیبت اُسے پہنچے گی۔ (3 مرتبہ صبح اور شام)',
      fazilatPashto:
          'هغه کس ته چې دا کلمات ووایي هیڅ شی زیان نه شي رسولی او نه به کومه ناڅاپي بلا ورته ورسیږي. (سهار او ماښام ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e6',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      english:
          'I seek refuge (of Allah) in the Perfect Words of Allah from the evil of that which He has created.',
      urdu:
          'میں اللہ کے کلماتِ کاملہ کی پناہ پکڑتا ہوں ہر اس چیز کے شر سے جو اُس نے پیدا کی۔',
      pashto:
          'زه د خدای په پوره خبرو (کلماتو) پناه غواړم، د هر پیدا شوي شي له بدۍ او تاوان',
      reference: 'Muslim 6880',
      fazilatEnglish:
          'The sting of the poisonous animal will not cause harm to the person who recites these words. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زہریلے جانور کا ڈنگ نقصان نہیں پہنچا سکے گا۔ (3 مرتبہ شام)',
      fazilatPashto:
          'د زهرجن څاروي چیچلو به هغه کس ته زیان ونه رسوي چې دا کلمات ووایي. (ماښام ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e7',
      arabic:
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَى نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
      english:
          'Glory and praise is to Allah, as much as the number of His creation, as much as pleases Him, as much as the weight of His Throne and as much as the ink of His words.',
      urdu:
          'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے، اپنی مخلوق کی گنتی کے برابر، اور اپنے نفس کی رضا کے برابر، اور اپنے عرش کے وزن کے برابر، اور اپنے کلمات کی سیاہی کے برابر۔',
      pashto:
          'پاکۍ او ستاینه د الله لپاره ده، د هغه د مخلوقاتو د شمیر په اندازه، د هغه د ځان د رضا په اندازه، د هغه د عرش د وزن په اندازه او د هغه د کلماتو د سیاهی په اندازه.',
      reference: 'Muslim 6913',
      fazilatEnglish:
          'The one who recites these words gets more reward than the person who worships continuously from the Fajr prayer till forenoon. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کو زیادہ ثواب حاصل ہوتا ہے۔ (3 مرتبہ شام)',
      fazilatPashto: 'چا چې دا کلمات ووایي، ډیر ثواب ترلاسه کوي. (ماښام ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e8',
      arabic:
          'اسْتَغْفِرُ اللهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَاتُوبُ إِلَيْهِ',
      english:
          'I seek Allah’s forgiveness. The One besides Whom there is none worthy of worship, the Ever-Living, the Sustainer, and I turn to Him in repentance.',
      urdu:
          'میں اللہ سے مغفرت طلب کرتا ہوں، نہیں کوئی معبود مگر وہ، خود سے زندہ، ہر چیز کو قائم رکھنے والا ہے اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      pashto:
          'زه له الله څخه بخښنه غواړم، هغه ذات چې له هغه پرته بل د عبادت وړ نشته، تل ژوندی، د هر څه قائم ساتونکی دی، او زه د هغه په لور توبه وباسم.',
      reference: 'Jami` at-Tirmidhi 3577, Sunan Abi Dawud 1517',
      fazilatEnglish:
          'All sins of the person who recites these words will be forgiven. (Recite 3 times in the evening.)',
      fazilatUrdu:
          'یہ کلمات پڑھنے والے کے سارے گناہ معاف کر دیئے جائیں گے۔ (3 مرتبہ شام)',
      fazilatPashto:
          'د دې کلماتو په ویلو سره ټول ګناهونه بښل کیږي. (ماښام ۳ ځله)',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'e9',
      arabic: 'اللَّهُمَّ أَجِرْنِي مِنَ النَّارِ',
      english: 'O Allah! Save me from Fire.',
      urdu: 'اے اللہ! بچا لے مجھ کو آگ (دوزخ) سے۔',
      pashto: 'اې الله! ما د اور (دوزخ) له عذابه وژغوره.',
      reference: 'Sunan Abi Dawud 5079',
      fazilatEnglish:
          'Whoever recites these words at the end of Maghrib prayer before speaking and if he dies that night, he will be free from the fire of Hell. (7 times, immediately after Maghrib prayer.)',
      fazilatUrdu:
          'جو شخص نمازِ مغرب کے بعد گفتگو سے پہلے یہ کلمات پڑھے اور اگر اُسی رات فوت ہو گیا تو دوزخ کی آگ سے آزاد ہوگا۔ (7 مرتبہ مغرب کے فوراً بعد)',
      fazilatPashto:
          'څوک چې دا کلمات د ماښام له لمانځه وروسته له خبرو کولو مخکې ۷ ځله ووایي او په همغه شپه مړ شي، د دوزخ له اوره به آزاد شي.',
      count: 0,
      targetCount: 7,
    ),
    DhikrEntity(
      id: 'e10',
      arabic:
          'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
      english:
          'O Allah! By You we have entered the evening, and by You we have entered the morning, and by You we live, and by You we die, and to You is the return.',
      urdu:
          'اے اللہ! ہم نے تیرے نام کے ساتھ شام کی، اور تیری ہی طرف لوٹ کر جانا ہے۔',
      pashto:
          'اې الله! ستاسو په برکت موږ ماښام وکړ، او ستاسو په برکت موږ سهار وکړ، او ستاسو په برکت موږ ژوندي یو، او ستاسو په برکت موږ مړه کیږو، او ستاسو په لور ورتګ دی.',
      reference: 'Jami` at-Tirmidhi 3391',
      fazilatEnglish:
          'The Messenger of Allah would recite these 6 supplications.',
      fazilatUrdu: 'رسول اللہ ﷺ یہ 6 دُعائیں مانگتے تھے (تمام 1 مرتبہ)',
      fazilatPashto: 'رسول الله ﷺ دا ۶ دعاوې لوستلې.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e11',
      arabic:
          'أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلامِ وَعَلَى کَلِمَةِ الْإِخْلَاصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيمَ حَنِيفًا مُسلِمًا وَمَا کَانَ مِنَ الْمُشْرِكِينَ',
      english:
          'We have entered the evening while we are on the innateness of Islam...',
      urdu:
          'ہم نے شام کی فطرتِ اسلام پر، اور کلمہ اخلاص پر، اور ہمارے نبی محمد ﷺ کے دین پر...',
      pashto:
          'موږ د اسلام په فطرت، د اخلاص په کلمه، زموږ د پیغمبر محمد ﷺ په دین، او زموږ د نیکه ابراهیم په ملت چې حنیف او مسلمان و، او له مشرکینو نه و، ماښام وکړ.',
      reference: 'Musnad Ahmad 15360',
      fazilatEnglish: 'Dhikr of the evening.',
      fazilatUrdu: 'شام کے اذکار میں سے ایک دُعا۔',
      fazilatPashto: 'د ماښام اذکارو څخه یوه دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e12',
      arabic:
          'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابِ فِي الْقَبْرِ',
      english:
          'We have reached the evening and the Dominion belongs to Allah, and all praise is for Allah. There is no deity worthy of worship except Allah, alone, without partner. To Him belongs the dominion and to Him belongs all praise, and He is over all things Omnipotent. My Lord, I ask You for the good of this night and the good of what follows it, and I seek refuge in You from the evil of this night and the evil of what follows it. My Lord, I seek refuge in You from laziness and the hardships of old age. My Lord, I seek refuge in You from the punishment of the Fire and the punishment of the grave.',
      urdu:
          'ہم نے شام کی اور شام کے وقت سارا ملک اللہ ہی کا رہا، اور تمام تعریفیں اللہ ہی کے لیے ہیں۔ اللہ کے سوا کوئی معبودِ برحق نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تعریف ہے، اور وہ ہر چیز پر کامل قدرت رکھتا ہے۔ اے میرے رب! میں تجھ سے اس رات کی خیر اور اس کے بعد کی خیر کا سوال کرتا ہوں، اور میں اس رات کے شر اور اس کے بعد کے شر سے تیری پناہ مانگتا ہوں۔ اے میرے رب! میں سستی اور بڑھاپے کی خرابیوں سے تیری پناہ مانگتا ہوں۔ اے میرے رب! میں دوزخ کے عذاب سے اور قبر کے عذاب سے تیری پناہ مانگتا ہوں۔',
      pashto:
          'موږ ماښام وکړ او ټول واک د الله لپاره دی، او ټول ستاینې د الله لپاره دي. له الله پرته بل د عبادت وړ نشته، هغه یو دی، شریک نه لري، ټول واک او ستاینې د هغه دي، او هغه پر هر شی واک لري. اې ربه! زه له تا څخه د دې شپې او وروسته د خیر غوښتنه کوم، او د دې شپې او وروسته د شر څخه پناه غواړم. اې ربه! زه له سستۍ او د زړښت له بدو شیانو پناه غواړم. اې ربه! زه د اور او قبر له عذابه پناه غواړم.',
      reference: 'Sahih Muslim 6908',
      fazilatEnglish:
          'A comprehensive prophetic evening prayer for general safety, well-being, and seeking refuge from physical and spiritual harms.',
      fazilatUrdu:
          'رات بھر کی خیر و برکت پانے، اور سستی، برے بڑھاپے، عذابِ قبر و دوزخ سے بچنے کی بہترین مسنون دُعا۔',
      fazilatPashto:
          'د ماښام جامع مسنون دعا د امن، برکت او د هر ډول شر څخه د پناه لپاره.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e13',
      arabic:
          'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيْتُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
      english:
          'O Ever Living One, O Eternal One, by Your mercy I call on You. Set right all my affairs. Do not place me in charge of my soul even for the blinking of an eye.',
      urdu:
          'اے خود سے زندہ، ہر چیز کو قائم رکھنے والے میں تیری رحمت کے ساتھ تجھ سے مدد مانگتا ہوں۔ درست فرما دے میرے تمام کام اور مجھے پلک جھپکنے کے برابر بھی میرے نفس کے حوالے نہ کرنا۔',
      pashto:
          'اې تل ژوندی، اې د هر څه ساتونکې، په خپله رحمت سره ستا مرسته غواړم. زما ټول کارونه سم کړه او د سترګو د پټولو في اندازه هم ما خپل نفس ته مه سپاره.',
      reference: 'Al-Mustadrak al-Hakim: 2000',
      fazilatPashto: 'د رسول الله ﷺ له خوا ویل شوې دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e14',
      arabic:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي',
      english:
          'O Allah, I ask You for well being in this world and in the Hereafter...',
      urdu:
          "اے اللہ! میں تجھ سے دنیا اور آخرت میں عافیت (سلامتی) مانگتا ہوں۔ اے اللہ! میں تجھ سے اپنے دین، اپنی دنیا، اپنے گھر والوں اور اپنے مال میں معافی اور عافیت کا سوال کرتا ہوں۔ اے اللہ! میرے عیبوں پر پردہ ڈال دے اور میرے خوف (اور گھبراہٹ) کو امن میں بدل دے۔ اے اللہ! میری حفاظت فرما میرے آگے سے، میرے پیچھے سے، میری دائیں جانب سے، میری بائیں جانب سے اور میرے اوپر سے، اور میں تیری عظمت کی پناہ مانگتا ہوں اس بات سے کہ میں اپنے نیچے سے (اچانک) ہلاک کیا جاؤں۔",
      pashto:
          "اې الله! زه له تا څخه په دنیا او اخرت کې عافیت (روغتیا او سلامتیا) غواړم. اې الله! زه له تا څخه په خپل دین، خپله دنیا، خپله کورنۍ او خپل مال کې بخښنه او عافیت غواړم. اې الله! زما پر عیبونو پرده واچوه او زما وېره په امن بدله کړه. اې الله! زما ساتنه وکړه زما له مخې، زما له شا، زما له ښي اړخه، زما له کیڼ اړخه او زما له پورته خوا څخه، او زه ستا په لویۍ پناه غواړم له دې څخه چې له لاندې خوا (ناڅاپه) هلاک کړل شم.",
      reference: 'Sunan Abi Dawud: 5074',
      fazilatPashto: 'د دنیا او آخرت د عافیت جامع دعا.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e15',
      arabic:
          'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ أَشْهَدُ أَنْ لَّا إِلَهَ إِلَّا أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ',
      english: 'O Allah! Knower of the Unseen and the Seen...',

      urdu:
          'اے اللہ! جاننے والے غیب اور حاضر کے، پیدا کرنے والے آسمانوں اور زمین کو، پالنے والے ہر چیز کے اور مالک بھی، میں گواہی دیتا ہوں کہ نہیں ہے کوئی معبود مگر تو، میں تیری پناہ میں آتا ہوں اپنے نفس کی برائی سے اور شیطان کے شر سے اور اسکے (میرے کاموں میں) شریک ہونے سے۔',
      pashto:
          'اې الله! د پټو او ښکاره پوهه، د اسمانونو او ځمکې پیدا کونکي، د هر شی رب او مالک، زه شهادت ورکوم چې له تا پرته بل خدای نشته، زه د خپل نفس او د شیطان او د هغه د شریکولو له شره په تا پناه غواړم.',
      reference: 'Jami` at-Tirmidhi: 3392',
      fazilatPashto: 'د غیب او شهادت د پوه په دربار کې پناه غوښتنه.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e16',
      arabic:
          'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      english: 'O Allah! You are my Lord...',
      urdu:
      'اے اللہ! تو ہی میرا رب ہے، نہیں ہے کوئی معبود مگر تو، تو نے مجھے پیدا کیا، میں تیرا بندہ ہوں اور میں تیرے عہد اور وعدے پر (قائم) ہوں جس قدر میری طاقت ہے، میں تیری پناہ میں آتا ہوں اُس کے شر سے جو میں نے کیا، اپنے آپ پر تیری نعمت کا اقرار کرتا ہوں، اور اپنے گناہ کا اعتراف کرتا ہوں پس مجھے بخش دے کیونکہ نہیں ہے کوئی گناہوں کو بخشنے والا مگر تو۔',
      pashto:
      'اې الله! ته زما رب یې، له تا پرته بل معبود نشته، ته ما پیدا کړی او زه بنده ستا یم، او زه تر هغه ځایه چې توان لرم د خپل عهد او ژمنې په سر ولاړ یم. زه له هر هغه شر څخه چې ما کړی دی په تا پناه غواړم. په ما باندې د ستا نعمتونو او په خپل ځان د ګناه اعتراف کوم، نو ما وبښه ځکه چې له تا پرته بل څوک ګناهونه نه بخښي.',
      reference: 'Bukhari: 6306',
      fazilatPashto: 'سید الاستغفار.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e17',
      arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      english: 'Glory and praise is to Allah.',
      urdu: 'اللہ پاک ہے اور اپنی تعریف کے ساتھ ہے۔',
      pashto: 'پاکۍ او ستاینه د الله لپاره ده.',
      reference: 'Bukhari: 6405',
      fazilatPashto: 'د الله ذکر.',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'e18',
      arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      english: 'I seek Allah’s forgiveness and I turn to Him in repentance.',
      urdu: 'میں اللہ سے مغفرت طلب کرتا ہوں اور میں اُسی کی طرف توبہ کرتا ہوں۔',
      pashto: 'زه له الله څخه بخښنه غواړم او د هغه په لور توبه وباسم.',
      reference: 'Bukhari: 6307, Muslim: 6858',
      fazilatPashto: 'استغفار.',
      count: 0,
      targetCount: 100,
    ),
    DhikrEntity(
      id: 'e19',
      arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      english:
          'Allah is sufficient for us and He is the Best Disposer of Affairs.',
      urdu: 'ہم نے اللہ پر بھروسہ کیا اور وہی بہترین کارساز ہے۔',
      pashto: 'الله موږ ته بس دی او هغه تر ټولو ښه کارساز دی.',
      reference: 'Al-Imran: 173, Bukhari: 4563',
      fazilatEnglish: 'Recited by the Prophet in difficult situations.',
      fazilatUrdu: 'رسول اللہ ﷺ نے مشکل حالات میں یہ کلمات پڑھے۔',
      fazilatPashto: 'په سختو حالاتو کې د پیغمبر لخوا لوستل کیده.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'e20',
      arabic: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
      english: 'Darood Sharif (10 times).',
      urdu: 'درود شریف (10 مرتبہ شام)',
      pashto: 'درود شریف (ماښام ۱۰ ځله)',
      reference: 'Majma` az-Zawa\'id: 17022',
      fazilatEnglish: 'Deserves intercession of the Prophet.',
      fazilatUrdu: 'پڑھنے والا شخص شفاعت کا حقدار ہو جاتا ہے۔',
      fazilatPashto: 'د شفاعت حقدار کیږي.',
      count: 0,
      targetCount: 10,
    ),
  ];

  static List<DhikrEntity> sleepingAdhkar = [
    DhikrEntity(
      id: 'sleep_surah_mulk',
      arabic: 'سُورَةُ الْمُلْك',
      english: 'Recite 1 time. (Surah Index: 67)',
      urdu: 'صرف 1 بار پڑھنا ہے۔ (سورت نمبر: 67)',
      pashto: 'یوازې ۱ ځل لوستل کیږي. (سورت: ۶۷)',
      reference: 'Sunan Abu Dawud: 1400 | Jami at-Tirmidhi: 2891',
      fazilatEnglish:
          'Intercedes for its reciter until he is forgiven. The Prophet (ﷺ) never slept without reciting it.',
      fazilatUrdu:
          'قیامت کے دن اپنے پڑھنے والے کی سفارش کرے گی یہاں تک کہ اسے بخش دیا جائے۔ نبی ﷺ اسے پڑھے بغیر نہیں سوتے تھے۔',
      fazilatPashto:
          'د قیامت په ورځ به د خپل لوستونکي شفاعت وکړي تر څو وبښل شي. نبي ﷺ به تر هغه نه ویده کیده څو چې دا به یې نه لوستله.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'sleep_surah_sajda',
      arabic: 'سُورَةُ السَّجْدَة',
      english: 'Recite 1 time. (Surah Index: 32)',
      urdu: 'صرف 1 بار پڑھنا ہے۔ (سورت نمبر: 32)',
      pashto: 'یوازې ۱ ځل لوستل کیږي. (سورت: ۳۲)',
      reference: 'Jami at-Tirmidhi: 2892',
      fazilatEnglish:
          'The Prophet (ﷺ) would not sleep until he recited Surah As-Sajdah. It contains Laylat al-Qadr blessings.',
      fazilatUrdu:
          'نبی ﷺ سورۃ السجدہ پڑھے بغیر نہیں سوتے تھے۔ اس میں شب قدر کی برکات ہیں۔',
      fazilatPashto:
          'نبي ﷺ به تر هغه نه ویده کیده څو چې سورة السجدة به یې نه لوستله. پدې کې د شب قدر برکات دي.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'sleep_surah_waqia',
      arabic: 'سُورَةُ الْوَاقِعَة',
      english: 'Recite 1 time. (Surah Index: 56)',
      urdu: 'صرف 1 بار پڑھنا ہے۔ (سورت نمبر: 56)',
      pashto: 'یوازې ۱ ځل لوستل کیږي. (سورت: ۵۶)',
      reference: 'Shu\'ab al-Iman, Al-Bayhaqi: 2269 (Hasan)',
      fazilatEnglish:
          'Whoever recites Surah Al-Waqi\'ah every night will never be afflicted by poverty.',
      fazilatUrdu:
          'جو ہر رات سورۃ الواقعہ پڑھے، اسے کبھی فقر (محتاجی) نہیں آئے گا۔',
      fazilatPashto:
          'څوک چې هره شپه سورة الواقعة ولولي، هیڅکله به ورته فقر او محتاجی ونه رسیږي.',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'sleep_surah_ikhlas_falaq_nas',
      arabic: 'سُورَةُ الإِخْلَاصِ \n سُورَةُ الْفَلَقِ \n سُورَةُ النَّاسِ',
      english:
          'Recitation of Surah Al-Ikhlas, Surah Al-Falaq, and Surah An-Nas.',
      urdu: 'سورۃ الاخلاص، سورۃ الفلق اور سورۃ الناس کی تلاوت۔',
      pashto: 'د سورة الإخلاص، سورة الفلق او سورة الناس تلاوت.',
      reference: 'Sunan Abu Dawud: 5056',
      fazilatEnglish:
          'Recite each 3 times, blow into palms, and wipe over the entire body starting from the head. Sufficient protection for everything.',
      fazilatUrdu:
          'ہر ایک تین مرتبہ پڑھ کر ہتھیلیوں میں پھونکیں اور سر سے پاؤں تک جسم پر پھیریں۔ ہر چیز سے حفاظت کے لیے کافی ہے۔',
      fazilatPashto:
          'هر یو ۳ ځله په لاسونو کې ووئئ او په لاسونو د سر څخه تر پښو ټول بدن وموښئ. د هر شي څخه د ساتنې لپاره کافي دي.',
      count: 0,
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'sleep_surah_baqarah_last_two_verses',
      arabic:
          'آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ ﴿٢٨٥﴾ لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَا إِنْ نَسِينَا أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِنْ قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ ۖ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا ۚ أَنْتَ مَوْلَانَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 5009',
      fazilatEnglish:
          'The Prophet (ﷺ) said: "Whoever recites the last two verses of Surat al-Baqarah at night, it is sufficient for him."',
      fazilatUrdu:
          'رسول اللہ ﷺ نے فرمایا: "جو شخص رات کے وقت سورۃ البقرہ کی آخری دو آیتیں پڑھ لے گا، وہ اسے (ہر آفت اور شر سے) بچانے کے لیے کافی ہو جائیں گی۔"',
      fazilatPashto:
          'نبي کریم ﷺ وفرمایل: "چا چې د شپې له خوا د سورة البقرة وروستۍ دوه آیتونه ولوستل، نو دا به ورته (د هر شر او بلا څخه) بس شي."',
      count: 0,
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'sleep_tasbih_fatimah_subhan',
      arabic: 'سُبْحَانَ اللَّهِ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 3113',
      fazilatEnglish:
          'Tasbih Fatimah — recite SubhanAllah 33 times, Alhamdulillah 33 times, and Allahu Akbar 34 times before sleeping.',
      fazilatUrdu:
          'تسبیح فاطمہ — سونے سے پہلے 33 بار سبحان اللہ، 33 بار الحمدللہ اور 34 بار اللہ اکبر پڑھیں۔',
      fazilatPashto:
          'د فاطمې تسبیح — د خوب پر مهال ۳۳ ځله سبحان الله، ۳۳ ځله الحمدلله او ۳۴ ځله الله اکبر ووایئ.',
      targetCount: 33,
    ),
    DhikrEntity(
      id: 'sleep_tasbih_fatimah_alhamd',
      arabic: 'الْحَمْدُ لِلَّهِ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 3113',
      fazilatEnglish:
          'Part of Tasbih Fatimah — recite 33 times before sleeping.',
      fazilatUrdu: 'تسبیح فاطمہ کا حصہ — سونے سے پہلے 33 مرتبہ پڑھیں۔',
      fazilatPashto: 'د فاطمې تسبیح برخه — د خوب پر مهال ۳۳ ځله ووایئ.',
      targetCount: 33,
    ),
    DhikrEntity(
      id: 'sleep_tasbih_fatimah_akbar',
      arabic: 'اللَّهُ أَكْبَرُ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 3113',
      fazilatEnglish:
          'Part of Tasbih Fatimah — recite 34 times before sleeping.',
      fazilatUrdu: 'تسبیح فاطمہ کا حصہ — سونے سے پہلے 34 مرتبہ پڑھیں۔',
      fazilatPashto: 'د فاطمې تسبیح برخه — د خوب پر مهال ۳۴ ځله ووایئ.',
      targetCount: 34,
    ),
    DhikrEntity(
      id: 's1',
      arabic:
          'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، فَإِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 6320',
      fazilatEnglish: 'Seeking Allah\'s protection and mercy during sleep.',
      fazilatUrdu: 'سوتے وقت اللہ کی حفاظت اور رحمت طلب کرنے کی دعا۔',
      fazilatPashto: 'د خوب پر مهال د الله ساتنه او رحمت غوښتل.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 's2',
      arabic: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sunan Abu Dawud: 5045',
      fazilatEnglish:
          'Protection from the punishment of the Day of Resurrection.',
      fazilatUrdu: 'قیامت کے دن کے عذاب سے بچنے کی دعا۔',
      fazilatPashto: 'د قیامت د ورځې له عذابه د پناه غوښتلو دعا.',
      targetCount: 3,
    ),
    DhikrEntity(
      id: 's3',
      arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 6312',
      fazilatEnglish:
          'Acknowledging life and death in Allah\'s name before sleep.',
      fazilatUrdu: 'سونے سے پہلے اللہ کے نام کے ساتھ جینے اور مرنے کا اعتراف۔',
      fazilatPashto: 'د خوب پر مهال د الله په نوم د ژوند او مرګ اقرار.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 's4',
      arabic:
          'اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، '
          'وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، '
          'رَغْبَةً وَرَهْبَةً إِلَيْكَ، لَا مَلْجَأَ وَلَا مَنْجَا مِنْكَ إِلَّا إِلَيْكَ، '
          'آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 6313',
      fazilatEnglish:
          'Whoever says this and dies that night dies upon the Fitrah (natural disposition of Islam).',
      fazilatUrdu:
          'جو یہ پڑھ کر سوئے اور اسی رات انتقال ہو جائے تو وہ فطرت (اسلام) پر مرا۔',
      fazilatPashto:
          'څوک چې دا ووایي او په همغه شپه مړ شي، د اسلام په فطرت مړ کیږي.',
      targetCount: 1,
    ),

    DhikrEntity(
      id: 's7',
      arabic:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sunan Abu Dawud: 5090',
      fazilatEnglish:
          'Seeking refuge from three great trials: disbelief, poverty, and punishment of the grave.',
      fazilatUrdu: 'تین بڑی آزمائشوں سے پناہ: کفر، فقر اور عذاب قبر۔',
      fazilatPashto:
          'د دریو لویو ازموینو (کفر، فقر، او قبر عذاب) څخه پناه غوښتل.',
      targetCount: 3,
    ),

    DhikrEntity(
      id: 's10',
      arabic: 'اللَّهُمَّ بِاسْمِكَ أَحْيَا وَأَمُوتُ',
      english: '',
      urdu: '',
      pashto: '',
      reference: 'Sahih al-Bukhari: 6312',
      fazilatEnglish:
          'The Prophet (ﷺ) said this when going to sleep, completely entrusting his life to Allah.',
      fazilatUrdu:
          'نبی کریم ﷺ سوتے وقت یہ پڑھتے تھے، اپنی زندگی مکمل طور پر اللہ کے سپرد کرتے ہوئے۔',
      fazilatPashto: 'نبي کریم ﷺ به د ویده کیدو پر مهال دا ویل.',
      targetCount: 1,
    ),
  ];

  static List<DhikrEntity> postPrayerAdhkar = [
    DhikrEntity(
      id: 'p1',
      arabic:
          'أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ',
      english: 'I seek forgiveness from Allah (3 times)',
      urdu: 'میں اللہ سے مغفرت طلب کرتا ہوں۔ (3 مرتبہ)',
      pashto: 'زه له الله څخه بخښنه غواړم. (۳ ځله)',
      reference: 'Sahih Muslim: 1334',
      fazilatEnglish:
          'The Prophet (ﷺ), upon finishing the prayer, would seek forgiveness from Allah three times.',
      fazilatUrdu: 'نبی کریم ﷺ جب نماز مکمل فرماتے تو تین بار استغفار کرتے۔',
      fazilatPashto:
          'رسول الله ﷺ به چې لمانځه څخه فارغ شو، ۳ ځله به یې استغفار وکړ.',
      targetCount: 3,
    ),
    DhikrEntity(
      id: 'p2',
      arabic:
          'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      english:
          'O Allah, You are As-Salam (the Source of Peace) and from You comes peace. Blessed are You, O Owner of Majesty and Honor.',
      urdu:
          'اے اللہ! تو ہی سلامتی والا ہے اور تجھ ہی سے سلامتی ہے، تو بابرکت ہے اے جلال اور بزرگی والے۔',
      pashto:
          'اې الله! ته خپله سلامتي یې او له تا څخه سلامتي ده، برکت والا یې اې د جلال او لویۍ څښتنه.',
      reference: 'Sahih Muslim: 1334',
      fazilatEnglish:
          'After seeking forgiveness three times, the Prophet (ﷺ) would not remain seated except for the time it takes to say this supplication.',
      fazilatUrdu:
          'نبی کریم ﷺ تین بار استغفار کے بعد صرف اتنی دیر بیٹھتے جتنی دیر میں یہ دعا پڑھی جائے۔',
      fazilatPashto: 'رسول الله ﷺ به تر استغفار وروسته یوازې همدومره کښېناست.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'p3',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ',
      english:
          'There is no god but Allah alone, with no partner. To Him belongs the dominion and to Him belongs all praise, and He is over all things capable. O Allah, none can withhold what You give, none can give what You withhold, and the might of the mighty cannot benefit him against You.',
      urdu:
          'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تمام تعریفیں ہیں اور وہ ہر چیز پر قادر ہے۔ اے اللہ! جو تو دے اسے کوئی روکنے والا نہیں، اور جسے تو روکے اسے کوئی دینے والا نہیں، اور کسی صاحبِ دولت و حیثیت کو اس کی دولت و حیثیت تجھ سے بچا نہیں سکتی۔',
      pashto:
          'له الله پرته بل معبود نشته، هغه یو دی، شریک نه لري، ټول واک او ستاینې د هغه دي، او هغه پر هر شی قادر دی. اې الله! هغه څه چې ته یې ورکوې هېڅوک یې نه شي منع کولی، او کوم څه چې ته یې منع کوې هېڅوک یې نه شي ورکولی، او د هېڅ شتمن شتمني د تا په وړاندې ګټه نه شي رسولی.',
      reference: 'Sahih al-Bukhari: 844',
      fazilatEnglish:
          'The Prophet (ﷺ) used to recite this at the end of every obligatory prayer.',
      fazilatUrdu: 'نبی کریم ﷺ ہر فرض نماز کے بعد یہ پڑھا کرتے تھے۔',
      fazilatPashto: 'رسول الله ﷺ به دا د هر فرض لمانځه وروسته لوستله.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'p4',
      arabic: 'سُبْحَانَ اللَّهِ',
      english: 'SubhanAllah — Glory be to Allah (33 times)',
      urdu: 'سبحان اللہ (33 مرتبہ)',
      pashto: 'سبحان الله (۳۳ ځله)',
      reference: 'Sahih Muslim: 1352',
      fazilatEnglish:
          'Whoever glorifies Allah 33 times, praises Him 33 times and declares His greatness 33 times after every prayer...',
      fazilatUrdu:
          'جو شخص ہر نماز کے بعد 33 بار سبحان اللہ، 33 بار الحمدللہ، 33 بار اللہ اکبر پڑھے...',
      fazilatPashto:
          'څوک چې د هر لمانځه وروسته ۳۳ ځله سبحان الله، ۳۳ ځله الحمدلله او ۳۳ ځله الله اکبر ووایي...',
      targetCount: 33,
    ),
    DhikrEntity(
      id: 'p5',
      arabic: 'الْحَمْدُ لِلَّهِ',
      english: 'Alhamdulillah — All praise is for Allah (33 times)',
      urdu: 'الحمدللہ (33 مرتبہ)',
      pashto: 'الحمدلله (۳۳ ځله)',
      reference: 'Sahih Muslim: 1352',
      fazilatEnglish: 'Part of the post-prayer tasbih (33 + 33 + 33 + 1).',
      fazilatUrdu: 'یہ نماز کے بعد کی تسبیحات (33، 33، 33 اور 1) کا حصہ ہے۔',
      fazilatPashto: 'د لمانځه وروسته د تسبیحاتو برخه.',
      targetCount: 33,
    ),
    DhikrEntity(
      id: 'p6',
      arabic: 'اللَّهُ أَكْبَرُ',
      english: 'Allahu Akbar — Allah is the Greatest (33 times)',
      urdu: 'اللہ اکبر (33 مرتبہ)',
      pashto: 'الله اکبر (۳۳ ځله)',
      reference: 'Sahih Muslim: 1352',
      fazilatEnglish: 'Part of the post-prayer tasbih (33 + 33 + 33 + 1).',
      fazilatUrdu: 'یہ نماز کے بعد کی تسبیحات (33، 33، 33 اور 1) کا حصہ ہے۔',
      fazilatPashto: 'د لمانځه وروسته د تسبیحاتو برخه.',
      targetCount: 33,
    ),
    DhikrEntity(
      id: 'p7',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      english:
          'There is no god but Allah alone, with no partner. To Him belongs the dominion and all praise, and He is over all things capable.',
      urdu:
          'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تمام تعریفیں ہیں اور وہ ہر چیز پر قادر ہے۔ (1 مرتبہ)',
      pashto:
          'له الله پرته بل معبود نشته، هغه یو دی، شریک نه لري، ټول واک او ستاینې د هغه دي، او هغه پر هر شی قادر دی. (۱ ځل)',
      reference: 'Sahih Muslim: 1352',
      fazilatEnglish:
          'With this the count reaches one hundred, and the sins of the one who recites it are forgiven even if they are like the foam of the sea.',
      fazilatUrdu:
          'اس سے تعداد سو مکمل ہوتی ہے، اور پڑھنے والے کی خطائیں معاف کر دی جاتی ہیں۔',
      fazilatPashto: 'پدې سره شمیره سلو ته رسیږي او ګناهونه بښل کیږي.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'p8',
      arabic:
          'اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      english: 'Ayatul Kursi (Surah Al-Baqarah 2:255)',
      urdu: 'آیت الکرسی (سورۃ البقرہ: 255)',
      pashto: 'د آیت الکرسی تلاوت (سورة البقرة: ۲۵۵)',
      reference: 'Sunan al-Kubra lil-Nasa\'i',
      fazilatEnglish:
          'Whoever recites Ayatul Kursi after every obligatory prayer, nothing prevents him from entering Paradise except death.',
      fazilatUrdu:
          'جو شخص ہر فرض نماز کے بعد آیت الکرسی پڑھے، اسے جنت میں داخل ہونے سے صرف موت روکے ہوئے ہے۔',
      fazilatPashto:
          'څوک چې د هر فرض لمانځه وروسته آیت الکرسی ووایي، جنت ته د ننوتلو په وړاندې یې یوازې مرګ خنډ دی.',
      targetCount: 1,
    ),
    DhikrEntity(
      id: 'p9',
      arabic:
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\n'
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
          'قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَٰهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ',
      english:
          'The Three Muawwidhat (Surah Al-Ikhlas, Al-Falaq, An-Nas). Recite once after each prayer; three times each after Fajr and Maghrib.',
      urdu:
          'تینوں معوذات (سورۃ الاخلاص، سورۃ الفلق، سورۃ الناس)۔ ہر نماز کے بعد ایک بار، اور فجر و مغرب کے بعد تین تین بار۔',
      pashto:
          'درې واړه معوذات (سورة الإخلاص، سورة الفلق، سورة الناس). د هر لمانځه وروسته یو ځل، او د فجر او ماښام وروسته ۳ ځله.',
      reference: 'Sunan Abi Dawud: 1523; Jami at-Tirmidhi: 2903',
      fazilatEnglish:
          'Uqbah ibn Amir (R.A) said: the Prophet (ﷺ) commanded me to recite the Muawwidhat after every prayer.',
      fazilatUrdu:
          'حضرت عقبہ بن عامر ؓ فرماتے ہیں کہ نبی کریم ﷺ نے مجھے حکم دیا کہ ہر نماز کے بعد معوذات پڑھا کروں۔',
      fazilatPashto: 'رسول الله ﷺ امر وکړ چې د هر لمانځه وروسته معوذات ووایم.',
      targetCount: 1,
    ),
  ];

  static List<AdhkarCategory> categories = [
    AdhkarCategory(
      id: 'morning',
      titleEn: 'Morning Adhkar',
      titleUr: 'صبح کے اذکار',
      titlePs: 'د سهار اذکار',
      dhikrs: morningAdhkar,
    ),
    AdhkarCategory(
      id: 'evening',
      titleEn: 'Evening Adhkar',
      titleUr: 'شام کے اذکار',
      titlePs: 'د ماښام اذکار',
      dhikrs: eveningAdhkar,
    ),
    AdhkarCategory(
      id: 'post_prayer',
      titleEn: 'Post-Prayer Adhkar',
      titleUr: 'نماز کے بعد کے اذکار',
      titlePs: 'د لمانځه وروسته اذکار',
      dhikrs: postPrayerAdhkar,
    ),
    AdhkarCategory(
      id: 'sleeping',
      titleEn: 'Sleeping Adhkar',
      titleUr: 'سونے کے اذکار',
      titlePs: 'د خوب اذکار',
      dhikrs: sleepingAdhkar,
    ),
  ];
}
