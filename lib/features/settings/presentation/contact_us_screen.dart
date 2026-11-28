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
    final String fontFamily = isPashto
        ? 'Amiri'
        : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    final String appBarTitle = isUrdu
        ? 'رابطہ اور سپورٹ'
        : (isPashto ? 'موږ سره اړیکه او مرسته' : 'Contact Us & Support');

    final String headerTitle = isUrdu
        ? 'ہم سے رابطہ کریں'
        : (isPashto ? 'مونږ سره اړیکه ونیسئ' : 'Get in Touch With Us');

    final String description = isUrdu
        ? 'ہم نے پوری کوشش کی ہے کہ مبین ایپ کو بہترین اور بگ فری رکھا جائے تاکہ آپ کی عبادت میں کوئی خلل نہ آئے۔ اگر آپ کو کوئی بھی مسئلہ، بگ یا خامی نظر آئے یا کوئی تجاویز ہوں، تو بلا جھجھک واٹس ایپ یا ای میل کے ذریعے رابطہ کریں۔'
        : (isPashto
              ? 'موږ خپله پوره هڅه کړې چې مبین اپلیکیشن غوره او له بګونو پاک وساتو تر څو ستاسو عبادت په اسانۍ ترسره شي. که تاسو ته کومه ستونزه، بګ یا نیمګړتیا په نظر راشي، نو مهرباني وکړئ په واټس اپ یا برېښنالیک له موږ سره اړیکه ونیسئ.'
              : 'We have tried our best to keep Mubin bug-free and optimized for your daily spiritual needs. However, if you notice any issues, bugs, or have feedback, feel free to contact us anytime via WhatsApp or Email.');

    final String whatsappTitle = isUrdu
        ? 'واٹس ایپ: +92 300 3209427'
        : (isPashto ? 'واټس اپ: +92 300 3209427' : 'WhatsApp: +92 300 3209427');

    final String emailTitle = isUrdu
        ? 'ای میل: devolio.office@gmail.com'
        : (isPashto ? 'برېښنالیک: devolio.office@gmail.com' : 'Email: devolio.office@gmail.com');

    final String footerText = isUrdu
        ? 'امت مسلمہ کے لیے محبت کے ساتھ تیار کیا گیا'
        : (isPashto
              ? 'د امت مسلمه لپاره په مینه جوړ شوی'
              : 'Developed with ❤️ for the Muslim Ummah');

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
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          children: [
            // Header Title
            Text(
              headerTitle,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                height: 1.9,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 36),
            const Divider(height: 1),
            const SizedBox(height: 24),

            // WhatsApp Link
            InkWell(
              onTap: () {
                hapticFeedBack();
                _launchWhatsApp();
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      whatsappTitle,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Email Link
            InkWell(
              onTap: () {
                hapticFeedBack();
                _launchEmail();
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      emailTitle,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),

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
