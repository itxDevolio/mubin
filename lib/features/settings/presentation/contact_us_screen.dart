import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app_colors.dart';
import '../../../core/services/settings_controller.dart';
import '../../../core/services/haptic_feedback.dart';

class ContactUsScreen extends ConsumerWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = settings.language;
    final bool isUrdu = lang == 'ur';
    final bool isPashto = lang == 'ps';
    final bool isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    final String appBarTitle = isUrdu
        ? 'رابطہ اور سپورٹ'
        : (isPashto ? 'موږ سره اړیکه او مرسته' : 'Contact Us & Support');

    final String headerTitle = isUrdu
        ? 'ہم سے رابطہ کریں'
        : (isPashto ? 'مونږ سره اړیکه ونیسئ' : 'Get in Touch With Us');

    final String description = isUrdu
        ? 'ہم نے پوری کوشش کی ہے کہ مبین ایپ کو بہترین اور بگ فری رکھا جائے تاکہ آپ کی عبادت میں کوئی خلل نہ آئے۔ اگر آپ کو کوئی بھی مسئلہ یا خامی نظر آئے تو بلا جھجھک رابطہ کریں!'
        : (isPashto
              ? 'موږ پوره هڅه کړې چې مبین اپلیکیشن غوره او له بګونو پاک وي تر څو ستاسو عبادت په اسانۍ ترسره شي. که تاسو ته کومه ستونزه یا نیمګړتیا په نظر راشي، نو مهرباني وکړئ موږ ته خبر راکړئ!'
              : 'We have tried our best to keep Mubin bug-free and optimized for your daily spiritual needs. However, if you notice any issues or bugs, feel free to contact us anytime!');

    final String whatsappTitle = isUrdu
        ? 'واٹس ایپ'
        : (isPashto ? 'واټس اپ' : 'WhatsApp');

    final String whatsappSubtitle = '+92 300 3209427';

    final String emailTitle = isUrdu
        ? 'ای میل سپورٹ'
        : (isPashto ? 'برېښنالیک ملاتړ' : 'Email Support');

    final String emailSubtitle = 'devolio.office@gmail.com';

    final String footerText = isUrdu
        ? 'امت مسلمہ کے لیے محبت کے ساتھ تیار کیا گیا'
        : (isPashto ? 'د امت مسلمه لپاره په مینه جوړ شوی' : 'Developed with ❤️ for the Muslim Ummah');

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        appBar: AppBar(
          title: Text(
            appBarTitle,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: isRtl ? 16 : 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Top Banner Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryTeal,
                    AppColors.primaryTeal.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryTeal.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    headerTitle,
                    textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: isRtl ? 18 : 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: isUrdu || isPashto ? 13 : 13.5,
                      height: 1.9,
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // WhatsApp Contact Card
            InkWell(
              onTap: () {
                hapticFeedBack();
                _launchWhatsApp();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Row(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.chat_rounded,
                        color: Color(0xFF25D366),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            whatsappTitle,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            whatsappSubtitle,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isRtl ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Email Contact Card
            InkWell(
              onTap: () {
                hapticFeedBack();
                _launchEmail();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Row(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTeal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primaryTeal,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            emailTitle,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            emailSubtitle,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isRtl ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Footer branding
            Center(
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  footerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/923003209427?text=Salam! I want to contact Mubin support / development.",
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch WhatsApp');
    }
  }

  Future<void> _launchEmail() async {
    final Uri url = Uri.parse(
      "mailto:devolio.office@gmail.com?subject=Mubin App Support / Inquiry&body=Salam!",
    );
    if (!await launchUrl(url)) {
      debugPrint('Could not launch Email');
    }
  }
}
