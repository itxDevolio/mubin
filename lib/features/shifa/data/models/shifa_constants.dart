import '../../domain/entities/shifa_entity.dart';

class ShifaCategory {
  final String id;
  final String titleEn;
  final String titleUr;
  final String titlePs;
  final List<ShifaEntity> duas;

  ShifaCategory({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    this.titlePs = '',
    required this.duas,
  });
}

class ShifaConstants {
  static List<ShifaEntity> physicalPain = [
    ShifaEntity(
      id: 'p1',
      titleEn: 'Pain in Body',
      titleUr: 'جسمانی درد کے لیے',
      titlePs: 'د بدن د درد لپاره',
      arabic:
      'بِسْمِ اللَّهِ\nبِسْمِ اللَّهِ\nبِسْمِ اللَّهِ\nأَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
      translationEn:
      'In the name of Allah (3 times), then: I seek refuge in Allah and His Power from the evil of what I find (pain) and what I fear.',
      translationUr:
      'بسم اللہ (3 مرتبہ)، پھر: میں اللہ اور اس کی قدرت کی پناہ مانگتا ہوں اس تکلیف کے شر سے جو مجھے ہو رہی ہے اور جس سے میں ڈرتا ہوں۔',
      translationPs:
      'د الله په نوم (۳ ځله)، بیا: زه د الله او د هغه د قدرت پناہ غواړم له هغه شر څخه چې زه یې احساسوم او وریږم.',
      instructionEn:
      'Place your right hand on the painful area. Say Bismillah 3 times, then recite this dua 7 times.',
      instructionUr:
      'دردناک جگہ پر سیدھا ہاتھ رکھیں۔ بسم اللہ 3 مرتبہ کہیں، پھر یہ دعا 7 مرتبہ پڑھیں۔',
      instructionPs:
      'خپل ښی لاس پر دردناک ځای کېږده. ۳ ځله بسم الله ووایه، بیا ۷ ځله دا دعا ولوله.',
      reference: 'Sahih Muslim: 5737',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p2',
      titleEn: 'Ruqyah for Wound or Boil',
      titleUr: 'زخم اور پھوڑے کا روحانی علاج',
      titlePs: 'د زخم یا پړسوب لپاره دعا',
      arabic:
      'بِسْمِ اللَّهِ تُرْبَةُ أَرْضِنَا بِرِيقَةِ بَعْضِنَا يُشْفَى سَقِيمُنَا بِإِذْنِ رَبِّنَا',
      translationEn:
      'In the name of Allah, with the soil of our land and the saliva of some of us, our sick one is healed by the permission of our Lord.',
      translationUr:
      'اللہ کے نام سے، ہماری زمین کی مٹی اور ہم میں سے کسی کے تھوک کے ساتھ، ہمارا بیمار ہمارے رب کے حکم سے شفاء پائے۔',
      translationPs:
      'د الله په نوم، زموږ د ځمکې په خاورو او زموږ د ځینو په تولو سره، زموږ ناروغ زموږ د رب په حکم روغ شي.',
      instructionEn:
      'Put index finger on ground (or clean soil), then apply lightly on the wound while reciting.',
      instructionUr:
      'شہادت کی انگلی زمین (یا پاک مٹی) پر رکھیں، پھر زخم پر ہلکا لگائیں اور پڑھیں۔',
      instructionPs:
      'شهادت ګوته پر ځمکه کښېږده، بیا د لوستلو په وخت کې په سپک ډول پر زخم ووهه.',
      reference: 'Sahih al-Bukhari: 5745',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'p3',
      titleEn: 'Dua for Fever and Illness',
      titleUr: ' بیماری کے لیے دعا',
      titlePs: ' بیمارئ لپاره دعا',
      arabic:
      'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ اشْفِ أَنْتَ الشَّافِي لَا شِفَاءَ إِلَّا شِفَاؤُكَ شِفَاءً لَا يُغَادِرُ سَقَمًا',
      translationEn:
      'O Allah, Lord of mankind, remove the suffering. Cure (him/her), for You are the Healer. There is no healing except Your healing, a healing that leaves no illness.',
      translationUr:
      'اے اللہ، لوگوں کے رب! تکلیف دور فرما۔ شفاء دے، کیونکہ تو ہی شفاء دینے والا ہے۔ تیری شفاء کے سوا کوئی شفاء نہیں، ایسی شفاء جو کوئی بیماری نہ چھوڑے۔',
      translationPs:
      'یا الله، د خلکو ربه! تکلیف لرې کړه. شفا راکړه، ځکه چې ته پخپله شفاه ورکوونکی یې. د ستا له شفاه پرته بله شفاه نشته، ایسی شفا چې هیڅ ناروغی ونه نیسي.',
      instructionEn:
      'Place right hand on the patient and recite while wiping over them.',
      instructionUr:
      'مریض پر سیدھا ہاتھ رکھیں اور پڑھتے ہوئے ہاتھ پھیریں۔',
      instructionPs:
      'پر ناروغ ښی لاس کېږده او په لوستلو سره لاس پرې ووهه.',
      reference: 'Sahih al-Bukhari: 5750',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'p4',
      titleEn: 'Jibreel\'s Ruqyah for Any Harm',
      titleUr: 'جبریل علیہ السلام کی رقیہ',
      titlePs: 'د جبرائیل علیه السلام دم د هر ضرر لپاره',
      arabic:
      'بِسْمِ اللَّهِ أَرْقِيكَ مِنْ كُلِّ شَيْءٍ يُؤْذِيكَ مِنْ شَرِّ كُلِّ نَفْسٍ أَوْ عَيْنٍ حَاسِدٍ اللَّهُ يَشْفِيكَ بِسْمِ اللَّهِ أَرْقِيكَ',
      translationEn:
      'In the name of Allah I perform ruqyah for you, from everything that harms you, from the evil of every soul or envious eye. May Allah heal you; in the name of Allah I perform ruqyah for you.',
      translationUr:
      'اللہ کے نام سے میں تجھے دم کرتا ہوں، ہر اس چیز سے جو تجھے تکلیف دیتی ہے، ہر نفس یا حاسد نظر کے شر سے۔ اللہ تجھے شفاء دے، اللہ کے نام سے میں تجھے دم کرتا ہوں۔',
      translationPs:
      'د الله په نوم زه پر تا دم کوم، له هر هغه شي څخه چې تا ته تکلیف درکوي، د هر نفس یا حسد کوونکې سترګې له شر څخه. الله دې تا روغ کړي؛ د الله په نوم پر تا دم کوم.',
      instructionEn:
      'Jibril (AS) recited this upon the Prophet ﷺ.',
      instructionUr:
      'جبریل علیہ السلام نے یہ نبی ﷺ پر پڑھی تھی۔۔',
      instructionPs:
      'جبرائیل علیه السلام دا پر نبی ﷺ لوستې وه. .',
      reference: 'Sunan at-Tirmidhi: 972',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'p5',
      titleEn: 'Dua for Headache or Any Localised Pain',
      titleUr: 'سر درد یا کسی مخصوص جگہ کے درد کے لیے',
      titlePs: 'د سر درد یا هر ځانګړي درد لپاره',
      arabic:
      'أَعُوذُ بِعِزَّةِ اللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
      translationEn:
      'I seek refuge in the might of Allah and His power from the evil of what I feel and what I fear.',
      translationUr:
      'میں اللہ کی عزت اور اس کی قدرت کی پناہ مانگتا ہوں ہر اس شر سے جو مجھے ہو رہا ہے اور جس سے میں ڈرتا ہوں۔',
      translationPs:
      'زه د الله په عزت او د هغه په قدرت پناہ غواړم له هغه شر څخه چې زه یې احساسوم او وریږم.',
      instructionEn: 'Place hand on the painful area and recite 7 times.',
      instructionUr: 'دردناک جگہ پر ہاتھ رکھ کر 7 مرتبہ پڑھیں۔',
      instructionPs: 'پر دردناک ځای لاس کېږده او ۷ ځله یې ولوله.',
      reference: 'Sahih Muslim: 2202',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p6',
      titleEn: 'Surah Al-Fatihah as Ruqyah',
      titleUr: 'سورۃ الفاتحہ بطور رقیہ',
      titlePs: 'سورۃ الفاتحہ د دم په توګه',
      arabic:
      'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
      translationEn:
      'All praise is for Allah, Lord of all worlds, the Most Gracious, the Most Merciful, Master of the Day of Judgement. You alone we worship and You alone we ask for help. Guide us to the straight path — the path of those You have blessed, not of those who have earned anger, nor of those who are astray.',
      translationUr:
      'تمام تعریفیں اللہ کے لیے ہیں جو تمام جہانوں کا رب ہے، بڑا مہربان، نہایت رحم والا، روزِ جزا کا مالک۔ ہم صرف تیری عبادت کرتے ہیں اور صرف تجھ سے مدد مانگتے ہیں۔ ہمیں سیدھی راہ دکھا، ان لوگوں کی راہ جن پر تو نے انعام فرمایا، نہ ان کی جن پر غضب ہوا اور نہ گمراہوں کی۔',
      translationPs:
      'ټولې ستاینې د الله لپاره دي چې د ټولو جهانونو رب دی، ډېر مهربان، ډېر رحم کوونکی، د جزا د ورځې مالک. موږ یوازې د تا عبادت کوو او یوازې له تا څخه مرسته غواړو. موږ سمې لارې ته هدایت وکړه — د هغو خلکو لاره چې ته پرې انعام کړی دی، نه د هغو چې غضب پرې شوی او نه د گمراهانو.',
      instructionEn:
      'A companion recited Surah Al-Fatihah on a scorpion-stung man and he was cured. Recite and blow on the patient or the painful area.',
      instructionUr:
      'ایک صحابی نے بچھو کے کاٹے ہوئے شخص پر سورۃ الفاتحہ پڑھی تو وہ ٹھیک ہو گیا۔ مریض یا دردناک جگہ پر پڑھ کر دم کریں۔',
      instructionPs:
      'یو صحابي د لړم په چیچلو شوي کس سورۃ الفاتحہ وویله او هغه روغ شو. د ناروغ یا دردناک ځای په سر یې ولوله او دم کړه.',
      reference: 'Sahih al-Bukhari: 5736, Sahih Muslim: 2201',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p8',
      titleEn: 'Surah Al-Ikhlas, Al-Falaq and An-Nas (Three Quls)',
      titleUr: 'تین قل (سورۃ اخلاص، فلق، ناس)',
      titlePs: 'درې قل (سورۃ اخلاص، فلق، ناس)',
      arabic:
      'قُلْ هُوَ اللَّهُ أَحَدٌ ۞ اللَّهُ الصَّمَدُ ۞ لَمْ يَلِدْ وَلَمْ يُولَدْ ۞ وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ\n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۞ مِنْ شَرِّ مَا خَلَقَ ۞ وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ ۞ وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۞ وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ\n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ ۞ مَلِكِ النَّاسِ ۞ إِلَهِ النَّاسِ ۞ مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۞ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۞ مِنَ الْجِنَّةِ وَالنَّاسِ',
      translationEn:
      'Say: He is Allah, the One. Allah, the Eternal Refuge. He neither begets nor is born, nor is there to Him any equivalent.\n\nSay: I seek refuge in the Lord of daybreak — from the evil of what He has created, from the evil of darkness when it settles, from the evil of those who blow on knots, from the evil of an envier when he envies.\n\nSay: I seek refuge in the Lord of mankind, the Sovereign of mankind, the God of mankind — from the evil of the retreating whisperer, who whispers into the chests of mankind — from among jinn and mankind.',
      translationUr:
      'کہو: وہ اللہ ایک ہے، اللہ بے نیاز ہے، نہ اس نے کسی کو جنا، نہ وہ جنا گیا، اور نہ اس کا کوئی ہمسر ہے۔\n\nکہو: میں صبح کے رب کی پناہ مانگتا ہوں، اس کی مخلوق کے شر سے، اندھیرے کے شر سے جب وہ چھا جائے، گانٹھوں میں پھونکنے والیوں کے شر سے، اور حسد کرنے والے کے شر سے جب وہ حسد کرے۔\n\nکہو: میں لوگوں کے رب کی پناہ مانگتا ہوں، لوگوں کے بادشاہ کی، لوگوں کے معبود کی — وسوسہ ڈالنے والے پیچھے ہٹنے والے کے شر سے، جو لوگوں کے سینوں میں وسوسہ ڈالتا ہے — جنوں میں سے اور انسانوں میں سے۔',
      translationPs:
      'وایه‌: هغه الله یو دی، الله بې نیازه دی، نه چا ته زېږیدلی او نه زېږیدلی دی، او هیڅوک د هغه سیال نشته.\n\nوایه‌: زه د سهار له ربه پناہ غواړم — د هغو شیانو له شره چې هغه پیدا کړي دي، د تیارې له شره کله چې خپره شي، په غوټو کې د پوکوونکو له شره، او د حسد کوونکي له شره کله چې حسد وکړي.\n\nوایه‌: زه د خلکو له ربه پناہ غواړم، د خلکو له پادشا، د خلکو له معبود — د وسوسه اچوونکي او شاته تلونکي له شره، چې د خلکو په سینو کې وسوسه اچوي — له پیریانو او انسانانو.',
      instructionEn:
      'The Prophet ﷺ would recite these three surahs, blow into his palms and wipe over his entire body during illness. Repeat 3 times each.',
      instructionUr:
      'نبی ﷺ بیماری میں یہ تینوں سورتیں پڑھ کر ہتھیلیوں پر دم کرتے اور پورے جسم پر پھیرتے تھے۔ ہر سورت 3 مرتبہ پڑھیں۔',
      instructionPs:
      'نبی ﷺ به د ناروغۍ پر مهال دا درې سورتونه لوستل، په خپلو لاسونو به یې پوک کاوه او په ټول بدن به یې راکاوه. هر یو ۳ ځله ولوله.',
      reference: 'Sahih al-Bukhari: 5748, Sahih Muslim: 2192',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'p9',
      titleEn: 'Dua for Fever (Cooling It)',
      titleUr: 'بخار ٹھنڈا کرنے کی دعا',
      titlePs: 'د تبې د سړولو دعا',
      arabic:
      'بِسْمِ اللَّهِ الْكَبِيرِ أَعُوذُ بِاللَّهِ الْعَظِيمِ مِنْ شَرِّ كُلِّ عِرْقٍ نَعَّارٍ وَمِنْ شَرِّ حَرِّ النَّارِ',
      translationEn:
      'In the name of Allah, the Great. I seek refuge in Allah, the Magnificent, from the evil of every pulsing vein and from the evil of the heat of the fire.',
      translationUr:
      'اللہ کے بڑے نام سے۔ میں اللہ عظیم کی پناہ مانگتا ہوں ہر دھڑکتی رگ کے شر سے اور آگ کی گرمی کے شر سے۔',
      translationPs: 'د الله په لوی نوم. زه د لوی الله پناہ غواړم د هرې تپېدونکې رګ له شر څخه او د اور د تودوخې له شر څخه.',
      instructionEn:
      'Place hand on the forehead or affected area and recite. The Prophet ﷺ instructed this for fever.',
      instructionUr:
      'ماتھے یا متاثرہ جگہ پر ہاتھ رکھ کر پڑھیں۔ نبی ﷺ نے بخار میں یہ پڑھنے کا حکم دیا۔',
      instructionPs: 'پر تېږي یا اغېزمن ځای لاس کېږده او دا دعا ولوله.',
      reference: 'Tirmidhi: 2075, graded Hasan by Tirmidhi',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p10',
      titleEn: 'Dua for the Sick Person (Said by Visitor)',
      titleUr: 'عیادت کرنے والا مریض کے لیے یہ کہے',
      titlePs: 'د ناروغ د پوښتنې دعا',
      arabic: 'لَا بَأْسَ طَهُورٌ إِنْ شَاءَ اللَّهُ',
      translationEn: 'Do not worry, it will be a purification, if Allah wills.',
      translationUr:
          'کوئی فکر نہ کرو، یہ (بیماری) پاکیزگی کا ذریعہ بنے گی، ان شاء اللہ۔',
      translationPs: 'هیڅ اندېښنه مه کوه، ان شاء الله دا به د پاکېدو سبب شي.',
      instructionEn:
          'Recite this when visiting a sick person. The Prophet ﷺ said this to those who were ill.',
      instructionUr:
          'بیمار کی عیادت کے وقت یہ کہیں۔ نبی ﷺ بیماروں سے یہ فرماتے تھے۔',
      instructionPs: 'کله چې د ناروغ پوښتنې ته ځې، دا ووایه.',
      reference: 'Sahih al-Bukhari: 3616, Abu Dawud: 3092',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'p11',
      titleEn: 'Wiping Dua (Recited by Oneself During Illness)',
      titleUr: 'خود بیماری میں پڑھنے کی دعا',
      titlePs: 'خپله په ناروغۍ کې د دعا لوستل',
      arabic: 'اللَّهُمَّ اشْفِنِي',
      translationEn: 'O Allah, cure me.',
      translationUr: 'اے اللہ! مجھے شفاء دے۔',
      translationPs: 'یا الله! ما ته شفا راکړه.',
      instructionEn:
          'Recite while wiping hands over the painful area of the body.',
      instructionUr: 'ہاتھوں کو جسم کے دردناک حصے پر پھیرتے ہوئے پڑھیں۔',
      instructionPs: 'لاونه د بدن پر دردناک ځای وموږه او دا ولوله.',
      reference: '',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p12',
      titleEn: 'Surah Al-Baqarah Last Two Verses for Protection',
      titleUr: 'سورۃ البقرہ کی آخری دو آیات',
      titlePs: 'سورۃ البقرۃ وروستۍ دوه آیاتونه',
      arabic:
          'آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ وَقَالُوا سَمِعْنَا وَأَطَعْنَا غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ ۞ لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنتَ مَوْلَانَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
      translationEn:
          'The Messenger has believed in what was revealed to him from his Lord, and so have the believers. All of them have believed in Allah, His angels, His books, and His messengers, (saying), "We make no distinction between any of His messengers." And they say, "We hear and we obey. (We seek) Your forgiveness, our Lord, and to You is the (final) destination." Allah does not burden a soul beyond what it can bear. It will have (the consequence of) what (good) it has gained, and it will bear (the consequence of) what (evil) it has earned. "Our Lord, do not impose blame upon us if we forget or make error. Our Lord, and lay not upon us a burden like that which You laid upon those before us. Our Lord, and burden us not with that which we have no ability to bear. And pardon us; and forgive us; and have mercy upon us. You are our protector, so give us victory over the disbelieving people."',
      translationUr:
          'رسول ایمان لائے اس پر جو ان کے رب کی طرف سے ان پر نازل ہوا اور مومن بھی۔ سب اللہ پر، اس کے فرشتوں پر، اس کی کتابوں پر اور اس کے رسولوں پر ایمان لائے۔ ہم اس کے رسولوں میں سے کسی میں فرق نہیں کرتے۔ اور انہوں نے کہا: ہم نے سنا اور مانا، اے ہمارے رب تیری بخشش ہو، اور تیری ہی طرف لوٹنا ہے۔ اللہ کسی نفس پر اس کی طاقت سے زیادہ بوجھ نہیں ڈالتا۔ اسے وہی ملے گا جو اس نے کمایا، اور اسی کے ذمے ہوگا جو اس نے کیا۔ اے ہمارے رب! اگر ہم بھول جائیں یا غلطی کریں تو ہم سے مواخذہ نہ کر۔ اے ہمارے رب! ہم پر وہ بوجھ نہ ڈال جو تو نے ہم سے پہلوں پر ڈالا تھا۔ اے ہمارے رب! ہم سے وہ بوجھ نہ اٹھوا جو ہم میں طاقت نہیں۔ اور ہمیں معاف کر، ہمیں بخش دے، ہم پر رحم فرما، تو ہی ہمارا مولا ہے، کافر قوم کے خلاف ہماری مدد فرما۔',
      translationPs:
          'رسول ایمان راوړی په هغه څه چې د هغه رب له لوري پرې نازل شوي دي او مومنانو هم. ټول په الله، د هغه په فرښتو، د هغه په کتابونو او د هغه په رسولانو ایمان راوړي دي. موږ د هغه په رسولانو کې هېڅ توپیر نه کوو. او دوی وویل: موږ واوریدل او اطاعت مو وکړ، ای زموږ ربه، ستا بخښنه غواړو او د تا په لور ورتګ دی. الله پر هېڅ نفس د هغه د وسې اندازه بوج نه اچوي...',
      instructionEn:
          'The Prophet ﷺ said: "Whoever recites the last two verses of Surah Al-Baqarah at night, they will suffice him." Recite before sleep or during illness for protection.',
      instructionUr:
          'نبی ﷺ نے فرمایا: جو شخص رات کو سورۃ البقرہ کی آخری دو آیات پڑھے وہ اسے کافی ہو جائیں گی۔ رات کو سونے سے پہلے یا بیماری میں پڑھیں۔',
      instructionPs: 'نبی ﷺ وویل: څوک چې د شپې د سورۃ البقرۃ وروستۍ دوه آیتونه ولولي، هغه ورته بس دي. د خوب پر مهال یا په ناروغۍ کې یې ولوله.',
      reference: 'Sahih al-Bukhari: 5009, Sahih Muslim: 808 (Quran 2:285-286)',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'p13',
      titleEn: 'Dua for the Sick (7-Times Dua)',
      titleUr: 'مریض کے لیے 7 مرتبہ کی دعا',
      titlePs: 'د ناروغ لپاره ۷ ځلي دعا',
      arabic:
          'أَسْأَلُ اللَّهَ الْعَظِيمَ رَبَّ الْعَرْشِ الْعَظِيمِ أَنْ يَشْفِيَكَ',
      translationEn:
          'I ask Allah, the Mighty, Lord of the Mighty Throne, to cure you.',
      translationUr:
          'میں اللہ عظیم سے، جو عرشِ عظیم کا رب ہے، درخواست کرتا ہوں کہ وہ تجھے شفاء دے۔',
      translationPs: 'زه له لوی الله څخه، چې د لوی عرش رب دی، غواړم چې تا ته شفا درکړي.',
      instructionEn:
          'The Prophet ﷺ said: whoever visits a sick person who is not at the point of death and recites this 7 times, Allah will cure him of that illness.',
      instructionUr:
          'نبی ﷺ نے فرمایا: جو کوئی کسی بیمار کی عیادت کرے جو موت کے قریب نہ ہو اور یہ 7 مرتبہ پڑھے، اللہ اسے اس بیماری سے شفاء دے گا۔',
      instructionPs: 'نبی ﷺ وویل: څوک چې د کوم ناروغ پوښتنې ته لاړ شي او دا ۷ ځله ولولي، الله به ورته شفا ورکړي.',
      reference: 'Abu Dawud: 3106',
      targetCount: 7,
    ),
    ShifaEntity(
      id: 'p14',
      titleEn: 'Dua for Healing and Pain Relief',
      titleUr: ' شفا اور جسمانی درد کی دعا',
      titlePs: 'د شفا او بدن د درد دعا',
      arabic:
          'أَذْهِبِ الْبَأْسَ رَبَّ النَّاسِ وَاشْفِ أَنْتَ الشَّافِي لَا شِفَاءَ إِلَّا شِفَاؤُكَ شِفَاءً لَا يُغَادِرُ سَقَمًا',
      translationEn:
          'Remove the suffering, O Lord of mankind, and heal; You are the Healer. There is no healing except Your healing, a healing that leaves no illness behind.',
      translationUr:
          'تکلیف دور فرما، اے لوگوں کے رب! اور شفاء دے، تو ہی شفاء دینے والا ہے، تیری شفاء کے سوا کوئی شفاء نہیں، ایسی شفاء جو کوئی بیماری نہ چھوڑے۔',
      translationPs: 'تکلیف لرې کړه، ای د خلکو ربه! او شفا راکړه، ته په خپله شفا ورکوونکی یې، د ستا له شفا پرته بله شفا نشته.',
      instructionEn:
          'Place your right hand on the painful area of the body, wipe it gently, and recite the dua.',
      instructionUr:
          'اپنا سیدھا (دایاں) ہاتھ جسم کے درد والے حصے پر پھیرتے ہوئے یہ دعا پڑھیں۔',
      instructionPs: 'خپل ښی لاس د بدن پر دردناک ځای کېږده او وموږه.',
      reference: 'Sahih al-Bukhari: 5743',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'p15',
      titleEn: 'Dua for Stomach Pain',
      titleUr: 'پیٹ کے درد کے لیے دعا',
      titlePs: 'د ګېډې د درد لپاره دعا',
      arabic:
          'ضَعْ يَدَكَ عَلَى الَّذِي تَأَلَّمَ مِنْ جَسَدِكَ وَقُلْ بِسْمِ اللَّهِ ثَلَاثاً وَقُلْ سَبْعَ مَرَّاتٍ أَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
      translationEn:
          'Place your hand on the area of your body that hurts and say Bismillah three times; then say seven times: I seek refuge in Allah and His Power from the evil of what I find and what I fear.',
      translationUr:
          'جسم کے جس حصے میں تکلیف ہو اس پر ہاتھ رکھیں اور بسم اللہ 3 مرتبہ کہیں، پھر 7 مرتبہ کہیں: میں اللہ اور اس کی قدرت کی پناہ مانگتا ہوں ہر اس تکلیف کے شر سے جو مجھے ہو رہی ہے اور جس سے میں ڈرتا ہوں۔',
      translationPs: 'د بدن په هغه ځای لاس کېږده چې درد کوي او ۳ ځله بسم الله ووايه، بیا ۷ ځله دا دعا ولوله.',
      instructionEn:
          'This is the complete Prophetic method for any bodily pain. Place right hand on the stomach or affected area.',
      instructionUr:
          'یہ کسی بھی جسمانی درد کا مکمل نبوی طریقہ ہے۔ پیٹ یا متاثرہ جگہ پر سیدھا ہاتھ رکھیں۔',
      instructionPs: 'دا د هر ډول جسماني درد لپاره نبوي لاره ده.',
      reference: 'Sahih Muslim: 2202',
      targetCount: 7,
    ),
  ];

  static List<ShifaEntity> evilEye = [
    ShifaEntity(
      id: 'e1',
      titleEn: 'Protection from Evil Eye',
      titleUr: 'نظرِ بد سے حفاظت',
      titlePs: 'د بد نظر او حسد څخه ساتنه',
      arabic:
          'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ وَمِنْ كُلِّ عَيْنٍ لَامَّةٍ',
      translationEn:
          'I seek refuge in the perfect words of Allah from every devil and poisonous creature, and from every evil eye.',
      translationUr:
          'میں اللہ کے کامل کلمات کی پناہ مانگتا ہوں ہر شیطان، زہریلے جانور اور ہر لگ جانے والی نظرِ بد سے۔',
      translationPs:
          'زه د الله د پوره کلماتو پناہ غواړم له هر شیطان، زهري څاروي او هرې بدې سترګې څخه.',
      instructionEn:
          'Recite for protection from evil eye and blow on the person.',
      instructionUr: 'نظرِ بد سے حفاظت کے لیے پڑھ کر شخص پر دم کریں۔',
      instructionPs: 'د بد نظر څخه د ساتنې لپاره یې ولوله او پر کس دم کړه.',
      reference: 'Sahih al-Bukhari 3371',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'e5',
      titleEn: 'Ayatul Kursi',
      titleUr: 'آیۃ الکرسی',
      titlePs: 'آیۃ الكرسی',
      arabic:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ... وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      translationEn:
          'Allah — there is no deity except Him, the Ever-Living, the Sustainer of all existence...',
      translationUr: 'اللہ — اس کے سوا کوئی معبود نہیں، وہ ہمیشہ زندہ ہے...',
      translationPs: 'الله — هغه ذات دی چې تر سربیره بل د عبادت وړ نشته، تل ژوندی او قائم پاتې کیدونکی دی...',
      instructionEn: 'Recite before sleeping for protection.',
      instructionUr: 'حفاظت کے لیے سونے سے پہلے پڑھیں۔',
      instructionPs: 'د ساتنې لپاره د خوب پر مهال ووايئ.',
      reference: 'Sahih al-Bukhari 2311',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'e7',
      titleEn: 'Seek Refuge from the Evil of Creation',
      titleUr: 'مخلوق کے شر سے پناہ',
      titlePs: 'د مخلوق له شره پناہ',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      translationEn:
          'I seek refuge in the perfect words of Allah from the evil of what He has created.',
      translationUr:
          'میں اللہ کے کامل کلمات کی پناہ مانگتا ہوں ہر اس چیز کے شر سے جو اس نے پیدا کی ہے۔',
      translationPs: 'زه د الله په پوره کلماتو پناہ غواړم له هغه شره چې هغه پیدا کړی دی.',
      instructionEn: 'Recite when arriving at a place.',
      instructionUr: 'کسی جگہ پہنچ کر پڑھیں۔',
      instructionPs: 'کله چې کوم ځای ته ورشئ، دا ولولئ.',
      reference: 'Sahih Muslim 2708',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'e8',
      titleEn: 'The Evil Eye is Real',
      titleUr: 'نظرِ بد حق ہے',
      titlePs: 'بد نظر او سترګې لګیدل حق دي',
      arabic: 'الْعَيْنُ حَقٌّ',
      translationEn: 'The evil eye is a fact.',
      translationUr: 'نظرِ بد حق ہے۔',
      translationPs: 'بد نظر او سترګې لګیدل حق دي.',
      instructionEn: 'A statement affirming the reality of evil eye.',
      instructionUr: 'نظرِ بد کی حقیقت کو ثابت کرنے والی حدیث۔',
      instructionPs: 'دا د بد نظر د حقیقت په اړه حدیث دی.',
      reference: 'Sahih al-Bukhari 5740',
      targetCount: 1,
    ),
  ];

  static List<ShifaEntity> sickness = [
    ShifaEntity(
      id: 's6',
      titleEn: 'Dua of Prophet Ayyub (AS) — For Long Illness',
      titleUr: 'حضرت ایوب علیہ السلام کی دعا — طویل بیماری کے لیے',
      titlePs: 'د حضرت ایوب علیه السلام دعا — د اوږدې ناروغۍ لپاره',
      arabic: 'أَنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ',
      translationEn:
          'Indeed, adversity has touched me, and You are the Most Merciful of the merciful.',
      translationUr:
          'بے شک مجھے تکلیف پہنچی ہے اور تو سب سے زیادہ رحم کرنے والا ہے۔',
      translationPs: 'بې شکه چې ماته تکلیف راپېښ شوی دی او ته د ټولو رحم کوونکو تر ټولو ډېر مهربان یې.',
      instructionEn:
          'The dua of Prophet Ayyub (AS) when he was ill for many years. Allah accepted it and restored his health. Recite with full trust in Allah.',
      instructionUr:
          'حضرت ایوب علیہ السلام کی دعا جو انہوں نے سالوں بیمار رہتے ہوئے کی۔ اللہ نے قبول فرمائی اور صحت عطا کی۔ پورے یقین سے پڑھیں۔',
      instructionPs: 'د حضرت ایوب علیه السلام دعا کله چې هغه کلونه ناروغ و. الله قبول کړه او روغتیا یې ورکړه. په پوره باور سره یې ولوله.',
      reference: 'Quran 21:83; Tafsir Ibn Kathir',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 's7',
      titleEn: 'Dua of Yunus (AS) — For Distress & Difficulty',
      titleUr: 'حضرت یونس علیہ السلام کی دعا — تنگی اور مصیبت کے لیے',
      titlePs: 'د حضرت یونس علیه السلام دعا — د سختۍ او مصیبت لپاره',
      arabic:
          'لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      translationEn:
          'There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.',
      translationUr:
          'تیرے سوا کوئی معبود نہیں، تو پاک ہے، بے شک میں ظالموں میں سے تھا۔',
      translationPs: 'د تا پرته بل د عبادت وړ نشته، ته پاک یې، بې شکه چې زه له ظالمانو څخه وم.',
      instructionEn:
          'The Prophet ﷺ said: No Muslim calls upon Allah with these words in any matter except that Allah will respond to him. Recite in any hardship or illness.',
      instructionUr:
          'نبی ﷺ نے فرمایا: جو مسلمان کسی بھی معاملے میں ان کلمات سے اللہ کو پکارے تو اللہ ضرور قبول فرماتا ہے۔ کسی بھی مشکل یا بیماری میں پڑھیں۔',
      instructionPs: 'نبی ﷺ وویل: کوم مسلمان چې په هره ستونزه کې په دې کلماتو دعا وکړي، الله به یې ومني.',
      reference: 'Quran 21:87; Jami at-Tirmidhi 3505 (Sahih)',
      targetCount: 40,
    ),
  ];

  static List<ShifaEntity> anxietyGrief = [
    ShifaEntity(
      id: 'a1',
      titleEn: 'Dua for Anxiety & Grief',
      titleUr: 'غم اور پریشانی کی دعا',
      titlePs: 'د غم او اندېښنې دعا',
      arabic:
          'اللَّهُمَّ إِنِّي عَبْدُكَ وَابْنُ عَبْدِكَ وَابْنُ أَمَتِكَ نَاصِيَتِي بِيَدِكَ مَاضٍ فِيَّ حُكْمُكَ عَدْلٌ فِيَّ قَضَاؤُكَ أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ سَمَّيْتَ بِهِ نَفْسَكَ أَوْ أَنْزَلْتَهُ فِي كِتَابِكَ أَوْ عَلَّمْتَهُ أَحَدًا مِنْ خَلْقِكَ أَوِ اسْتَأْثَرْتَ بِهِ فِي عِلْمِ الْغَيْبِ عِنْدَكَ أَنْ تَجْعَلَ الْقُرْآنَ رَبِيعَ قَلْبِي وَنُورَ صَدْرِي وَجَلَاءَ حُزْنِي وَذَهَابَ هَمِّي',
      translationEn:
          'O Allah, I am Your servant, son of Your servant, son of Your maidservant; my forelock is in Your hand, Your command over me is forever executed and Your decree over me is just. I ask You by every name belonging to You which You named Yourself with, or revealed in Your Book, or You taught to any of Your creation, or You have preserved in the knowledge of the Unseen with You, that You make the Quran the spring of my heart, the light of my chest, the banisher of my grief and the reliever of my anxiety.',
      translationUr:
          'اے اللہ! میں تیرا بندہ ہوں، تیرے بندے کا بیٹا، تیری بندی کا بیٹا۔ میری پیشانی تیرے ہاتھ میں ہے۔ تیرا حکم مجھ پر نافذ ہے اور تیرا فیصلہ مجھ پر عدل ہے۔ میں تجھ سے سوال کرتا ہوں ہر اس نام کے ذریعے جو تیرا ہے... کہ تو قرآن کو میرے دل کی بہار، میرے سینے کا نور، میرے غم کا ازالہ اور میری پریشانی کو دور کرنے والا بنا دے۔',
      translationPs:
          'یا الله! زه د تا بنده یم، د تا د بنده زوی، د تا د کنیز زوی. زما تندی د تا په لاس کې دی، پر ما باندې د تا حکم جاری دی او پر ما باندې د تا پرېکړه عدل ده. زه له تا څخه د هر هغه نوم په واسطه پوښتم چې د تا دی... چې قرآن زما د زړه بهار، زما د سینې نور، د زما د غم لرې کوونکی او د اندېښنې ختموونکی وګرځوې.',
      instructionEn:
          'The Prophet ﷺ said: Allah will take away his grief and replace it with joy. When a person recites this dua with full heart.',
      instructionUr:
          'نبی ﷺ نے فرمایا: اللہ اس کا غم دور کرے گا اور اس کی جگہ خوشی دے گا۔ جب بندہ یہ دعا پوری طرح پڑھے۔',
      instructionPs: 'نبی ﷺ وویل: الله به د هغه غم لرې کړي او په خوشحاله به یې بدل کړي، کله چې یو څوک دا دعا په زړه سره ولولي.',
      reference: 'Musnad Ahmad 3712 (Sahih by al-Albani)',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'a2',
      titleEn: 'Dua for Ease in Difficulty',
      titleUr: 'مشکل میں آسانی کی دعا',
      titlePs: 'په مشکل کې د اسانتیا دعا',
      arabic:
          'اللَّهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا',
      translationEn:
          'O Allah, nothing is easy except what You make easy, and You make the difficult easy if You wish.',
      translationUr:
          'اے اللہ! کوئی چیز آسان نہیں مگر جسے تو آسان کرے، اور تو چاہے تو مشکل کو بھی آسان کر دیتا ہے۔',
      translationPs: 'یا الله! هیڅ شی اسانه نه دی مګر هغه چې ته یې اسانه کړې، او ته غواړې نو مشکل اسانه کوې.',
      instructionEn: 'Recite in any difficulty or hardship.',
      instructionUr: 'کسی بھی تنگی یا مشکل میں پڑھیں۔',
      instructionPs: 'په هر ډول سختی یا مشکل کې یې ولوله.',
      reference: ' Sahih Ibn Hibban 974 (Sahih)',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'a3',
      titleEn: 'Dua for Removing Grief',
      titleUr: 'غم دور کرنے کی دعا',
      titlePs: 'د غم او اندېښنې د لرې کولو دعا',
      arabic:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ وَالْعَجْزِ وَالْكَسَلِ وَالْبُخْلِ وَالْجُبْنِ وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      translationEn:
          'O Allah, I seek refuge with You from worry and grief, from incapacity and laziness, from miserliness and cowardice, from being heavily in debt and from being overpowered by men.',
      translationUr:
          'اے اللہ! میں تیری پناہ مانگتا ہوں فکر و غم سے، عاجزی اور سستی سے، بخل اور بزدلی سے، قرض کے بوجھ سے اور لوگوں کے غلبے سے۔',
      translationPs: 'یا الله! زه د اندېښنې، غم، سستۍ، بخل، بزدلۍ، د پور له بار او د خلکو له غلبې څخه په تا پناہ غواړم.',
      instructionEn:
          'The Prophet ﷺ used to say this dua regularly. Recite morning and evening.',
      instructionUr: 'نبی ﷺ یہ دعا کثرت سے پڑھتے تھے۔ صبح و شام پڑھیں۔',
      instructionPs: 'نبی ﷺ دا دعا سهار او ماښام لوستله.',
      reference: 'Sahih Bukhari 6369; Sahih Muslim 2706',
      targetCount: 1,
    ),
    ShifaEntity(
      id: 'a4',
      titleEn: 'Dua in Times of Extreme Distress',
      titleUr: 'شدید پریشانی کی دعا',
      titlePs: 'د سختې پرېشانۍ پر مهال دعا',
      arabic:
          'لَا إِلَٰهَ إِلَّا اللَّهُ الْعَظِيمُ الْحَلِيمُ لَا إِلَٰهَ إِلَّا اللَّهُ رَبُّ الْعَرْشِ الْعَظِيمِ لَا إِلَٰهَ إِلَّا اللَّهُ رَبُّ السَّمَاوَاتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيمِ',
      translationEn:
          'There is no deity except Allah, the Magnificent, the Forbearing. There is no deity except Allah, Lord of the Magnificent Throne. There is no deity except Allah, Lord of the heavens and Lord of the earth and Lord of the Noble Throne.',
      translationUr:
          'اللہ کے سوا کوئی معبود نہیں، وہ عظیم، بردبار ہے۔ اللہ کے سوا کوئی معبود نہیں، عرش عظیم کا رب۔ اللہ کے سوا کوئی معبود نہیں، آسمانوں کا رب، زمین کا رب اور کریم عرش کا رب۔',
      translationPs: 'د الله پرته بل د عبادت وړ نشته، چې لوی او بردبار دی. د عرش عظیم رب دی...',
      instructionEn:
          'The Prophet ﷺ used to say this when he was in distress. It is one of the most powerful duas for calamity.',
      instructionUr:
          'نبی ﷺ جب پریشانی میں ہوتے تو یہ پڑھتے تھے۔ یہ مصیبت میں سب سے طاقتور دعاؤں میں سے ہے۔',
      instructionPs: 'نبی ﷺ به دا دعا د مصیبت پر مهال لوستله.',
      reference: 'Sahih Bukhari 6346',
      targetCount: 3,
    ),
    ShifaEntity(
      id: 'a5',
      titleEn: 'Dua: Hasbunallah wa Ni\'mal Wakeel',
      titleUr: 'حسبنا اللہ — اللہ ہمیں کافی ہے',
      titlePs: 'حسبنا الله — الله مونږ ته بس دی',
      arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      translationEn:
          'Allah is sufficient for us, and He is the best Disposer of affairs.',
      translationUr: 'ہمیں اللہ کافی ہے اور وہ بہترین کارساز ہے۔',
      translationPs: 'الله مونږ ته بس دی او هغه تر ټولو ښه کارساز دی.',
      instructionEn:
          'Ibrahim (AS) said this when thrown into fire; the Prophet ﷺ and companions said it in fear. Recite in any fear or overwhelming situation.',
      instructionUr:
          'ابراہیم علیہ السلام نے آگ میں ڈالے جاتے وقت یہ کہا، نبی ﷺ اور صحابہ نے خوف میں یہ کہا۔ کسی بھی خوف یا بھاری صورتحال میں پڑھیں۔',
      instructionPs: 'حضرت ابراهیم (ع) په اور کې د اچولو پر مهال دا وویل. په هر ډار یا ستونزه کې یې ولوله.',
      reference: 'Sahih Bukhari 4563; Quran 3:173',
      targetCount: 100,
    ),
  ];

  static List<ShifaCategory> categories = [
    ShifaCategory(
      id: 'pain',
      titleEn: 'Physical Pain',
      titleUr: 'جسمانی درد',
      titlePs: 'جسماني دردونه',
      duas: physicalPain,
    ),
    ShifaCategory(
      id: 'eye',
      titleEn: 'Evil Eye & Magic',
      titleUr: 'نظرِ بد اور جادو',
      titlePs: 'بد نظر او جادو',
      duas: evilEye,
    ),
    ShifaCategory(
      id: 'sick',
      titleEn: 'Sickness & Healing',
      titleUr: 'بیماری اور شفا',
      titlePs: 'ناروغي او شفا',
      duas: sickness,
    ),
    ShifaCategory(
      id: 'anxiety',
      titleEn: 'Anxiety & Grief',
      titleUr: 'غم اور پریشانی',
      titlePs: 'غم او اندېښنه',
      duas: anxietyGrief,
    ),
  ];

  static List<ShifaEntity> get allDuas => [
    ...physicalPain,
    ...evilEye,
    ...sickness,
    ...anxietyGrief,
  ];
}
