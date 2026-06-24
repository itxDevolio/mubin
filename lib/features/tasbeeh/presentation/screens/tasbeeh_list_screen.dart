import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tasbeeh_screen.dart';

class TasbeehListScreen extends ConsumerWidget {
  const TasbeehListScreen({super.key});

  final List<Map<String, String>> tasbeehList = const [
    {
      'id': 't1',
      'titleEn': 'SubhanAllah',
      'titleUr': 'سبحان اللہ',
      'meaningEn': 'Glory be to Allah',
      'meaningUr': 'اللہ پاک ہے',
      'titleAr': 'سُبْحَانَ اللهِ',
      'fazilatEn': 'Fills the scale of good deeds.',
      'fazilatUr': 'میزان (اعمال کے ترازو) کو نیکیوں سے بھر دیتا ہے۔',
      'reference': 'Sahih Muslim',
    },
    {
      'id': 't2',
      'titleEn': 'Alhamdulillah',
      'titleUr': 'الحمد للہ',
      'meaningEn': 'All praise is due to Allah',
      'meaningUr': 'سب تعریفیں اللہ کے لیے ہیں',
      'titleAr': 'الْحَمْدُ لِلَّهِ',
      'fazilatEn': 'Fills the space between the heavens and the earth.',
      'fazilatUr': 'زمین اور آسمان کے درمیان کی جگہ کو بھر دیتا ہے۔',
      'reference': 'Sahih Muslim',
    },
    {
      'id': 't3',
      'titleEn': 'Allahu Akbar',
      'titleUr': 'اللہ اکبر',
      'meaningEn': 'Allah is the Greatest',
      'meaningUr': 'اللہ سب سے بڑا ہے',
      'titleAr': 'اللهُ أَكْبَرُ',
      'fazilatEn': 'Removes sins like leaves falling from a tree.',
      'fazilatUr': 'گناہوں کو جھاڑ دیتا ہے جیسے درخت کے پتے جھڑتے ہیں۔',
      'reference': 'Tirmidhi',
    },
    {
      'id': 't4',
      'titleEn': 'Astaghfirullah',
      'titleUr': 'استغفر اللہ',
      'meaningEn': 'I seek forgiveness from Allah',
      'meaningUr': 'میں اللہ سے معافی مانگتا ہوں',
      'titleAr': 'أَسْتَغْفِرُ اللهَ',
      'fazilatEn': 'Brings blessings in provision and relief from every worry.',
      'fazilatUr': 'رزق میں برکت اور ہر پریشانی سے نجات ملتی ہے۔',
      'reference': 'Abu Dawud',
    },
    {
      'id': 't5',
      'titleEn': 'La ilaha illallah',
      'titleUr': 'لا الہ الا اللہ',
      'meaningEn': 'There is no god but Allah',
      'meaningUr': 'اللہ کے سوا کوئی معبود نہیں',
      'titleAr': 'لَا إِلَهَ إِلَّا اللهُ',
      'fazilatEn': 'The best form of remembrance and its reward is Paradise.',
      'fazilatUr': 'یہ افضل ترین ذکر ہے اور اس کی جزا جنت ہے۔',
      'reference': 'Tirmidhi',
    },
    {
      'id': 't6',
      'titleEn': 'SubhanAllahi wa bihamdihi',
      'titleUr': 'سبحان اللہ وبحمدہ',
      'meaningEn': 'Glory be to Allah and all praise is due to Him',
      'meaningUr': 'اللہ پاک ہے اور اسی کی تعریف ہے',
      'titleAr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      'fazilatEn': 'Sins are forgiven even if they are like the foam of the sea.',
      'fazilatUr': 'دن میں 100 بار پڑھنے سے سمندر کی جھاگ کے برابر گناہ معاف۔',
      'reference': 'Sahih Bukhari',
    },
    {
      'id': 't7',
      'titleEn': 'SubhanAllahil Azeem',
      'titleUr': 'سبحان اللہ العظیم',
      'meaningEn': 'Glory be to Allah, the Magnificent',
      'meaningUr': 'اللہ پاک ہے جو بہت عظمت والا ہے',
      'titleAr': 'سُبْحَانَ اللَّهِ الْعَظِيمِ',
      'fazilatEn': 'Light on the tongue, heavy on the scales, and loved by the Most Merciful.',
      'fazilatUr': 'زبان پر ہلکا، ترازو میں بھاری اور رحمن کو بہت پسند ہے۔',
      'reference': 'Sahih Bukhari',
    },
    {
      'id': 't8',
      'titleEn': 'La hawla wa la quwwata illa billah',
      'titleUr': 'لا حول ولا قوۃ الا باللہ',
      'meaningEn': 'There is no power nor might except with Allah',
      'meaningUr': 'گناہوں سے بچنے اور نیکی کرنے کی طاقت اللہ ہی کی طرف سے ہے',
      'titleAr': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
      'fazilatEn': 'A treasure from the treasures of Paradise.',
      'fazilatUr': 'یہ جنت کے خزانوں میں سے ایک خزانہ ہے۔',
      'reference': 'Sahih Bukhari',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
         "Tasbeeh ",
          style: isUrdu 
              ? GoogleFonts.notoNastaliqUrdu(fontSize: 18, fontWeight: FontWeight.bold)
              : const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Directionality(
        textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: tasbeehList.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = tasbeehList[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Material(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  child: InkWell(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isUrdu ? "ذکر" : "Dhikr",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryTeal.withOpacity(0.7),
                                        letterSpacing: 1.0,
                                        fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isUrdu ? item['titleUr']! : item['titleEn']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isUrdu ? 18 : 16,
                                        color: isDark ? Colors.white : Colors.black87,
                                        fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isUrdu ? item['meaningUr']! : item['meaningEn']!,
                                      style: TextStyle(
                                        fontSize: isUrdu ? 14 : 13,
                                        color: isDark ? Colors.white70 : Colors.black54,
                                        fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item['titleAr']!,
                                      style: GoogleFonts.amiri(
                                        color: AppColors.primaryTeal,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const SizedBox(height: 8),
                                    Icon(
                                      isUrdu ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                      color: isDark ? Colors.white24 : Colors.black26,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primaryTeal.withOpacity(0.1)
                                  : AppColors.primaryTeal.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryTeal.withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                        Icons.auto_awesome,
                                        size: 16,
                                        color: AppColors.primaryTeal.withOpacity(0.8)
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        isUrdu ? item['fazilatUr']! : item['fazilatEn']!,
                                        style: TextStyle(
                                          fontSize: isUrdu ? 13 : 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                          color: isDark ? Colors.white70 : Colors.black87,
                                          fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (item['reference'] != null) ...[
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24, right: 24),
                                    child: Text(
                                      "${ "Ref: "}${item['reference']}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: isDark ? Colors.white38 : Colors.black38,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
