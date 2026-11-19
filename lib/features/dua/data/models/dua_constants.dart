import '../../domain/entities/dua_entity.dart';

class DuaConstants {
  // ─── WAKING UP ───────────────────────────────────────────────────────────────
  static List<DuaEntity> wakingUpDuas = [
    DuaEntity(
      id: 'wu1',
      titleEn: 'Upon Waking Up',
      titleUr: 'سو کر اٹھنے کی دعا',
      titlePs: 'له خوبه راپاڅېدو دعا',
      arabic:
          'الْحَمْدُ للهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      translationEn:
          'Praise is to Allah who gave us life after He had caused us to die and to Him is the return.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں مارنے (سلانے) کے بعد زندہ کیا اور اسی کی طرف لوٹ کر جانا ہے۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې موږ یې له مرګ (خوب) وروسته ژوندي کړو او بېرته ورتګ هم هغه ته دی.',
      reference: 'Sahih al-Bukhari: 6312',
    ),
    DuaEntity(
      id: 'wu2',
      titleEn: 'Upon Waking Up at Night',
      titleUr: 'رات کو آنکھ کھلنے پر دعا',
      titlePs: 'د شپې له خوبه راویښېدو دعا',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالْحَمْدُ للهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      translationEn:
          'There is none worthy of worship except Allah, alone, without partner. To Him belongs sovereignty and to Him belongs all praise and He is capable of all things. Glory is to Allah, and praise is to Allah, and there is none worthy of worship except Allah, Allah is the Greatest, and there is no power nor might except with Allah.',
      translationUr:
          'اللہ کے سوا کوئی معبود نہیں، اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہت ہے، اسی کے لیے تمام تعریفیں ہیں، اور وہ ہر چیز پر قادر ہے۔ اللہ پاک ہے، تعریف اللہ کے لیے ہے، اللہ کے سوا کوئی معبود نہیں، اللہ سب سے بڑا ہے، اور کوئی طاقت و قوت نہیں مگر اللہ کے ساتھ۔',
      translationPs:
          'له الله پرته بل هېڅ معبود نشته، یو دی، شریک نه لري، پاچاهي او ټولې ستاینې یې دي، او هغه پر هر څه قادر دی. الله پاک دی، ستاینې الله ته دي، له الله پرته بل معبود نشته، الله تر ټولو لوی دی، او هېڅ ځواک او قوت نشته مګر د الله په مرسته.',
      reference: 'Sahih al-Bukhari: 1154',
    ),
  ];

  // ─── TOILET / BATHROOM ───────────────────────────────────────────────────────
  static List<DuaEntity> toiletDuas = [
    DuaEntity(
      id: 't1',
      titleEn: 'Entering the Toilet',
      titleUr: 'بیت الخلا میں داخل ہونے کی دعا',
      titlePs: 'تشناب ته د ننوتلو دعا',
      arabic:
          'بِسْمِ اللَّهِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
      translationEn:
          'In the name of Allah. O Allah, I seek refuge in You from the male and female evil spirits.',
      translationUr:
          'اللہ کے نام سے۔ اے اللہ! میں تیری پناہ مانگتا ہوں خبیث جنوں اور جنیوں سے۔',
      translationPs:
          'د الله په نامه. ای الله! زه ستا پناه غواړم له نرو او ښځینه ناپاکو شیطانانو (جنونو) څخه.',
      reference: 'Sahih al-Bukhari: 142, Sahih Muslim: 375',
    ),
    DuaEntity(
      id: 't2',
      titleEn: 'Leaving the Toilet',
      titleUr: 'بیت الخلا سے نکلنے کی دعا',
      titlePs: 'له تشنابه د وتلو دعا',
      arabic: 'غُفْرَانَكَ',
      translationEn: 'I seek Your forgiveness.',
      translationUr: 'میں تجھ سے بخشش مانگتا ہوں۔',
      translationPs: 'زه ستا بخښنه غواړم.',
      reference: 'Abu Dawud: 30, Tirmidhi: 7',
    ),
  ];

  // ─── WUDU (ABLUTION) ─────────────────────────────────────────────────────────
  static List<DuaEntity> wuduDuas = [
    DuaEntity(
      id: 'wz1',
      titleEn: 'Before Performing Wudu',
      titleUr: 'وضو شروع کرنے کی دعا',
      titlePs: 'د اودس د پیل دعا',
      arabic: 'بِسْمِ اللَّهِ',
      translationEn: 'In the name of Allah.',
      translationUr: 'اللہ کے نام سے۔',
      translationPs: 'د الله په نامه.',
      reference: 'Abu Dawud: 101',
    ),
    DuaEntity(
      id: 'wz2',
      titleEn: 'After Performing Wudu',
      titleUr: 'وضو کے بعد کی دعا',
      titlePs: 'د اودس وروسته دعا',
      arabic:
          'أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّداً عَبْدُهُ وَرَسُولُهُ، اللَّهُمَّ اجْعَلْنِي مِنَ التَّوَّابِينَ وَاجْعَلْنِي مِنَ الْمُتَطَهِّرِينَ',
      translationEn:
          'I bear witness that there is none worthy of worship except Allah, alone, without partner, and I bear witness that Muhammad is His slave and Messenger. O Allah, make me of those who repent and make me of those who purify themselves.',
      translationUr:
          'میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، اکیلا ہے، اس کا کوئی شریک نہیں، اور میں گواہی دیتا ہوں کہ محمد ﷺ اس کے بندے اور رسول ہیں۔ اے اللہ! مجھے توبہ کرنے والوں میں سے بنا اور مجھے پاکیزگی اختیار کرنے والوں میں سے بنا۔',
      translationPs:
          'زه شاهدي ورکوم چې له الله پرته بل معبود نشته، یو دی، شریک نه لري، او زه شاهدي ورکوم چې محمد ﷺ د هغه بنده او رسول دی. ای الله! ما د توبه کوونکو له ډلې کړه او د پاکېدونکو له ډلې کړه.',
      reference: 'Sahih Muslim: 234, Tirmidhi: 55',
    ),
  ];

  // ─── CLOTHING ────────────────────────────────────────────────────────────────
  static List<DuaEntity> clothingDuas = [
    DuaEntity(
      id: 'cl1',
      titleEn: 'When Wearing New or Any Clothes',
      titleUr: 'کپڑے پہننے کی دعا',
      titlePs: 'د جامو اغوستلو دعا',
      arabic:
          'الْحَمْدُ للهِ الَّذِي كَسَانِي هَذَا الثَّوْبَ وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
      translationEn:
          'Praise is to Allah who has clothed me with this garment and provided it for me, with no power or might from myself.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس نے مجھے یہ کپڑا پہنایا اور بغیر میری کسی طاقت اور قوت کے مجھے یہ عطا کیا۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې دا جامه یې ما ته واغوستله او له ما څخه پرته د کوم ځواک او قوت یې راکړه.',
      reference: 'Abu Dawud: 4023, Tirmidhi: 3458',
    ),
    DuaEntity(
      id: 'cl2',
      titleEn: 'When Undressing',
      titleUr: 'کپڑے اتارنے کی دعا',
      titlePs: 'د جامو ایستلو دعا',
      arabic: 'بِسْمِ اللَّهِ',
      translationEn: 'In the name of Allah.',
      translationUr: 'اللہ کے نام سے۔',
      translationPs: 'د الله په نامه.',
      reference: 'Tirmidhi: 606',
    ),
  ];

  // ─── LEAVING & ENTERING HOME ─────────────────────────────────────────────────
  static List<DuaEntity> homeDuas = [
    DuaEntity(
      id: 'hm1',
      titleEn: 'When Leaving the House',
      titleUr: 'گھر سے نکلتے وقت کی دعا',
      titlePs: 'له کوره د وتلو دعا',
      arabic:
          'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      translationEn:
          'In the name of Allah, I place my trust in Allah, and there is no might nor power except with Allah.',
      translationUr:
          'اللہ کے نام سے، میں نے اللہ پر بھروسہ کیا، اور کوئی طاقت اور قوت نہیں مگر اللہ کے ساتھ۔',
      translationPs:
          'د الله په نامه، پر الله مې توکل وکړ، او هېڅ ځواک او قوت نشته مګر د الله په مرسته.',
      reference: 'Abu Dawud: 5095, Tirmidhi: 3426',
    ),
    DuaEntity(
      id: 'hm2',
      titleEn: 'When Entering the House',
      titleUr: 'گھر میں داخل ہونے کی دعا',
      titlePs: 'کور ته د ننوتلو دعا',
      arabic:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلَجِ وَخَيْرَ الْمَخْرَجِ، بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
      translationEn:
          'O Allah! I ask You for the good both when entering and when going out. In the name of Allah we enter, and in the name of Allah we leave, and upon Allah our Lord we rely.',
      translationUr:
          'اے اللہ! میں تجھ سے داخل ہونے کی اور نکلنے کی بھلائی مانگتا ہوں، اللہ کے نام سے ہم داخل ہوئے، اور اللہ کے نام سے ہم نکلے، اور اللہ جو ہمارا رب ہے اس پر ہم نے بھروسہ کیا۔',
      translationPs:
          'ای الله! زه له تا د ننوتلو او وتلو ښېګڼه غواړم. د الله په نامه ننوتو، د الله په نامه وتو، او پر الله چې زموږ رب دی توکل مو وکړ.',
      reference: 'Abu Dawud: 5096',
    ),
  ];

  // ─── FOOD & DRINK ────────────────────────────────────────────────────────────
  static List<DuaEntity> foodDuas = [
    DuaEntity(
      id: 'fd1',
      titleEn: 'Before Eating',
      titleUr: 'کھانا شروع کرنے کی دعا',
      titlePs: 'د خوراک د پیل دعا',
      arabic: 'بِسْمِ اللَّهِ',
      translationEn: 'In the name of Allah.',
      translationUr: 'اللہ کے نام سے۔',
      translationPs: 'د الله په نامه.',
      reference: 'Abu Dawud: 3767, Sahih al-Bukhari: 5376',
    ),
    DuaEntity(
      id: 'fd2',
      titleEn: 'If You Forget to Say Bismillah Before Eating',
      titleUr: 'کھانے سے پہلے بسم اللہ بھول جائے تو',
      titlePs: 'که د خوراک په پیل کې بسم الله هېر شي',
      arabic: 'بِسْمِ اللَّهِ أَوَّلَهُ وَآخِرَهُ',
      translationEn: 'In the name of Allah at its beginning and at its end.',
      translationUr: 'اللہ کے نام سے اس کے شروع میں بھی اور آخر میں بھی۔',
      translationPs: 'د الله په نامه د دې په پیل او په پای کې.',
      reference: 'Abu Dawud: 3767, Tirmidhi: 1858',
    ),
    DuaEntity(
      id: 'fd3',
      titleEn: 'After Eating',
      titleUr: 'کھانے کے بعد کی دعا',
      titlePs: 'د خوراک وروسته دعا',
      arabic:
          'الْحَمْدُ للهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
      translationEn:
          'Praise is to Allah who has fed me this and provided it for me without any might or power on my part.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس نے مجھے یہ کھلایا اور بغیر میری کسی طاقت اور قوت کے مجھے یہ عطا کیا۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې دا یې ما ته راوخوړل او له ما څخه پرته د کوم ځواک او قوت یې راکړل.',
      reference: 'Abu Dawud: 4023, Tirmidhi: 3458',
    ),
    DuaEntity(
      id: 'fd4',
      titleEn: 'After Eating (Another Narration)',
      titleUr: 'کھانے کے بعد کی دوسری دعا',
      titlePs: 'د خوراک وروسته بله دعا',
      arabic:
          'الْحَمْدُ للهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
      translationEn:
          'Praise is to Allah who has fed us and given us drink and made us Muslims.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں کھلایا اور پلایا اور ہمیں مسلمان بنایا۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې موږ یې وخوړول، وڅښل او مسلمانان یې کړو.',
      reference: 'Abu Dawud: 3850',
    ),
    DuaEntity(
      id: 'fd5',
      titleEn: 'When Fasting and Someone Invites You to Eat',
      titleUr: 'روزے میں کھانے کی دعوت ملے تو',
      titlePs: 'کله چې روژه وي او څوک خوراک ته بلنه کوي',
      arabic: 'إِنِّي صَائِمٌ',
      translationEn: 'I am fasting.',
      translationUr: 'میں روزے سے ہوں۔',
      translationPs: 'زه روژه یم.',
      reference: 'Sahih al-Bukhari: 1894, Sahih Muslim: 1151',
    ),
    DuaEntity(
      id: 'fd6',
      titleEn: 'When Breaking the Fast (Iftar)',
      titleUr: 'روزہ افطار کرتے وقت کی دعا',
      titlePs: 'د روژې د ماتولو (افطار) دعا',
      arabic:
          'ذَهَبَ الظَّمَأُ وَابْتَلَّتِ الْعُرُوقُ وَثَبَتَ الْأَجْرُ إِنْ شَاءَ اللَّهُ',
      translationEn:
          'The thirst has gone, the veins are moistened, and the reward is confirmed, if Allah wills.',
      translationUr:
          'پیاس بجھ گئی، رگیں تر ہو گئیں اور ان شاء اللہ اجر ثابت ہو گیا۔',
      translationPs:
          'تنده ولاړه، رګونه لوند شول، او که الله وغواړي اجر ثابت شو.',
      reference: 'Abu Dawud: 2357',
    ),
    DuaEntity(
      id: 'fd9',
      titleEn: 'Before Drinking Water',
      titleUr: 'پانی پینے سے پہلے',
      titlePs: 'د اوبو له څښلو مخکې',
      arabic: 'بِسْمِ اللَّهِ',
      translationEn: 'In the name of Allah.',
      translationUr: 'اللہ کے نام سے۔',
      translationPs: 'د الله په نامه.',
      reference: 'Tirmidhi: 1885',
    ),
    DuaEntity(
      id: 'fd10',
      titleEn: 'After Drinking Milk',
      titleUr: 'دودھ پینے کے بعد کی دعا',
      titlePs: 'د شودو له څښلو وروسته دعا',
      arabic: 'اللَّهُمَّ بَارِكْ لَنَا فِيهِ وَزِدْنَا مِنْهُ',
      translationEn: 'O Allah, bless us in it and give us more of it.',
      translationUr:
          'اے اللہ! اس میں ہمارے لیے برکت دے اور ہمیں اس سے مزید عطا فرما۔',
      translationPs:
          'ای الله! په دې کې موږ ته برکت راکړه او له دې څخه موږ ته نور هم راکړه.',
      reference: 'Abu Dawud: 3730, Tirmidhi: 3455',
    ),
  ];

  // ─── MOSQUE ───────────────────────────────────────────────────────────────────
  static List<DuaEntity> mosqueDuas = [
    DuaEntity(
      id: 'mq1',
      titleEn: 'When Entering the Mosque',
      titleUr: 'مسجد میں داخل ہوتے وقت',
      titlePs: 'جومات ته د ننوتلو دعا',
      arabic: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      translationEn: 'O Allah, open the gates of Your mercy for me.',
      translationUr: 'اے اللہ! میرے لیے اپنی رحمت کے دروازے کھول دے۔',
      translationPs: 'ای الله! ما ته د خپلې رحمت دروازې خلاصې کړه.',
      reference: 'Sahih Muslim: 713',
    ),
    DuaEntity(
      id: 'mq2',
      titleEn: 'When Leaving the Mosque',
      titleUr: 'مسجد سے نکلتے وقت',
      titlePs: 'له جومات څخه د وتلو دعا',
      arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
      translationEn: 'O Allah, I ask You of Your favour.',
      translationUr: 'اے اللہ! میں تجھ سے تیرا فضل مانگتا ہوں۔',
      translationPs: 'ای الله! زه له تا ستا فضل غواړم.',
      reference: 'Sahih Muslim: 713',
    ),
  ];

  // ─── ADHAN (CALL TO PRAYER) ───────────────────────────────────────────────────
  static List<DuaEntity> adhanDuas = [
    DuaEntity(
      id: 'az1',
      titleEn: 'After Hearing the Adhan',
      titleUr: 'اذان سننے کے بعد کی دعا',
      titlePs: 'د اذان وروسته دعا',
      arabic:
          'اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلَاةِ الْقَائِمَةِ آتِ مُحَمَّداً الْوَسِيلَةَ وَالْفَضِيلَةَ وَابْعَثْهُ مَقَاماً مَحْمُوداً الَّذِي وَعَدْتَهُ',
      translationEn:
          'O Allah, Lord of this perfect call and the prayer to be offered, grant Muhammad the privilege and the eminence, and resurrect him to the praised position that You have promised him.',
      translationUr:
          'اے اللہ! اس کامل دعوت اور قائم ہونے والی نماز کے رب، محمد ﷺ کو وسیلہ اور فضیلت عطا فرما، اور انہیں مقام محمود پر مبعوث فرما جس کا تو نے ان سے وعدہ کیا ہے۔',
      translationPs:
          'ای الله! د دې بشپړې بلنې او د ودرېدونکي لمانځه ربه، محمد ﷺ ته وسیله او فضیلت ورکړه، او هغه په هغه ستایل شوي مقام باندې راپاڅوه چې تا ورسره ژمنه کړې ده.',
      reference: 'Sahih al-Bukhari: 614',
    ),
    DuaEntity(
      id: 'az2',
      titleEn: 'Repeat After the Muadhdhin (at Hayya alas-Salah)',
      titleUr: 'حَيَّ عَلَى الصَّلَاةِ پر یہ کہیں',
      titlePs: 'د «حَيَّ عَلَى الصَّلَاةِ» په وخت کې',
      arabic: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      translationEn: 'There is no might nor power except with Allah.',
      translationUr: 'کوئی طاقت اور قوت نہیں مگر اللہ کے ساتھ۔',
      translationPs: 'هېڅ ځواک او قوت نشته مګر د الله په مرسته.',
      reference: 'Sahih al-Bukhari: 613',
    ),
  ];

  // ─── SALAH (PRAYER) ──────────────────────────────────────────────────────────
  static List<DuaEntity> salahDuas = [
    DuaEntity(
      id: 'sl1',
      titleEn: 'After Finishing Salah (After Tasleem)',
      titleUr: 'نماز کے بعد کی دعا',
      titlePs: 'د لمانځه وروسته دعا',
      arabic:
          'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      translationEn:
          'O Allah, You are Peace and from You comes peace. Blessed are You, O Owner of majesty and honour.',
      translationUr:
          'اے اللہ! تو سلامتی والا ہے اور تجھی سے سلامتی آتی ہے، تو بابرکت ہے اے جلال اور عزت والے۔',
      translationPs:
          'ای الله! ته سلامتي یې او سلامتي له تا څخه ده، ای د عظمت او اکرام څښتنه! ته ډېر بابرکته یې.',
      reference: 'Sahih Muslim: 591',
    ),
    DuaEntity(
      id: 'sl2',
      titleEn: 'Between Adhan and Iqamah',
      titleUr: 'اذان اور اقامت کے درمیان دعا',
      titlePs: 'د اذان او اقامت ترمنځ دعا',
      arabic: 'لَا يُرَدُّ الدُّعَاءُ بَيْنَ الْأَذَانِ وَالْإِقَامَةِ',
      translationEn:
          'Supplication made between the adhan and the iqamah is not rejected.',
      translationUr: 'اذان اور اقامت کے درمیان مانگی گئی دعا رد نہیں کی جاتی۔',
      translationPs: 'د اذان او اقامت ترمنځ دعا نه رد کېږي.',
      reference: 'Abu Dawud: 521, Tirmidhi: 212',
    ),
  ];

  // ─── TRAVEL ──────────────────────────────────────────────────────────────────
  static List<DuaEntity> travelDuas = [
    DuaEntity(
      id: 'tr1',
      titleEn: 'When Riding or Boarding a Vehicle',
      titleUr: 'سواری پر سوار ہونے کی دعا',
      titlePs: 'په سورلۍ د سپرېدو دعا',
      arabic:
          'بِسْمِ اللَّهِ، الْحَمْدُ للهِ، سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
      translationEn:
          'In the name of Allah, all praise is for Allah. How perfect He is, the One Who has placed this (transport) at our service and we ourselves would not have been capable of that, and to our Lord is our final destiny.',
      translationUr:
          'اللہ کے نام سے، تمام تعریفیں اللہ کے لیے ہیں۔ پاک ہے وہ ذات جس نے اسے ہمارے لیے مسخر کر دیا ورنہ ہم اسے قابو میں نہیں کر سکتے تھے، اور ہم اپنے رب کی طرف لوٹنے والے ہیں۔',
      translationPs:
          'د الله په نامه، ټولې ستاینې الله ته دي. پاک دی هغه چې دا یې زموږ لپاره تابع کړ، حال دا چې موږ یې د تابع کولو توان نه درلود، او موږ خپل رب ته ورګرځېدونکي یو.',
      reference: 'Abu Dawud: 2602, Tirmidhi: 3446',
    ),
    DuaEntity(
      id: 'tr3',
      titleEn: 'When Returning from a Journey',
      titleUr: 'سفر سے واپسی پر دعا',
      titlePs: 'له سفره د راستنېدو دعا',
      arabic: 'آيِبُونَ تَائِبُونَ عَابِدُونَ لِرَبِّنَا حَامِدُونَ',
      translationEn: 'We return, repent, worship and praise our Lord.',
      translationUr:
          'ہم لوٹنے والے، توبہ کرنے والے، عبادت کرنے والے اور اپنے رب کی تعریف کرنے والے ہیں۔',
      translationPs:
          'موږ راستنېدونکي، توبه کوونکي، عبادت کوونکي او د خپل رب ستاینه کوونکي یو.',
      reference: 'Sahih al-Bukhari: 3085, Sahih Muslim: 1345',
    ),
    DuaEntity(
      id: 'tr4',
      titleEn: 'When Stopping at a Place During Travel',
      titleUr: 'سفر میں کسی جگہ رکنے کی دعا',
      titlePs: 'په سفر کې په یو ځای د ځنډېدو دعا',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      translationEn:
          'I seek refuge in the perfect words of Allah from the evil of what He has created.',
      translationUr:
          'میں اللہ کے کامل کلمات کی پناہ مانگتا ہوں اس کی مخلوق کے شر سے۔',
      translationPs:
          'زه د الله په بشپړو کلماتو پناه غواړم له هغه څه شره چې هغه پيدا کړي دي.',
      reference: 'Sahih Muslim: 2708',
    ),
    DuaEntity(
      id: 'tr5',
      titleEn: 'When Entering a Town or City',
      titleUr: 'کسی شہر یا بستی میں داخل ہوتے وقت',
      titlePs: 'کلي یا ښار ته د ننوتلو دعا',
      arabic:
          'اللَّهُمَّ رَبَّ السَّمَوَاتِ السَّبْعِ وَمَا أَظْلَلْنَ وَرَبَّ الأَرَضِينَ السَّبْعِ وَمَا أَقْلَلْنَ وَرَبَّ الشَّيَاطِينِ وَمَا أَضْلَلْنَ وَرَبَّ الرِّيَاحِ وَمَا ذَرَيْنَ، أَسْأَلُكَ خَيْرَ هَذِهِ الْقَرْيَةِ وَخَيْرَ أَهْلِهَا وَخَيْرَ مَا فِيهَا، وَأَعُوذُ بِكَ مِنْ شَرِّهَا وَشَرِّ أَهْلِهَا وَشَرِّ مَا فِيهَا',
      translationEn:
          'O Allah, Lord of the seven heavens and what they shade, Lord of the seven earths and what they carry, Lord of the devils and what they lead astray, Lord of the winds and what they scatter. I ask You for the good of this town, the good of its people and the good within it, and I seek refuge in You from its evil, the evil of its people and the evil within it.',
      translationUr:
          'اے اللہ! سات آسمانوں اور جو ان کے سائے میں ہے اس کے رب، سات زمینوں اور جو انہوں نے اٹھا رکھا ہے اس کے رب، شیاطین اور جو انہوں نے گمراہ کیا ہے اس کے رب، ہواؤں اور جو انہوں نے اڑایا ہے اس کے رب! میں تجھ سے اس بستی کی بھلائی، اس کے لوگوں کی بھلائی اور اس میں موجود بھلائی مانگتا ہوں، اور اس کے شر سے، اس کے لوگوں کے شر سے اور اس میں موجود شر سے تیری پناہ مانگتا ہوں۔',
      translationPs:
          'ای الله! د اوو اسمانونو او د هغو څه رب چې دوی پرې سیوری کړی، د اوو ځمکو او د هغو څه رب چې دوی پورته کړي، د شیطانانو او د هغو څه رب چې دوی یې ګمراه کړي، د بادونو او د هغو څه رب چې دوی یې الوځوي! زه له تا د دې کلي ښېګڼه، د دې د خلکو ښېګڼه او په دې کې د شته ښېګڼې غوښتنه کوم، او ستا پناه غواړم له دې شر، د دې د خلکو له شر او په دې کې له شته شر څخه.',
      reference: 'al-Hakim: 2/100 (cited by an-Nawawi in al-Adhkar)',
    ),
  ];

  // ─── MARKETPLACE / SHOPPING ──────────────────────────────────────────────────
  static List<DuaEntity> marketDuas = [
    DuaEntity(
      id: 'mk1',
      titleEn: 'When Entering the Market',
      titleUr: 'بازار میں داخل ہونے کی دعا',
      titlePs: 'بازار ته د ننوتلو دعا',
      arabic:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِي وَيُمِيتُ وَهُوَ حَيٌّ لَا يَمُوتُ بِيَدِهِ الْخَيْرُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      translationEn:
          'There is none worthy of worship except Allah, alone, without partner. To Him belongs sovereignty and all praise. He gives life and causes death, and He is living and does not die. In His hand is all good and He is capable of all things.',
      translationUr:
          'اللہ کے سوا کوئی معبود نہیں، اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہت ہے اور اسی کے لیے تعریف ہے، وہ زندہ کرتا ہے اور مارتا ہے، وہ خود زندہ ہے کبھی نہیں مرے گا، اس کے ہاتھ میں ہر بھلائی ہے اور وہ ہر چیز پر قادر ہے۔',
      translationPs:
          'له الله پرته بل معبود نشته، یو دی، شریک نه لري، پاچاهي او ستاینه یې ده، ژوندی کوي او مړ کوي، او هغه ژوندی دی نه مري، ښېګڼه یې په لاس کې ده، او هغه پر هر څه قادر دی.',
      reference: 'Tirmidhi: 3428, Ibn Majah: 2235',
    ),
  ];

  // ─── GREETING & VISITING ─────────────────────────────────────────────────────
  static List<DuaEntity> greetingDuas = [
    DuaEntity(
      id: 'gr1',
      titleEn: 'Islamic Greeting (Salam)',
      titleUr: 'اسلامی سلام',
      titlePs: 'اسلامي سلام',
      arabic: 'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ',
      translationEn:
          'Peace be upon you, and the mercy of Allah and His blessings.',
      translationUr: 'تم پر سلامتی ہو، اور اللہ کی رحمت اور اس کی برکتیں ہوں۔',
      translationPs: 'پر تاسو دې سلامتي، د الله رحمت او برکتونه وي.',
      reference: 'Abu Dawud: 5195, Tirmidhi: 2689',
    ),
    DuaEntity(
      id: 'gr2',
      titleEn: 'Response to Salam',
      titleUr: 'سلام کا جواب',
      titlePs: 'د سلام ځواب',
      arabic: 'وَعَلَيْكُمُ السَّلَامُ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ',
      translationEn:
          'And upon you be peace, and the mercy of Allah and His blessings.',
      translationUr:
          'اور تم پر بھی سلامتی ہو، اللہ کی رحمت اور اس کی برکتیں ہوں۔',
      translationPs: 'او پر تاسو دې هم سلامتي، د الله رحمت او برکتونه وي.',
      reference: 'Quran 4:86, Abu Dawud: 5196',
    ),
    DuaEntity(
      id: 'gr3',
      titleEn: 'When Meeting a Fellow Muslim',
      titleUr: 'مسلمان بھائی سے ملتے وقت',
      titlePs: 'مسلمان ورور سره د لیدو پر مهال',
      arabic: 'السَّلَامُ عَلَيْكُمْ',
      translationEn: 'Peace be upon you.',
      translationUr: 'تم پر سلامتی ہو۔',
      translationPs: 'پر تاسو دې سلامتي وي.',
      reference: 'Sahih al-Bukhari: 12',
    ),
    DuaEntity(
      id: 'gr4',
      titleEn: 'When Saying Goodbye',
      titleUr: 'رخصت کے وقت',
      titlePs: 'د خدای پامانۍ پر مهال',
      arabic: 'أَسْتَوْدِعُكَ اللَّهَ الَّذِي لَا تَضِيعُ وَدَائِعُهُ',
      translationEn:
          'I place you in the trust of Allah, whose trusts are never lost.',
      translationUr:
          'میں تجھے اللہ کے سپرد کرتا ہوں جس کی امانتیں کبھی ضائع نہیں ہوتیں۔',
      translationPs: 'زه تا الله ته سپارم چې امانتونه یې هېڅکله نه ضایع کېږي.',
      reference: 'Ibn Majah: 2825, Ahmad: 8693',
    ),
    DuaEntity(
      id: 'gr5',
      titleEn: 'When Someone Does You a Favour',
      titleUr: 'کوئی احسان کرے تو',
      titlePs: 'کله چې څوک ستا سره احسان وکړي',
      arabic: 'جَزَاكَ اللَّهُ خَيْراً',
      translationEn: 'May Allah reward you with good.',
      translationUr: 'اللہ تجھے بہترین بدلہ دے۔',
      translationPs: 'الله دې تاسو ته ښه بدله درکړي.',
      reference: 'Tirmidhi: 2035',
    ),
  ];

  // ─── SNEEZING ────────────────────────────────────────────────────────────────
  static List<DuaEntity> sneezeYawnDuas = [
    DuaEntity(
      id: 'sy1',
      titleEn: 'After Sneezing',
      titleUr: 'چھینک آنے پر',
      titlePs: 'د اټسۍ (پرنجۍ) پر مهال',
      arabic: 'الْحَمْدُ للهِ',
      translationEn: 'All praise is for Allah.',
      translationUr: 'تمام تعریفیں اللہ کے لیے ہیں۔',
      translationPs: 'ټولې ستاینې الله ته دي.',
      reference: 'Sahih al-Bukhari: 6224',
    ),
    DuaEntity(
      id: 'sy2',
      titleEn: 'Reply to Someone Who Sneezes',
      titleUr: 'چھینکنے والے کا جواب',
      titlePs: 'د اټسۍ کوونکي ته ځواب',
      arabic: 'يَرْحَمُكَ اللَّهُ',
      translationEn: 'May Allah have mercy upon you.',
      translationUr: 'اللہ تم پر رحم کرے۔',
      translationPs: 'الله دې پر تا رحم وکړي.',
      reference: 'Sahih al-Bukhari: 6224',
    ),
    DuaEntity(
      id: 'sy3',
      titleEn: 'Response After Being Told Yarhamukallah',
      titleUr: 'یرحمک اللہ کے جواب میں',
      titlePs: 'د «یرحمک الله» په ځواب کې',
      arabic: 'يَهْدِيكُمُ اللَّهُ وَيُصْلِحُ بَالَكُمْ',
      translationEn: 'May Allah guide you and set your affairs in order.',
      translationUr: 'اللہ تمہیں ہدایت دے اور تمہارے حال کو سنوارے۔',
      translationPs: 'الله دې تاسو ته هدایت وکړي او ستاسو حال سم کړي.',
      reference: 'Sahih al-Bukhari: 6224',
    ),
  ];

  // ─── WEATHER / RAIN / WIND ────────────────────────────────────────────────────
  static List<DuaEntity> weatherDuas = [
    DuaEntity(
      id: 'wt1',
      titleEn: 'When It Rains',
      titleUr: 'بارش ہوتے وقت',
      titlePs: 'کله چې باران وشي',
      arabic: 'اللَّهُمَّ صَيِّباً نَافِعاً',
      translationEn: 'O Allah, (bring) a beneficial rain.',
      translationUr: 'اے اللہ! نفع بخش بارش برسا۔',
      translationPs: 'ای الله! ګټور باران راوباروه.',
      reference: 'Sahih al-Bukhari: 1032',
    ),
    DuaEntity(
      id: 'wt2',
      titleEn: 'After Rain',
      titleUr: 'بارش کے بعد',
      titlePs: 'د باران وروسته',
      arabic: 'مُطِرْنَا بِفَضْلِ اللَّهِ وَرَحْمَتِهِ',
      translationEn: 'We have been given rain by the grace and mercy of Allah.',
      translationUr: 'ہم پر اللہ کے فضل اور رحمت سے بارش ہوئی۔',
      translationPs: 'موږ ته د الله په فضل او رحمت باران ورشو.',
      reference: 'Sahih al-Bukhari: 846, Sahih Muslim: 71',
    ),
    DuaEntity(
      id: 'wt3',
      titleEn: 'When Hearing Thunder',
      titleUr: 'گرج سننے پر',
      titlePs: 'د تندر (ګرج) اوریدو پر مهال',
      arabic:
          'سُبْحَانَ الَّذِي يُسَبِّحُ الرَّعْدُ بِحَمْدِهِ وَالْمَلَائِكَةُ مِنْ خِيفَتِهِ',
      translationEn:
          'How perfect He is, (the One) Whom the thunder glorifies and praises, and so do the angels, out of fear of Him.',
      translationUr:
          'پاک ہے وہ ذات جس کی تعریف کے ساتھ بادل گرجتا ہے اور فرشتے اس کے ڈر سے تسبیح کرتے ہیں۔',
      translationPs:
          'پاک دی هغه چې تندر یې په ستاینې سره تسبیح وايي او فرښتې هم د هغه له ویرې.',
      reference: 'al-Muwatta: 2/992',
    ),
    DuaEntity(
      id: 'wt4',
      titleEn: 'When Seeing the Crescent Moon',
      titleUr: 'نیا چاند دیکھنے پر',
      titlePs: 'نوې سپوږمۍ لیدو پر مهال',
      arabic:
          'اللَّهُمَّ أَهِلَّهُ عَلَيْنَا بِالْأَمْنِ وَالْإِيمَانِ وَالسَّلَامَةِ وَالْإِسْلَامِ، رَبِّي وَرَبُّكَ اللَّهُ',
      translationEn:
          'O Allah, let this moon appear on us with security, faith, safety and Islam. My Lord and your Lord is Allah.',
      translationUr:
          'اے اللہ! اس چاند کو ہم پر امن، ایمان، سلامتی اور اسلام کے ساتھ طلوع فرما۔ میرا اور تیرا رب اللہ ہے۔',
      translationPs:
          'ای الله! دا سپوږمۍ پر موږ د امن، ایمان، سلامتۍ او اسلام سره راپورته کړه. زما او ستا رب الله دی.',
      reference: 'Tirmidhi: 3451, Ahmad: 1397',
    ),
    DuaEntity(
      id: 'wt5',
      titleEn: 'When Strong Wind Blows',
      titleUr: 'تیز ہوا چلنے پر',
      titlePs: 'د تېز باد پر مهال',
      arabic:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَهَا وَخَيْرَ مَا فِيهَا وَخَيْرَ مَا أُرْسِلَتْ بِهِ وَأَعُوذُ بِكَ مِنْ شَرِّهَا وَشَرِّ مَا فِيهَا وَشَرِّ مَا أُرْسِلَتْ بِهِ',
      translationEn:
          'O Allah, I ask You for the good of it, the good of what it contains, and the good of what it is sent with; and I seek refuge in You from the evil of it, the evil of what it contains, and the evil of what it is sent with.',
      translationUr:
          'اے اللہ! میں تجھ سے اس کی بھلائی، اس میں جو ہے اس کی بھلائی اور اسے جس کے ساتھ بھیجا گیا اس کی بھلائی مانگتا ہوں، اور اس کے شر سے، اس میں جو ہے اس کے شر سے اور اسے جس کے ساتھ بھیجا گیا اس کے شر سے تیری پناہ مانگتا ہوں۔',
      translationPs:
          'ای الله! زه له تا د دې ښېګڼه، په دې کې د شته ښېګڼې او د هغه څه ښېګڼه چې پرې لېږل شوی غواړم، او ستا پناه غواړم له دې شر، په دې کې له شته شر او له هغه شره چې پرې لېږل شوی.',
      reference: 'Sahih Muslim: 899',
    ),
  ];

  // ─── MORNING ROUTINE ─────────────────────────────────────────────────────────
  static List<DuaEntity> morningDuas = [];

  // ─── SLEEPING ────────────────────────────────────────────────────────────────
  static List<DuaEntity> sleepingDuas = [
    DuaEntity(
      id: 'sp1',
      titleEn: 'Before Sleeping',
      titleUr: 'سونے کی دعا',
      titlePs: 'د خوب دعا',
      arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      translationEn: 'In Your name, O Allah, I die and I live.',
      translationUr: 'اے اللہ! تیرے ہی نام کے ساتھ میں مرتا ہوں اور جیتا ہوں۔',
      translationPs: 'ای الله! ستا په نوم زه مړ کېږم او ژوندی کېږم.',
      reference: 'Sahih al-Bukhari: 6312',
    ),
    DuaEntity(
      id: 'sp4',
      titleEn: 'When Waking Up Frightened in Sleep',
      titleUr: 'نیند میں ڈر کر آنکھ کھلنے پر',
      titlePs: 'کله چې په خوب کې له ویرې راویښ شي',
      arabic:
          'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ وَشَرِّ عِبَادِهِ وَمِنْ هَمَزَاتِ الشَّيَاطِينِ وَأَنْ يَحْضُرُونِ',
      translationEn:
          'I seek refuge in the perfect words of Allah from His anger, His punishment, from the evil of His slaves, from the harassment of the devils and from their presence.',
      translationUr:
          'میں اللہ کے کامل کلمات کی پناہ مانگتا ہوں اس کے غضب سے، اس کے عذاب سے، اس کے بندوں کے شر سے، شیطانوں کے وسوسوں سے اور ان کی حاضری سے۔',
      translationPs:
          'زه د الله په بشپړو کلماتو پناه غواړم له هغه له غضبه، له عذابه، د هغه د بندګانو له شره، د شیطانانو له وسوسو او له دې چې دوی ما ته حاضر شي.',
      reference: 'Abu Dawud: 3893, Tirmidhi: 3528',
    ),
  ];

  // ─── HOME & FAMILY ────────────────────────────────────────────────────────────
  static List<DuaEntity> homeFamilyDuas = [
    DuaEntity(
      id: 'hf1',
      titleEn: 'Dua for Parents',
      titleUr: 'والدین کے لیے دعا',
      titlePs: 'د مور او پلار لپاره دعا',
      arabic: 'رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيراً',
      translationEn:
          'My Lord, have mercy upon them as they brought me up (when I was) small.',
      translationUr:
          'اے میرے رب! ان پر رحم فرما جیسا کہ انہوں نے بچپن میں مجھے پالا۔',
      translationPs:
          'ای زما ربه! پر دوی رحم وکړه لکه څنګه چې دوی زه په وړوکتوب کې وروزلم.',
      reference: 'Quran 17:24',
    ),
    DuaEntity(
      id: 'hf2',
      titleEn: 'Dua for Spouse and Children',
      titleUr: 'بیوی اور بچوں کے لیے دعا',
      titlePs: 'د ښځې او اولاد لپاره دعا',
      arabic:
          'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَاماً',
      translationEn:
          'Our Lord, grant us from among our wives and offspring comfort to our eyes and make us an example for the righteous.',
      translationUr:
          'اے ہمارے رب! ہمیں ہماری بیویوں اور اولادوں سے آنکھوں کی ٹھنڈک عطا فرما اور ہمیں پرہیزگاروں کا امام بنا۔',
      translationPs:
          'ای زموږ ربه! موږ ته له زموږ له ښځو او اولادونو څخه د سترګو یخوالی راکړه او موږ د پرهېزګارانو مشر کړه.',
      reference: 'Quran 25:74',
    ),
    DuaEntity(
      id: 'hf3',
      titleEn: 'Dua for Righteous Children',
      titleUr: 'نیک اولاد کی دعا',
      titlePs: 'د نېکو اولادونو دعا',
      arabic: 'رَبِّ هَبْ لِي مِنَ الصَّالِحِينَ',
      translationEn: 'My Lord, grant me (a child) from among the righteous.',
      translationUr: 'اے میرے رب! مجھے نیک (اولاد) عطا فرما۔',
      translationPs: 'ای زما ربه! ما ته له نېکانو (اولاد) راکړه.',
      reference: 'Quran 37:100',
    ),
  ];

  // ─── WORK & STUDY ─────────────────────────────────────────────────────────────
  static List<DuaEntity> workStudyDuas = [
    DuaEntity(
      id: 'ws1',
      titleEn: 'Dua for Knowledge',
      titleUr: 'علم کی دعا',
      titlePs: 'د علم دعا',
      arabic: 'رَبِّ زِدْنِي عِلْماً',
      translationEn: 'My Lord, increase me in knowledge.',
      translationUr: 'اے میرے رب! میرے علم میں اضافہ فرما۔',
      translationPs: 'ای زما ربه! زما علم زیات کړه.',
      reference: 'Quran 20:114',
    ),
    DuaEntity(
      id: 'ws2',
      titleEn: 'Dua Before Studying or Starting Important Work',
      titleUr: 'پڑھائی یا اہم کام شروع کرنے سے پہلے',
      titlePs: 'له لوست یا مهم کار د پیل وړاندې',
      arabic:
          'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي يَفْقَهُوا قَوْلِي',
      translationEn:
          'My Lord, expand my breast (with assurance), ease my task for me, and remove the impediment from my speech so they may understand my speech.',
      translationUr:
          'اے میرے رب! میرا سینہ کھول دے، میرا کام آسان کر دے اور میری زبان کی گرہ کھول دے تاکہ لوگ میری بات سمجھ سکیں۔',
      translationPs:
          'ای زما ربه! زما سینه پرانیزه، زما کار راته اسانه کړه، او زما د ژبې ګنډه خلاصه کړه چې زما خبره وپوهېږي.',
      reference: 'Quran 20:25-28',
    ),
    DuaEntity(
      id: 'ws3',
      titleEn: 'Dua for Tawakkul (Reliance on Allah) in Work',
      titleUr: 'کام میں توکل کی دعا',
      titlePs: 'په کار کې د توکل دعا',
      arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      translationEn:
          'Allah is sufficient for us, and He is the best Disposer of affairs.',
      translationUr: 'اللہ ہمارے لیے کافی ہے اور وہ بہترین کارساز ہے۔',
      translationPs: 'الله موږ ته بس دی او هغه ښه کارساز دی.',
      reference: 'Quran 3:173, Sahih al-Bukhari: 4563',
    ),
    DuaEntity(
      id: 'ws4',
      titleEn: 'When Facing a Difficult Task',
      titleUr: 'مشکل کام کے وقت',
      titlePs: 'د ستونزمن کار پر مهال',
      arabic:
          'اللَّهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلاً وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلاً',
      translationEn:
          'O Allah, there is no ease except what You make easy, and You make the difficult easy when You will.',
      translationUr:
          'اے اللہ! کوئی آسانی نہیں مگر جسے تو آسان کرے، اور تو جب چاہے مشکل کو آسان بنا دیتا ہے۔',
      translationPs:
          'ای الله! هېڅ څه اسانه نه دي مګر هغه چې ته یې اسانوې، او ته چې وغواړې ستونزمن اسانوې.',
      reference: 'Ibn Hibban: 2427, Ibn al-Sunni: 351',
    ),
    DuaEntity(
      id: 'ws5',
      titleEn: 'Dua for Rizq (Sustenance)',
      titleUr: 'رزق کی دعا',
      titlePs: 'د روزۍ دعا',
      arabic:
          'اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
      translationEn:
          'O Allah, suffice me with what You have made lawful against what You have made forbidden, and enrich me by Your bounty against all others.',
      translationUr:
          'اے اللہ! حرام سے بچاتے ہوئے مجھے حلال سے کافی کر دے، اور اپنے فضل سے مجھے اپنے سوا سب سے بے نیاز کر دے۔',
      translationPs:
          'ای الله! ما له حرامو په خپلو حلالو بس کړه او په خپل فضل ما له ټولو پرته له خپل ځانه بې نیازه کړه.',
      reference: 'Tirmidhi: 3563',
    ),
    DuaEntity(
      id: 'ws6',
      titleEn: 'Dua for Good in This World and the Hereafter',
      titleUr: 'دنیا اور آخرت کی بھلائی کی دعا',
      titlePs: 'په دواړو جهانونو کې د ښېګڼې دعا',
      arabic:
          'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      translationEn:
          'Our Lord, give us in this world (that which is) good and in the Hereafter (that which is) good and protect us from the punishment of the Fire.',
      translationUr:
          'اے ہمارے رب! ہمیں دنیا میں بھی بھلائی دے اور آخرت میں بھی بھلائی دے اور ہمیں آگ کے عذاب سے بچا۔',
      translationPs:
          'ای زموږ ربه! موږ ته په دنیا کې ښېګڼه راکړه او په اخرت کې هم ښېګڼه راکړه او موږ د اور له عذابه وساته.',
      reference: 'Quran 2:201, Sahih al-Bukhari: 4522',
    ),
  ];

  // ─── MIRROR DUA ──────────────────────────────────────────────────────────────
  static List<DuaEntity> mirrorDuas = [
    DuaEntity(
      id: 'mr1',
      titleEn: 'When Looking in the Mirror',
      titleUr: 'آئینہ دیکھنے کی دعا',
      titlePs: 'کله چې په هېنداره کې ګوري',
      arabic: 'اللَّهُمَّ أَنْتَ حَسَّنْتَ خَلْقِي فَحَسِّنْ خُلُقِي',
      translationEn:
          'O Allah, You have made my physical constitution good, so make my character good as well.',
      translationUr:
          'اے اللہ! تو نے میری ظاہری ساخت کو اچھا بنایا ہے تو میرے اخلاق کو بھی اچھا بنا دے۔',
      translationPs: 'ای الله! تا زما بڼه ښه کړې، نو زما اخلاق هم ښه کړه.',
      reference: 'Ahmad: 3823, Ibn Hibban: 959',
    ),
  ];

  // ─── MISCELLANEOUS DAILY DUAS ─────────────────────────────────────────────────
  static List<DuaEntity> miscDuas = [
    DuaEntity(
      id: 'ms2',
      titleEn: 'When Something Good Happens or Is Praised',
      titleUr: 'خوشی کی بات ہو یا تعریف ملے',
      titlePs: 'کله چې څه ښه پېښ شي',
      arabic: 'الْحَمْدُ للهِ',
      translationEn: 'All praise is for Allah.',
      translationUr: 'تمام تعریفیں اللہ کے لیے ہیں۔',
      translationPs: 'ټولې ستاینې الله ته دي.',
      reference: 'Quran 1:2',
    ),
    DuaEntity(
      id: 'ms4',
      titleEn: 'When Something Undesirable Happens',
      titleUr: 'ناپسندیدہ بات ہو جائے',
      titlePs: 'کله چې ناخوښ څه پېښ شي',
      arabic: 'قَدَّرَ اللَّهُ وَمَا شَاءَ فَعَلَ',
      translationEn: 'Allah has decreed and what He wills He does.',
      translationUr: 'اللہ نے تقدیر میں لکھا اور جو وہ چاہتا ہے کر دیتا ہے۔',
      translationPs: 'الله مقدر کړی او هر څه چې وغواړي کوي یې.',
      reference: 'Sahih Muslim: 2664',
    ),
    DuaEntity(
      id: 'ms5',
      titleEn: 'When Angry',
      titleUr: 'غصہ آنے پر',
      titlePs: 'کله چې قهر راشي',
      arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
      translationEn: 'I seek refuge in Allah from the accursed devil.',
      translationUr: 'میں مردود شیطان سے اللہ کی پناہ مانگتا ہوں۔',
      translationPs: 'زه له مردود شیطانه د الله پناه غواړم.',
      reference: 'Sahih al-Bukhari: 3282, Sahih Muslim: 2610',
    ),
    DuaEntity(
      id: 'ms6',
      titleEn: 'When Seeing Someone in Trial or Calamity',
      titleUr: 'کسی کو مصیبت میں دیکھنے پر',
      titlePs: 'کله چې څوک په ازمېښت کې ووینې',
      arabic:
          'الْحَمْدُ للهِ الَّذِي عَافَانِي مِمَّا ابْتَلَاكَ بِهِ وَفَضَّلَنِي عَلَى كَثِيرٍ مِمَّنْ خَلَقَ تَفْضِيلاً',
      translationEn:
          'All praise is for Allah who saved me from that which He has tested you with, and favoured me greatly over many of those He has created.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس نے مجھے اس آزمائش سے بچایا جس میں اس نے تجھے مبتلا کیا اور اپنی بہت سی مخلوق پر مجھے فضیلت دی۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې ما یې له هغه څه وساتلم چې ته پرې آزمایل شوی یې، او ما یې پر ډېرو مخلوقاتو فضیلت راکړ.',
      reference: 'Tirmidhi: 3432',
    ),
    DuaEntity(
      id: 'ms8',
      titleEn: 'When Experiencing Hardship',
      titleUr: 'مصیبت اور تکلیف کے وقت',
      titlePs: 'په مصیبت کې',
      arabic:
          'إِنَّا للهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ، اللَّهُمَّ أْجُرْنِي فِي مُصِيبَتِي وَأَخْلِفْ لِي خَيْراً مِنْهَا',
      translationEn:
          'Indeed we belong to Allah, and indeed to Him we will return. O Allah, recompense me for my affliction and replace it for me with something better.',
      translationUr:
          'بے شک ہم اللہ کے ہیں اور اسی کی طرف لوٹنے والے ہیں۔ اے اللہ! مجھے میری مصیبت کا اجر دے اور اس سے بہتر بدل دے۔',
      translationPs:
          'بېشکه موږ د الله یو او هغه ته ورګرځېدونکي یو. ای الله! ما ته زما په مصیبت کې اجر راکړه او له دې ښه بدل راکړه.',
      reference: 'Sahih Muslim: 918',
    ),
    DuaEntity(
      id: 'ms9',
      titleEn: 'When Feeling Overwhelmed (Anxiety)',
      titleUr: 'پریشانی اور غم میں',
      titlePs: 'کله چې غم او اندېښنه وي',
      arabic:
          'اللَّهُمَّ إِنِّي عَبْدُكَ وَابْنُ عَبْدِكَ وَابْنُ أَمَتِكَ نَاصِيَتِي بِيَدِكَ مَاضٍ فِيَّ حُكْمُكَ عَدْلٌ فِيَّ قَضَاؤُكَ أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ سَمَّيْتَ بِهِ نَفْسَكَ أَوْ أَنْزَلْتَهُ فِي كِتَابِكَ أَوْ عَلَّمْتَهُ أَحَداً مِنْ خَلْقِكَ أَوِ اسْتَأْثَرْتَ بِهِ فِي عِلْمِ الْغَيْبِ عِنْدَكَ أَنْ تَجْعَلَ الْقُرْآنَ رَبِيعَ قَلْبِي وَنُورَ صَدْرِي وَجِلَاءَ حُزْنِي وَذَهَابَ هَمِّي',
      translationEn:
          'O Allah, I am Your slave and the son of Your slave and the son of Your female slave. My forelock is in Your hand. Your command over me is forever executed and Your decree over me is just. I ask You by every Name belonging to You which You named Yourself with, or revealed in Your Book, or You taught to any of Your creation, or You have preserved in the knowledge of the unseen with You, that You make the Quran the spring of my heart, the light of my chest, the departure of my sadness and the release of my anxiety.',
      translationUr:
          'اے اللہ! میں تیرا بندہ ہوں، تیرے بندے کا بیٹا ہوں، تیری بندی کا بیٹا ہوں، میری پیشانی تیرے ہاتھ میں ہے، تیرا حکم مجھ پر جاری ہے، تیرا فیصلہ میرے بارے میں عدل پر ہے۔ میں تجھ سے تیرے ہر اس نام کے واسطے سے مانگتا ہوں جو تو نے خود رکھا یا اپنی کتاب میں نازل کیا یا اپنی کسی مخلوق کو سکھایا یا علم غیب میں اپنے پاس محفوظ رکھا کہ قرآن کو میرے دل کی بہار، میرے سینے کا نور، میرے غم کا علاج اور میری پریشانی کا خاتمہ بنا دے۔',
      translationPs:
          'ای الله! زه ستا بنده یم، ستا د بنده زوی یم، ستا د وینځې زوی یم. زما تندی ستا په لاس کې دی، ستا حکم پر ما جاري دی، ستا پرېکړه زما په اړه عادلانه ده. زه له تا ستا د هر هغه نوم په وسیله غواړم چې ته پرې خپل ځان نومولی یا دې په خپل کتاب کې نازل کړی، یا دې خپل یو مخلوق ته ښودلی، یا دې په غیبي علم کې له ځان سره ساتلی، چې قرآن زما د زړه پسرلی، زما د سینې رڼا، زما د غم دوا او زما د اندېښنې د ختمېدو سبب وګرځوې.',
      reference: 'Ahmad: 3712, graded Sahih by Ibn Hibban',
    ),
    DuaEntity(
      id: 'ms11',
      titleEn: 'Dua for Protection of Faith',
      titleUr: 'دین کی حفاظت کی دعا',
      titlePs: 'د دین د ساتنې دعا',
      arabic: 'اللَّهُمَّ لَا تَجْعَلْ مُصِيبَتَنَا فِي دِينِنَا',
      translationEn: 'O Allah, do not make our calamity in our religion.',
      translationUr: 'اے اللہ! ہماری مصیبت ہمارے دین میں نہ ڈال۔',
      translationPs: 'ای الله! زموږ مصیبت زموږ په دین کې مه کړه.',
      reference: 'Tirmidhi: 3502',
    ),
    DuaEntity(
      id: 'ms12',
      titleEn: 'Seeking Forgiveness Throughout the Day',
      titleUr: 'دن میں استغفار',
      titlePs: 'په ورځ کې استغفار',
      arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      translationEn: 'I seek the forgiveness of Allah and repent to Him.',
      translationUr:
          'میں اللہ سے مغفرت مانگتا ہوں اور اس کی طرف توبہ کرتا ہوں۔',
      translationPs: 'زه له الله بخښنه غواړم او هغه ته توبه کوم.',
      reference: 'Sahih al-Bukhari: 6307, Sahih Muslim: 2702',
    ),
    DuaEntity(
      id: 'ms13',
      titleEn: 'Seeking Forgiveness (Sayyid al-Istighfar)',
      titleUr: 'سید الاستغفار',
      titlePs: 'سید الاستغفار',
      arabic:
          'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      translationEn:
          'O Allah, You are my Lord, there is none worthy of worship except You. You created me and I am Your slave, and I am faithful to my covenant and my promise as much as I can. I seek refuge with You from all the evil I have done. I acknowledge before You all the blessings You have bestowed upon me, and I confess to You all my sins. So I entreat You to forgive my sins, for nobody can forgive sins except You.',
      translationUr:
          'اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں، تو نے مجھے پیدا کیا اور میں تیرا بندہ ہوں، میں اپنی استطاعت کے مطابق تیرے عہد اور وعدے پر قائم ہوں، جو برائیاں میں نے کی ہیں ان کے شر سے تیری پناہ مانگتا ہوں، اپنے اوپر تیری نعمتوں کا اقرار کرتا ہوں اور اپنے گناہوں کا اعتراف کرتا ہوں، پس مجھے بخش دے کیونکہ گناہ معاف کرنے والا تیرے سوا کوئی نہیں۔',
      translationPs:
          'ای الله! ته زما رب یې، له تا پرته بل معبود نشته. تا زه پیدا کړی یم او زه ستا بنده یم، او زه د خپل توان تر حده ستا په عهد او ژمنه ولاړ یم. له هغه شره چې ما کړی ستا پناه غواړم. پر ما د ستا نعمتونه منم او خپل ګناه اعتراف کوم، نو ما وبخښه، ځکه چې له تا پرته بل څوک ګناهونه نه بخښي.',
      reference: 'Sahih al-Bukhari: 6306',
    ),
    DuaEntity(
      id: 'ms16',
      titleEn: 'When Wearing New Clothes',
      titleUr: 'نئے کپڑے پہنتے وقت',
      titlePs: 'نوې جامې اغوستلو پر مهال',
      arabic:
          'اللَّهُمَّ لَكَ الْحَمْدُ أَنْتَ كَسَوْتَنِيهِ أَسْأَلُكَ مِنْ خَيْرِهِ وَخَيْرِ مَا صُنِعَ لَهُ وَأَعُوذُ بِكَ مِنْ شَرِّهِ وَشَرِّ مَا صُنِعَ لَهُ',
      translationEn:
          'O Allah, for You is all praise, You have clothed me with it. I ask You for its good and the good of what it was made for, and I seek refuge with You from its evil and the evil of what it was made for.',
      translationUr:
          'اے اللہ! تمام تعریفیں تیرے لیے ہیں، تو نے مجھے یہ پہنایا، میں تجھ سے اس کی بھلائی اور جس مقصد کے لیے بنایا گیا اس کی بھلائی مانگتا ہوں، اور اس کے شر اور جس مقصد کے لیے بنایا گیا اس کے شر سے تیری پناہ مانگتا ہوں۔',
      translationPs:
          'ای الله! ټولې ستاینې ستا دي، ته دا ما ته واغوستله. زه له تا د دې ښېګڼه او د هغه مقصد ښېګڼه غواړم چې دا ورته جوړه شوې، او ستا پناه غواړم له دې شر او له هغه مقصد شر چې دا ورته جوړه شوې.',
      reference: 'Abu Dawud: 4020, Tirmidhi: 1767',
    ),
    DuaEntity(
      id: 'ms18',
      titleEn: 'Khutbat al-Hajah (Beginning a Sermon or Speech)',
      titleUr: 'خطبۂ حاجہ (خطبہ یا تقریر کے آغاز میں)',
      titlePs: 'د خطبې یا وینا د پیل دعا (خطبة الحاجة)',
      arabic:
          'إِنَّ الْحَمْدَ للهِ، نَحْمَدُهُ وَنَسْتَعِينُهُ وَنَسْتَغْفِرُهُ، وَنَعُوذُ بِاللَّهِ مِنْ شُرُورِ أَنْفُسِنَا وَمِنْ سَيِّئَاتِ أَعْمَالِنَا، مَنْ يَهْدِهِ اللَّهُ فَلَا مُضِلَّ لَهُ، وَمَنْ يُضْلِلْ فَلَا هَادِيَ لَهُ',
      translationEn:
          'Verily, all praise is for Allah. We praise Him, seek His help, seek His forgiveness. We seek refuge in Allah from the evil of our souls and the evil of our deeds. Whoever Allah guides, there is none to misguide him, and whoever Allah misguides, there is none to guide him.',
      translationUr:
          'بے شک تمام تعریفیں اللہ کے لیے ہیں۔ ہم اس کی حمد کرتے ہیں، اس سے مدد مانگتے ہیں اور اس سے مغفرت چاہتے ہیں۔ ہم اللہ کی پناہ مانگتے ہیں اپنے نفسوں کے شر اور اپنے برے اعمال سے۔ جسے اللہ ہدایت دے اسے کوئی گمراہ نہیں کر سکتا اور جسے وہ گمراہ کرے اسے کوئی ہدایت نہیں دے سکتا۔',
      translationPs:
          'بېشکه ټولې ستاینې الله ته دي. موږ یې ستاینه کوو، له هغه مرسته غواړو او له هغه بخښنه غواړو. له خپلو نفسونو له شره او خپلو بدو اعمالو د الله پناه غواړو. چې الله یې هدایت کړي هېڅوک یې ګمراه نشي کولای، او چې الله یې ګمراه کړي هېڅوک یې هدایت نشي کولای.',
      reference: 'Sahih Muslim: 868, Abu Dawud: 2118',
    ),
    DuaEntity(
      id: 'ms20',
      titleEn: 'Expiation of a Gathering (Kaffaratul Majlis)',
      titleUr: 'مجلس کا کفارہ',
      titlePs: 'د مجلس کفاره',
      arabic:
          'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ أَسْتَغْفِرُكَ وَأَتُوبُ إِلَيْكَ',
      translationEn:
          'How perfect You are O Allah, and I praise You. I bear witness that none has the right to be worshipped except You. I seek Your forgiveness and repent to You.',
      translationUr:
          'اے اللہ! تو پاک ہے اور میں تیری تعریف کرتا ہوں، میں گواہی دیتا ہوں کہ تیرے سوا کوئی معبود نہیں، میں تجھ سے مغفرت مانگتا ہوں اور تیری طرف توبہ کرتا ہوں۔',
      translationPs:
          'ای الله! ته پاک یې او زه ستا ستاینه کوم. زه شاهدي ورکوم چې له تا پرته بل معبود نشته. زه له تا بخښنه غواړم او تا ته توبه کوم.',
      reference: 'Abu Dawud: 4857, Tirmidhi: 3433',
    ),
    DuaEntity(
      id: 'ms22',
      titleEn: 'When Seeing the First Fruits of the Season',
      titleUr: 'موسم کا پہلا پھل دیکھنے پر',
      titlePs: 'د موسم لومړۍ میوه لیدو پر مهال',
      arabic:
          'اللَّهُمَّ بَارِكْ لَنَا فِي ثَمَرِنَا وَبَارِكْ لَنَا فِي مَدِينَتِنَا وَبَارِكْ لَنَا فِي صَاعِنَا وَبَارِكْ لَنَا فِي مُدِّنَا',
      translationEn:
          'O Allah, bless us in our fruit, bless us in our city, bless us in our Saa\' and bless us in our Mudd.',
      translationUr:
          'اے اللہ! ہمارے پھلوں میں برکت دے، ہمارے شہر میں برکت دے، ہمارے صاع میں برکت دے اور ہمارے مد میں برکت دے۔',
      translationPs:
          'ای الله! زموږ په میوو کې برکت راکړه، زموږ په ښار کې برکت راکړه، زموږ په صاع کې برکت راکړه او زموږ په مد کې برکت راکړه.',
      reference: 'Sahih Muslim: 1373',
    ),
    DuaEntity(
      id: 'ms23',
      titleEn: 'When Hearing Good News',
      titleUr: 'خوشخبری سننے پر',
      titlePs: 'د ښې خبرې اوریدو پر مهال',
      arabic: 'الْحَمْدُ للهِ الَّذِي بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ',
      translationEn:
          'All praise is for Allah by Whose grace good deeds are completed.',
      translationUr:
          'تمام تعریفیں اللہ کے لیے ہیں جس کی نعمت سے نیک کام پورے ہوتے ہیں۔',
      translationPs:
          'ټولې ستاینې الله ته دي چې د هغه په نعمت نېک کارونه بشپړېږي.',
      reference: 'Ibn Majah: 3803',
    ),
    DuaEntity(
      id: 'ms24',
      titleEn: 'When Intending to Do Something',
      titleUr: 'کچھ کرنے کا ارادہ ہو تو',
      titlePs: 'کله چې د کوم کار ارادې وي',
      arabic: 'إِنْ شَاءَ اللَّهُ',
      translationEn: 'If Allah wills.',
      translationUr: 'اگر اللہ نے چاہا۔',
      translationPs: 'که الله وغواړي.',
      reference: 'Quran 18:23-24',
    ),
    DuaEntity(
      id: 'ms25',
      titleEn: 'When Praising Others (to avoid Evil Eye)',
      titleUr: 'تعریف کرتے وقت نظر بد سے بچنے کی دعا',
      titlePs: 'د نورو ستاینې پر مهال (له بد نظره)',
      arabic: 'مَا شَاءَ اللَّهُ لَا قُوَّةَ إِلَّا بِاللَّهِ',
      translationEn:
          'Whatever Allah wills (will come to pass); there is no power except in Allah.',
      translationUr:
          'اللہ نے جو چاہا (وہ ہوتا ہے)؛ کوئی طاقت نہیں مگر اللہ کے ساتھ۔',
      translationPs:
          'هغه چې الله وغواړي (هماغه کېږي)، هېڅ ځواک نشته مګر د الله په مرسته.',
      reference: 'Quran 18:39',
    ),
    DuaEntity(
      id: 'ms29',
      titleEn: 'Protection for Children',
      titleUr: 'بچوں کو نظر بد سے محفوظ کرنا',
      titlePs: 'د ماشومانو ساتنه',
      arabic:
          'أُعِيذُكُمَا بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ وَمِنْ كُلِّ عَيْنٍ لَامَّةٍ',
      translationEn:
          'I seek protection for you both in the perfect words of Allah from every devil and every poisonous creature, and from every evil eye.',
      translationUr:
          'میں تم دونوں کو اللہ کے کامل کلمات کی پناہ میں دیتا ہوں ہر شیطان، زہریلے جانور اور ہر نقصان دہ نظر سے۔',
      translationPs:
          'زه تاسو دواړه د الله په بشپړو کلماتو پناه کې ورکوم له هر شیطانه، زهري حشرې او له هر زیانمنوونکې سترګې.',
      reference: 'Sahih al-Bukhari: 3371',
    ),
    DuaEntity(
      id: 'ms30',
      titleEn: 'When Visiting a Graveyard',
      titleUr: 'قبرستان جاتے وقت',
      titlePs: 'هديرې ته د تګ پر مهال',
      arabic:
          'السَّلَامُ عَلَيْكُمْ أَهْلَ الدِّيَارِ مِنَ الْمُؤْمِنِينَ وَالْمُسْلِمِينَ وَإِنَّا إِنْ شَاءَ اللَّهُ بِكُمْ لَاحِقُونَ نَسْأَلُ اللَّهَ لَنَا وَلَكُمُ الْعَافِيَةَ',
      translationEn:
          'Peace be upon you, O inhabitants of these dwellings, from among the believers and those who are Muslims. And we will, if Allah wills, be joining you. We ask Allah for well-being for ourselves and for you.',
      translationUr:
          'تم پر سلامتی ہو اے اس جگہ کے رہنے والو، مومنوں اور مسلمانوں میں سے۔ اور ہم بھی ان شاء اللہ تم سے ملنے والے ہیں۔ ہم اپنے لیے اور تمہارے لیے اللہ سے عافیت مانگتے ہیں۔',
      translationPs:
          'پر تاسو دې سلامتي وي ای د دې ځایونو اوسېدونکو، له مومنانو او مسلمانانو. او که الله وغواړي موږ هم تاسو سره یو ځای کېدونکي یو. موږ له الله زموږ او ستاسو لپاره عافیت غواړو.',
      reference: 'Sahih Muslim: 975',
    ),
    DuaEntity(
      id: 'ms31',
      titleEn: 'Prompting the Dying Person (Talqin)',
      titleUr: 'مرنے والے کو تلقین',
      titlePs: 'مرګ ته نژدې کس ته تلقین',
      arabic: 'لَا إِلَهَ إِلَّا اللَّهُ',
      translationEn: 'There is none worthy of worship except Allah.',
      translationUr: 'اللہ کے سوا کوئی معبود نہیں۔',
      translationPs: 'له الله پرته بل معبود نشته.',
      reference: 'Sahih Muslim: 916',
    ),
    DuaEntity(
      id: 'ms32',
      titleEn: 'Upon Hearing of Someone\'s Death',
      titleUr: 'کسی کی موت کی خبر سن کر',
      titlePs: 'د چا د مرګ خبر اوریدو پر مهال',
      arabic:
          'إِنَّا للهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ، اللَّهُمَّ اغْفِرْ لَهُ وَارْحَمْهُ وَعَافِهِ وَاعْفُ عَنْهُ',
      translationEn:
          'Verily, to Allah we belong and to Him we return. O Allah, forgive him and have mercy on him, and grant him well-being and pardon him.',
      translationUr:
          'بے شک ہم اللہ کے ہیں اور اسی کی طرف لوٹنے والے ہیں۔ اے اللہ! اسے بخش دے، اس پر رحم فرما، اسے عافیت دے اور اسے معاف کر دے۔',
      translationPs:
          'بېشکه موږ د الله یو او هغه ته ورګرځېدونکي یو. ای الله! هغه وبخښه، پر هغه رحم وکړه، هغه ته عافیت ورکړه او له هغه تېرې شه.',
      reference: 'Sahih Muslim: 918, 963',
    ),
    DuaEntity(
      id: 'ms35',
      titleEn: 'Dua Against Evil Eye (Ruqyah)',
      titleUr: 'نظر بد کے لیے دعا',
      titlePs: 'د بد نظر دم',
      arabic:
          'بِسْمِ اللَّهِ أَرْقِيكَ مِنْ كُلِّ شَيْءٍ يُؤْذِيكَ مِنْ شَرِّ كُلِّ نَفْسٍ أَوْ عَيْنٍ حَاسِدٍ اللَّهُ يَشْفِيكَ بِسْمِ اللَّهِ أَرْقِيكَ',
      translationEn:
          'In the name of Allah I perform ruqyah for you, from everything that harms you, from the evil of every soul or envious eye may Allah cure you. In the name of Allah I perform ruqyah for you.',
      translationUr:
          'اللہ کے نام سے میں تم پر دم کرتا ہوں، ہر اس چیز سے جو تمہیں نقصان دے، ہر نفس کے شر سے یا حسد کرنے والی آنکھ سے، اللہ تمہیں شفا دے۔ اللہ کے نام سے میں تم پر دم کرتا ہوں۔',
      translationPs:
          'د الله په نامه زه پر تا دم کوم، له هر هغه څه چې تا ته زیان رسوي، له هر نفس شره یا حسد کوونکې سترګې، الله دې تا ته شفا درکړي. د الله په نامه زه پر تا دم کوم.',
      reference: 'Sahih Muslim: 2186',
    ),
    DuaEntity(
      id: 'ms36',
      titleEn: 'When Looking at the Sky',
      titleUr: 'آسمان کی طرف دیکھتے وقت',
      titlePs: 'اسمان ته کتلو پر مهال',
      arabic:
          'رَبَّنَا مَا خَلَقْتَ هَذَا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ',
      translationEn:
          'Our Lord, You have not created this in vain. Glory be to You, so protect us from the punishment of the Fire.',
      translationUr:
          'اے ہمارے رب! تو نے یہ بیکار نہیں بنایا، تو پاک ہے، ہمیں آگ کے عذاب سے بچا۔',
      translationPs:
          'ای زموږ ربه! تا دا بې ځایه نه دي پيدا کړي، ته پاک یې، نو موږ د اور له عذابه وساته.',
      reference: 'Quran 3:191',
    ),
  ];

  // ─── ALL CATEGORIES ──────────────────────────────────────────────────────────
  static List<DuaCategory> categories = [
    DuaCategory(
      id: 'waking_up',
      titleEn: 'Waking Up',
      titleUr: 'بیدار ہونا',
      titlePs: 'له خوبه راپاڅېدل',
      duas: wakingUpDuas,
    ),
    DuaCategory(
      id: 'toilet',
      titleEn: 'Toilet',
      titleUr: 'بیت الخلا',
      titlePs: 'تشناب',
      duas: toiletDuas,
    ),
    DuaCategory(
      id: 'wudu',
      titleEn: 'Wudu (Ablution)',
      titleUr: 'وضو',
      titlePs: 'اودس',
      duas: wuduDuas,
    ),
    DuaCategory(
      id: 'clothing',
      titleEn: 'Clothing',
      titleUr: 'لباس',
      titlePs: 'جامې',
      duas: clothingDuas,
    ),
    DuaCategory(
      id: 'home',
      titleEn: 'Home (Entering & Leaving)',
      titleUr: 'گھر (آنا اور جانا)',
      titlePs: 'کور (ننوتل او وتل)',
      duas: homeDuas,
    ),
    DuaCategory(
      id: 'food',
      titleEn: 'Food & Drink',
      titleUr: 'کھانا اور پینا',
      titlePs: 'خوراک او څښاک',
      duas: foodDuas,
    ),
    DuaCategory(
      id: 'mosque',
      titleEn: 'Mosque',
      titleUr: 'مسجد',
      titlePs: 'جومات',
      duas: mosqueDuas,
    ),
    DuaCategory(
      id: 'adhan',
      titleEn: 'Adhan',
      titleUr: 'اذان',
      titlePs: 'اذان',
      duas: adhanDuas,
    ),
    DuaCategory(
      id: 'salah',
      titleEn: 'Salah (Prayer)',
      titleUr: 'نماز',
      titlePs: 'لمونځ',
      duas: salahDuas,
    ),
    DuaCategory(
      id: 'travel',
      titleEn: 'Travel',
      titleUr: 'سفر',
      titlePs: 'سفر',
      duas: travelDuas,
    ),
    DuaCategory(
      id: 'market',
      titleEn: 'Market / Shopping',
      titleUr: 'بازار',
      titlePs: 'بازار',
      duas: marketDuas,
    ),
    DuaCategory(
      id: 'greeting',
      titleEn: 'Greeting & Visiting',
      titleUr: 'سلام اور ملاقات',
      titlePs: 'سلام او کتنه',
      duas: greetingDuas,
    ),
    DuaCategory(
      id: 'sneeze_yawn',
      titleEn: 'Sneezing',
      titleUr: 'چھینک',
      titlePs: 'اټسۍ (پرنجۍ)',
      duas: sneezeYawnDuas,
    ),
    DuaCategory(
      id: 'weather',
      titleEn: 'Weather',
      titleUr: 'موسم',
      titlePs: 'هوا او موسم',
      duas: weatherDuas,
    ),
    DuaCategory(
      id: 'mirror',
      titleEn: 'Mirror',
      titleUr: 'آئینہ',
      titlePs: 'هېنداره',
      duas: mirrorDuas,
    ),
    DuaCategory(
      id: 'sleeping',
      titleEn: 'Sleeping',
      titleUr: 'سونا',
      titlePs: 'خوب',
      duas: sleepingDuas,
    ),
    DuaCategory(
      id: 'home_family',
      titleEn: 'Home & Family',
      titleUr: 'گھر اور خاندان',
      titlePs: 'کور او کورنۍ',
      duas: homeFamilyDuas,
    ),
    DuaCategory(
      id: 'work_study',
      titleEn: 'Work & Study',
      titleUr: 'کام اور تعلیم',
      titlePs: 'کار او زده کړه',
      duas: workStudyDuas,
    ),
    DuaCategory(
      id: 'misc',
      titleEn: 'Daily Situations',
      titleUr: 'روزمرہ کے حالات',
      titlePs: 'ورځنۍ پېښې',
      duas: miscDuas,
    ),
  ];

  static List<DuaEntity> allDuas = [
    ...wakingUpDuas,
    ...toiletDuas,
    ...wuduDuas,
    ...clothingDuas,
    ...homeDuas,
    ...foodDuas,
    ...mosqueDuas,
    ...adhanDuas,
    ...salahDuas,
    ...travelDuas,
    ...marketDuas,
    ...greetingDuas,
    ...sneezeYawnDuas,
    ...weatherDuas,
    ...mirrorDuas,
    ...morningDuas,
    ...sleepingDuas,
    ...homeFamilyDuas,
    ...workStudyDuas,
    ...miscDuas,
  ];
}
