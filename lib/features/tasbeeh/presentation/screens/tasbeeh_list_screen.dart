import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tasbeeh_screen.dart';

class TasbeehListScreen extends ConsumerWidget {
  const TasbeehListScreen({super.key});

  final List<Map<String, String>> tasbeehList = const [
    {
      'id': 't1',
      'titleAr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      'meaningEn': 'Glory be to Allah and all praise is due to Him.',
      'meaningUr': 'اللہ پاک ہے اور اسی کی تعریف ہے۔',
      'fazilatEn':
          'Sins are forgiven even if they are like the foam of the sea.',
      'fazilatUr': 'گناہ معاف کر دیے جاتے ہیں چاہے سمندر کی جھاگ کے برابر ہوں۔',
      'reference': 'Sahih al-Bukhari 6405',
    },
    {
      'id': 't2',
      'titleAr': 'سُبْحَانَ اللَّهِ الْعَظِيمِ وَبِحَمْدِهِ',
      'meaningEn': 'Glory be to Allah the Magnificent, and praise be to Him.',
      'meaningUr': 'اللہ عظیم پاک ہے اور اسی کی حمد ہے۔',
      'fazilatEn': 'A palm tree is planted for you in Paradise.',
      'fazilatUr': 'آپ کے لیے جنت میں کھجور کا ایک درخت لگایا جاتا ہے۔',
      'reference': 'Jami at-Tirmidhi 3465',
    },
    {
      'id': 't3',
      'titleAr':
          'لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى کُلِّ شَيْءٍ قَدِيرٌ',
      'meaningEn':
          'None has the right to be worshipped but Allah alone, Who has no partner. His is the dominion, His is all praise, and He is capable of all things.',
      'meaningUr':
          'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہت ہے، اسی کی تعریف ہے اور وہ ہر چیز پر قادر ہے۔',
      'fazilatEn':
          'Reward of freeing 10 slaves, 100 good deeds written, 100 sins erased, and protection from Shaytan all day.',
      'fazilatUr':
          '10 غلاموں کو آزاد کرنے کا ثواب، 100 نیکیاں لکھی جاتی ہیں، 100 گناہ مٹائے جاتے ہیں اور دن بھر شیطان سے حفاظت۔',
      'reference': 'Sahih al-Bukhari 3293',
    },
    {
      'id': 't4',
      'titleAr': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
      'meaningEn': 'There is no power and no strength except with Allah.',
      'meaningUr':
          'نیکی کرنے کی طاقت اور برائی سے بچنے کی ہمت صرف اللہ کی طرف سے ہے۔',
      'fazilatEn': 'A treasure from the treasures of Paradise.',
      'fazilatUr': 'جنت کے خزانوں میں سے ایک خزانہ ہے۔',
      'reference': 'Sahih al-Bukhari 6384',
    },
    {
      'id': 't5',
      'titleAr': 'أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ',
      'meaningEn': 'I seek Allah\'s forgiveness and turn to Him in repentance.',
      'meaningUr': 'میں اللہ سے بخشش مانگتا ہوں اور اس کی طرف توبہ کرتا ہوں۔',
      'fazilatEn': 'The Prophet (ﷺ) used to say this more than 70 times a day.',
      'fazilatUr': 'نبی کریم ﷺ دن میں 70 سے زیادہ مرتبہ یہ پڑھتے تھے۔',
      'reference': 'Sahih al-Bukhari 6307',
    },
    {
      'id': 't6',
      'titleAr': 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
      'meaningEn':
          'O Allah, send blessings upon Muhammad and upon the family of Muhammad.',
      'meaningUr': 'اے اللہ! محمد ﷺ اور ان کی آل پر اپنی رحمتیں نازل فرما۔',
      'fazilatEn':
          'Whoever sends one blessing upon the Prophet, Allah sends ten blessings upon him.',
      'fazilatUr':
          'جو ایک بار درود بھیجے، اللہ اس پر دس رحمتیں نازل فرماتا ہے۔',
      'reference': 'Sahih Muslim 408',
    },

    // ─── NEW ADDITIONS ───────────────────────────────────────────
    {
      "id": "t7",
      "titleAr": "سُبْحَانَ اللَّهِ",
      "meaningEn": "Glory be to Allah.",
      "meaningUr": "اللہ پاک ہے۔",
      "fazilatEn":
          "Among the most beloved words to Allah. Combined with Alhamdulillah, it fills what is between the heavens and the earth.",
      "fazilatUr":
          "اللہ کے پسندیدہ ترین کلمات میں سے ہے۔ الحمدللہ کے ساتھ مل کر آسمان اور زمین کے درمیان کے خلا کو بھر دیتا ہے۔",
      "reference": "Sahih Muslim  2137",
    },
    {
      "id": "t8",
      "titleAr": "الْحَمْدُ لِلَّهِ",
      "meaningEn": "All praise is due to Allah.",
      "meaningUr": "تمام تعریفیں اللہ کے لیے ہیں۔",
      "fazilatEn": "Fills the scale of good deeds on the Day of Judgement.",
      "fazilatUr": "قیامت کے دن نیکیوں کے میزان (ترازو) کو بھر دیتا ہے۔",
      "reference": "Sahih Muslim 2137",
    },
    {
      "id": "t9",
      "titleAr": "اللَّهُ أَكْبَرُ",
      "meaningEn": "Allah is the Greatest.",
      "meaningUr": "اللہ سب سے بڑا ہے۔",
      "fazilatEn": "Among the four most beloved statements to Allah.",
      "fazilatUr": "اللہ کے ہاں چار سب سے پسندیدہ کلمات میں سے ایک ہے۔",
      "reference": "Sahih Muslim 2137",
    },
    {
      "id": "t10",
      "titleAr": "لَا إِلَهَ إِلَّا اللَّهُ",
      "meaningEn": "There is no god worthy of worship except Allah.",
      "meaningUr": "اللہ کے سوا کوئی معبود نہیں۔",
      "fazilatEn": "The best form of remembrance (Dhikr).",
      "fazilatUr": "سب سے افضل ذکر ہے۔",
      "reference": "2137",
    },

    {
      'id': 't11',
      'titleAr':
          'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ کَلِمَاتِهِ',
      'meaningEn':
          'Glory and praise be to Allah, as many times as the number of His creation, to the extent of His pleasure, to the weight of His Throne, and the ink of His words.',
      'meaningUr':
          'اللہ پاک ہے اور اسی کی تعریف ہے، اس کی مخلوق کی تعداد کے برابر، اس کی رضا کے برابر، اس کے عرش کے وزن کے برابر اور اس کے کلمات کی روشنائی کے برابر۔',
      'fazilatEn':
          'Three times in the morning outweighs all other dhikr said that day.',
      'fazilatUr': 'صبح تین بار پڑھنا اس دن کے تمام ذکر سے بھاری ہے۔',
      'reference': 'Sahih Muslim 2726',
    },
    {
      'id': 't12',
      'titleAr':
          'سُبْحَانَ اللهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلَهَ إِلَّا اللهُ وَاللهُ أَكْبَرُ',
      'meaningEn':
          'Glory be to Allah, all praise is for Allah, there is no god but Allah, and Allah is the Greatest.',
      'meaningUr':
          'اللہ پاک ہے، تعریف اللہ کے لیے ہے، اللہ کے سوا کوئی معبود نہیں اور اللہ سب سے بڑا ہے۔',
      'fazilatEn':
          'More beloved to the Prophet (ﷺ) than all that the sun rises upon.',
      'fazilatUr': 'نبی کریم ﷺ کو اس دنیا و مافیہا سے زیادہ محبوب ہے۔',
      'reference': 'Sahih Muslim 2695',
    },
    {
      'id': 't13',
      'titleAr':
          'أَسْتَغْفِرُ اللهَ الْعَظِيمَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
      'meaningEn':
          'I seek forgiveness from Allah the Magnificent, besides Whom there is no god, the Ever-Living, the Sustainer of all, and I repent to Him.',
      'meaningUr':
          'میں اللہ عظیم سے بخشش مانگتا ہوں جس کے سوا کوئی معبود نہیں، جو ہمیشہ زندہ اور قائم رکھنے والا ہے، اور میں اس کی طرف توبہ کرتا ہوں۔',
      'fazilatEn':
          'Allah forgives the one who recites this, even if he has fled from battle.',
      'fazilatUr':
          'اللہ اسے معاف فرما دیتا ہے، چاہے وہ میدان جنگ سے بھاگا ہوا ہو۔',
      'reference': 'Jami at-Tirmidhi 3577',
    },
    {
      'id': 't14',
      'titleAr':
          'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ، إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
      'meaningEn':
          'O my Lord, forgive me and accept my repentance. Verily You are the Accepter of repentance, the Most Merciful.',
      'meaningUr':
          'اے میرے رب! مجھے بخش دے اور میری توبہ قبول فرما۔ بے شک تو بہت توبہ قبول کرنے والا، بہت مہربان ہے۔',
      'fazilatEn':
          'The Prophet (ﷺ) used to repeat this 100 times in a single gathering.',
      'fazilatUr': 'نبی کریم ﷺ ایک مجلس میں یہ 100 مرتبہ پڑھا کرتے تھے۔',
      'reference': 'Sunan Ibn Majah 3814 (Sahih)',
    },
    {
      'id': 't15',
      'titleAr':
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ مِنَ النَّارِ',
      'meaningEn':
          'O Allah, I ask You for Paradise and I seek refuge with You from the Fire.',
      'meaningUr':
          'اے اللہ! میں تجھ سے جنت مانگتا ہوں اور جہنم سے تیری پناہ چاہتا ہوں۔',
      'fazilatEn':
          'Paradise itself pleads to Allah on behalf of the one who says this.',
      'fazilatUr': 'جنت خود اللہ سے اس شخص کی سفارش کرتی ہے جو یہ پڑھے۔',
      'reference': 'Sunan Abu Dawud 792 (Sahih)',
    },
    {
      'id': 't16',
      'titleAr':
          'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      'meaningEn':
          'O Allah, You are my Lord, there is no god but You. You created me and I am Your servant, and I am on Your covenant and promise as much as I can. I seek refuge in You from the evil of what I have done. I acknowledge Your favor upon me, and I acknowledge my sin, so forgive me, for there is none who forgives sins except You.',
      'meaningUr':
          'اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔ تو نے مجھے پیدا کیا اور میں تیرا بندہ ہوں، اور میں اپنی استطاعت کے مطابق تیرے عہد اور تیرے وعدے پر قائم ہوں۔ میں اپنے کیے ہوئے برے کاموں کے شر سے تیری پناہ مانگتا ہوں۔ میں اپنے اوپر تیری نعمتوں کا اقرار کرتا ہوں اور اپنے گناہوں کا اعتراف کرتا ہوں، پس تو مجھے معاف کر دے، کیونکہ تیرے سوا کوئی گناہوں کو معاف نہیں کر سکتا۔',
      'fazilatEn':
          'Whoever recites it during the day with firm faith in it and dies on the same day before the evening, he will be from the people of Paradise.',
      'fazilatUr':
          'جو شخص اسے دن کے وقت پختہ ایمان کے ساتھ پڑھے اور شام ہونے سے پہلے اسی دن مر جائے، وہ جنتیوں میں سے ہے۔',
      'reference': 'Sahih al-Bukhari 6306',
    },

    {
      'id': 't17',
      'titleAr':
          'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَکَ إِنِّي کُنْتُ مِنَ الظَّالِمِينَ',
      'meaningEn':
          'There is no god but You, glory be to You, indeed I have been of the wrongdoers.',
      'meaningUr':
          'تیرے سوا کوئی معبود نہیں، تو پاک ہے، بے شک میں ظالموں میں سے تھا۔',
      'fazilatEn':
          'The dua of Prophet Yunus (AS) in the belly of the whale. No Muslim calls upon Allah with this except that Allah responds to him.',
      'fazilatUr':
          'یہ حضرت یونس ؑ کی مچھلی کے پیٹ میں دعا ہے۔ کوئی مسلمان اس سے دعا نہیں کرتا مگر اللہ اسے قبول فرماتا ہے۔',
      'reference': 'Jami at-Tirmidhi 3505 (Sahih)',
    },
    {
      'id': 't18',
      'titleAr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
      'meaningEn':
          'Glory be to Allah and His is the praise, glory be to Allah the Magnificent.',
      'meaningUr': 'اللہ پاک ہے اور اسی کی تعریف ہے، اللہ عظیم پاک ہے۔',
      'fazilatEn':
          'Two phrases light on the tongue, heavy on the scales, and beloved to the Most Merciful.',
      'fazilatUr':
          'زبان پر ہلکے، میزان میں بھاری اور رحمٰن کو بہت پیارے دو کلمے ہیں۔',
      'reference': 'Sahih al-Bukhari 6682',
    },

    {
      'id': 't19',
      'titleAr':
          'اللَّهُمَّ إِنِّي أَعُوذُ بِرِضَاکَ مِنْ سَخَطِکَ، وَبِمُعَافَاتِکَ مِنْ عُقُوبَتِکَ',
      'meaningEn':
          'O Allah, I seek refuge in Your pleasure from Your anger, and in Your pardon from Your punishment.',
      'meaningUr':
          'اے اللہ! میں تیری ناراضگی سے تیری خوشنودی کی پناہ مانگتا ہوں اور تیری سزا سے تیری معافی کی پناہ مانگتا ہوں۔',
      'fazilatEn':
          'The Prophet (ﷺ) used to seek protection through Allah\'s own attributes in this supplication.',
      'fazilatUr':
          'نبی کریم ﷺ اس دعا میں اللہ کی صفات کے ذریعے پناہ مانگتے تھے۔',
      'reference': 'Sahih Muslim 486',
    },
    {
      'id': 't20',
      'titleAr': 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِکَ أَسْتَغِيثُ',
      'meaningEn':
          'O Ever-Living, O Sustainer of all, in Your mercy I seek relief.',
      'meaningUr':
          'اے ہمیشہ زندہ! اے قائم رکھنے والے! میں تیری رحمت کے ذریعے فریاد کرتا ہوں۔',
      'fazilatEn':
          'The Prophet (ﷺ) instructed us to recite this abundantly and make it our constant dhikr.',
      'fazilatUr':
          'نبی کریم ﷺ نے اسے کثرت سے پڑھنے اور اپنا مستقل ذکر بنانے کی تلقین فرمائی۔',
      'reference': 'Mustadrak al-Hakim 1/545 (Sahih)',
    },
    {
      'id': 't21',
      'titleAr': 'اللَّهُمَّ إِنَّکَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي',
      'meaningEn':
          'O Allah, You are Pardoning, You love to pardon, so pardon me.',
      'meaningUr':
          'اے اللہ! تو بہت معاف کرنے والا ہے، تو معافی کو پسند کرتا ہے، پس مجھے معاف فرما دے۔',
      'fazilatEn':
          'The Prophet (ﷺ) taught this specifically as the best supplication for Laylat al-Qadr, and it is excellent at all times.',
      'fazilatUr':
          'نبی کریم ﷺ نے اسے شب قدر کے لیے خاص طور پر سکھایا، لیکن یہ ہر وقت پڑھنا بہترین ہے۔',
      'reference': 'Jami at-Tirmidhi 3513 (Sahih)',
    },
    {
      "id": "t22",
      "titleAr":
          "اللَّهُمَّ لَکَ الْحَمْدُ کُلُّهُ، وَلَکَ الْمُلْکُ کُلُّهُ، وَبِيَدِکَ الْخَيْرُ کُلُّهُ، وَإِلَيْکَ يُرْجَعُ الْأَمْرُ کُلُّهُ",
      "meaningEn":
          "O Allah, all praise is for You, all dominion is Yours, all good is in Your hands, and all matters return to You.",
      "meaningUr":
          "اے اللہ! تمام تعریف تیرے لیے ہے، تمام بادشاہت تیری ہے، تمام بھلائی تیرے ہاتھ میں ہے اور تمام معاملات تیری طرف لوٹتے ہیں۔",
      "fazilatEn":
          "A majestic praise taught by an angel to Hudhayfah (R.A) during prayer, which the Prophet (ﷺ) later approved and authenticated.",
      "fazilatUr":
          "ایک عظیم الشان حمد جو دورانِ نماز ایک فرشتے نے حضرت حذیفہؓ کو سکھائی، اور بعد میں نبی کریم ﷺ نے اس کی تصدیق اور تائید فرمائی۔",
      "reference": "Musnad Ahmad 23355, Shu'ab al-Iman (Al-Bayhaqi)",
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Tasbeeh"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasbeehList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = tasbeehList[index];
          return Card(
            elevation: 0,
            color: isDark ? AppColors.surfaceDark : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                hapticFeedBack();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TasbeehScreen(
                      dhikrId: item['id']!,
                      dhikrTitle: item['titleAr']!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: isUrdu
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        item['titleAr']!,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          color: AppColors.primaryTeal,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      isUrdu ? item['meaningUr']! : item['meaningEn']!,
                      style: isUrdu
                          ? const TextStyle(
                              fontFamily: 'NotoNastaliqUrdu',
                              fontSize: 14,
                              height: 1.8,
                            )
                          : const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      isUrdu ? item['fazilatUr']! : item['fazilatEn']!,
                      style: isUrdu
                          ? const TextStyle(
                              fontFamily: 'NotoNastaliqUrdu',
                              fontSize: 13,
                              color: Color(0xFF616161), // grey[700]
                            )
                          : const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      item['reference']!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
