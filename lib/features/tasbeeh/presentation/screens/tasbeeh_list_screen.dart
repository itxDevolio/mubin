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
      'titleAr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      'meaningEn': 'Glory be to Allah and all praise is due to Him.',
      'meaningUr': 'اللہ پاک ہے اور اسی کی تعریف ہے۔',
      'fazilatEn': 'Sins are forgiven even if they are like the foam of the sea.',
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
      'reference': 'Jami` at-Tirmidhi 3465',
    },
    {
      'id': 't3',
      'titleAr': 'لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      'meaningEn': 'None has the right to be worshipped but Allah alone, Who has no partner...',
      'meaningUr': 'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں...',
      'fazilatEn': 'Reward of freeing 10 slaves and protection from Shaytan.',
      'fazilatUr': '10 غلاموں کو آزاد کرنے کا ثواب اور شیطان سے حفاظت۔',
      'reference': 'Sahih al-Bukhari 3293',
    },
    {
      'id': 't4',
      'titleAr': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
      'meaningEn': 'There is no power and no strength except with Allah.',
      'meaningUr': 'نیکی کرنے کی طاقت اور برائی سے بچنے کی ہمت صرف اللہ کی طرف سے ہے۔',
      'fazilatEn': 'A treasure from the treasures of Paradise.',
      'fazilatUr': 'جنت کے خزانوں میں سے ایک خزانہ ہے۔',
      'reference': 'Sahih al-Bukhari 6386',
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
      'meaningEn': 'O Allah, send blessings upon Muhammad and upon the family of Muhammad.',
      'meaningUr': 'اے اللہ! محمد ﷺ اور ان کی آل پر اپنی رحمتیں نازل فرما۔',
      'fazilatEn': 'Whoever sends one blessing, Allah sends ten blessings upon him.',
      'fazilatUr': 'جو ایک بار درود بھیجے، اللہ اس پر دس رحمتیں نازل فرماتا ہے۔',
      'reference': 'Sahih Muslim 408',
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
        "Tasbeeh",
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: tasbeehList.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = tasbeehList[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Arabic Text - Prominent & Beautiful
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            item['titleAr']!,
                            style: GoogleFonts.amiri(
                              color: AppColors.primaryTeal,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Translation
                        Text(
                          isUrdu ? item['meaningUr']! : item['meaningEn']!,
                          style: isUrdu 
                            ? GoogleFonts.notoNastaliqUrdu(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black87,
                                height: 2.2,
                              )
                            : TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black87,
                                height: 1.5,
                              ),
                          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                        ),

                        const SizedBox(height: 16),

                        // Fazilat Box - Minimal Accent
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primaryTeal.withValues(alpha: 0.1)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.auto_awesome, size: 14, color: AppColors.primaryTeal.withValues(alpha: 0.7)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  isUrdu ? item['fazilatUr']! : item['fazilatEn']!,
                                  style: isUrdu 
                                    ? GoogleFonts.notoNastaliqUrdu(
                                        fontSize: 12,
                                        color: isDark ? Colors.white60 : Colors.black54,
                                        height: 2.0,
                                        fontStyle: FontStyle.italic,
                                      )
                                    : TextStyle(
                                        fontSize: 12,
                                        color: isDark ? Colors.white60 : Colors.black54,
                                        fontStyle: FontStyle.italic,
                                        height: 1.4,
                                      ),
                                  textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        if (item['reference'] != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Icon(Icons.menu_book_outlined, size: 12, color: isDark ? Colors.white24 : Colors.black26),
                              const SizedBox(width: 6),
                              Text(
                                item['reference']!,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white24 : Colors.black26,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
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
