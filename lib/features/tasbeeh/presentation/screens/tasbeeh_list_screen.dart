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
      'meaningPs': 'د الله پاک ذات پاک دی او ټولې ستاینې د هغې لپاره دي.',
      'fazilatEn':
          'Sins are forgiven even if they are like the foam of the sea.',
      'fazilatUr': 'گناہ معاف کر دیے جاتے ہیں چاہے سمندر کی جھاگ کے برابر ہوں۔',
      'fazilatPs': 'ګناهونه بخښل کیږي اګر که د سمندر د ځګ په اندازه هم وي.',
    },
    {
      'id': 't2',
      'titleAr': 'سُبْحَانَ اللَّهِ الْعَظِيمِ وَبِحَمْدِهِ',
      'meaningEn': 'Glory be to Allah the Magnificent, and praise be to Him.',
      'meaningUr': 'اللہ عظیم پاک ہے اور اسی کی حمد ہے۔',
      'meaningPs': 'ستر الله پاک دی او ټولې ستاینې د هغې لپاره دي.',
      'fazilatEn': 'A palm tree is planted for you in Paradise.',
      'fazilatUr': 'آپ کے لیے جنت میں کھجور کا ایک درخت لگایا جاتا ہے۔',
      'fazilatPs': 'د جنت په باغونو کې ستاسو لپاره د کجورې یو ونې کرل کیږي.',
    },
    {
      'id': 't3',
      'titleAr':
          'لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى کُلِّ شَيْءٍ قَدِيرٌ',
      'meaningEn':
          'None has the right to be worshipped but Allah alone, Who has no partner. His is the dominion, His is all praise, and He is capable of all things.',
      'meaningUr':
          'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہت ہے، اسی کی تعریف ہے اور وہ ہر چیز پر قادر ہے۔',
      'meaningPs':
          'د الله پرته بل د عبادت وړ نشته، هغه یوازې دی، شریک نه لري، پاچاهي د هغه ده، ستاینه د هغه ده او هغه پر هر شي قادر دی.',
      'fazilatEn':
          'Reward of freeing 10 slaves, 100 good deeds written, 100 sins erased, and protection from Shaytan all day.',
      'fazilatUr':
          '10 غلاموں کو آزاد کرنے کا ثواب، 100 نیکیاں لکھی جاتی ہیں، 100 گناہ مٹائے جاتے ہیں اور دن بھر شیطان سے حفاظت۔',
      'fazilatPs':
          'د ۱۰ غلامانو د ازادولو ثواب، ۱۰۰ نیکیانې لیکل کیږي، ۱۰۰ ګناهونه له منځه ځي او د ورځې تر پایه د شیطان څخه ساتنه کیږي.',
    },
    {
      'id': 't4',
      'titleAr': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
      'meaningEn': 'There is no power and no strength except with Allah.',
      'meaningUr':
          'نیکی کرنے کی طاقت اور برائی سے بچنے کی ہمت صرف اللہ کی طرف سے ہے۔',
      'meaningPs':
          'د الله تعالی پرته د نیکی کولو او له بدۍ څخه د ځان ساتلو هېڅ ځواک نشته.',
      'fazilatEn': 'A treasure from the treasures of Paradise.',
      'fazilatUr': 'جنت کے خزانوں میں سے ایک خزانہ ہے۔',
      'fazilatPs': 'دا د جنت له خزانو څخه یوه خزانه ده.',
    },
    {
      'id': 't5',
      'titleAr': 'أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ',
      'meaningEn': 'I seek Allah\'s forgiveness and turn to Him in repentance.',
      'meaningUr': 'میں اللہ سے بخشش مانگتا ہوں اور اس کی طرف توبہ کرتا ہوں۔',
      'meaningPs': 'زه له الله څخه بخښنه غواړم او د هغه په لور توبه وباسم.',
      'fazilatEn': 'The Prophet (ﷺ) used to say this more than 70 times a day.',
      'fazilatUr': 'نبی کریم ﷺ دن میں 70 سے زیادہ مرتبہ یہ پڑھتے تھے۔',
      'fazilatPs': 'نبی کریم ﷺ به هره ورځ له ۷۰ څخه زیات ځل دا ویل.',
    },
    {
      'id': 't6',
      'titleAr': 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
      'meaningEn':
          'O Allah, send blessings upon Muhammad and upon the family of Muhammad.',
      'meaningUr': 'اے اللہ! محمد ﷺ اور ان کی آل پر اپنی رحمتیں نازل فرما۔',
      'meaningPs': 'یا الله! پر حضرت محمد ﷺ او د محمد پر کورنۍ خپل درود او برکتونه نازل کړې.',
      'fazilatEn':
          'Whoever sends one blessing upon the Prophet, Allah sends ten blessings upon him.',
      'fazilatUr':
          'جو ایک بار درود بھیجے، اللہ اس پر دس رحمتیں نازل فرماتا ہے۔',
      'fazilatPs': 'څوک چې یو ځل درود ووايي، الله پر هغه لس رحمتونه نازلوي.',
    },
    {
      "id": "t7",
      "titleAr": "سُبْحَانَ اللَّهِ",
      "meaningEn": "Glory be to Allah.",
      "meaningUr": "اللہ پاک ہے۔",
      "meaningPs": "الله پاک دی.",
      'fazilatEn':
          'Among the most beloved words to Allah. Combined with Alhamdulillah, it fills what is between the heavens and the earth.',
      'fazilatUr':
          'اللہ کے پسندیدہ ترین کلمات میں سے ہے۔ الحمدللہ کے ساتھ مل کر آسمان اور زمین کے درمیان کے خلا کو بھر دیتا ہے۔',
      'fazilatPs': 'د الله په نزد تر ټولو خوښ کلمات دي.',
    },
    {
      "id": "t8",
      "titleAr": "الْحَمْدُ لِلَّهِ",
      "meaningEn": "All praise is due to Allah.",
      "meaningUr": "تمام تعریفیں اللہ کے لیے ہیں۔",
      "meaningPs": "ټولې ستاینې د الله لپاره دي.",
      'fazilatEn': 'Fills the scale of good deeds on the Day of Judgement.',
      'fazilatUr': 'قیامت کے دن نیکیوں کے میزان (ترازو) کو بھر دیتا ہے۔',
      'fazilatPs': 'د قیامت په ورځ د نیکیو ترازوی ډکوي.',
    },
    {
      "id": "t9",
      "titleAr": "اللَّهُ أَكْبَرُ",
      "meaningEn": "Allah is the Greatest.",
      'meaningUr': "اللہ سب سے بڑا ہے۔",
      'meaningPs': "الله تر ټولو لوی دی.",
      'fazilatEn': 'Among the four most beloved statements to Allah.',
      'fazilatUr': 'اللہ کے ہاں چار سب سے پسندیدہ کلمات میں سے ایک ہے۔',
      'fazilatPs': 'د الله په نزد تر ټولو خوښ څلور کلمات دي.',
    },
    {
      "id": "t10",
      "titleAr": "لَا إِلَهَ إِلَّا اللَّهُ",
      "meaningEn": "There is no god worthy of worship except Allah.",
      'meaningUr': "اللہ کے سوا کوئی معبود نہیں۔",
      'meaningPs': "د الله پرته بل د عبادت وړ نشته.",
      'fazilatEn': 'The best form of remembrance (Dhikr).',
      'fazilatUr': 'سب سے افضل ذکر ہے۔',
      'fazilatPs': 'تر ټولو غوره ذکر دی.',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu ? "تسبیح" : (isPashto ? "تسبیح" : "Tasbeeh"),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasbeehList.length,
        separatorBuilder: (context, _) => const SizedBox(height: 12),
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
                  crossAxisAlignment: isRtl
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
                      isUrdu
                          ? item['meaningUr']!
                          : (isPashto
                              ? (item['meaningPs'] ?? item['meaningUr']!)
                              : item['meaningEn']!),
                      style: isRtl
                          ? TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              height: 1.8,
                            )
                          : const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      isUrdu
                          ? item['fazilatUr']!
                          : (isPashto
                              ? (item['fazilatPs'] ?? item['fazilatUr']!)
                              : item['fazilatEn']!),
                      style: isRtl
                          ? TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 13,
                              color: const Color(0xFF616161),
                            )
                          : const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
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
