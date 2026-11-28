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
        ? 'ہم آپ کی مدد کے لیے ہمیشہ حاضر ہیں۔ کسی بھی سوال، فیڈ بیک یا رہنمائی کے لیے واٹس ایپ یا ای میل کے ذریعے بلا جھجھک رابطہ کریں۔'
        : (isPashto
              ? 'موږ تل ستاسو د مرستې لپاره چمتو یو. د هرې پوښتنې، نظر یا مرستې لپاره په واټس اپ یا برېښنالیک له موږ سره اړیکه ونیسئ.'
              : 'We are always here to help. Reach out to us via WhatsApp or Email anytime for any questions, feedback, or support.');

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
        : (isPashto
              ? 'د امت مسلمه لپاره په مینه جوړ شوی'
              : 'Developed with ❤️ for the Muslim Ummah');

    return Scaffold(
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          // Clean Header Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.support_agent_rounded,
                    color: AppColors.primaryTeal,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    headerTitle,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  height: 1.8,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          const SizedBox(height: 24),

          // WhatsApp Contact Row
          ListTile(
            onTap: () {
              hapticFeedBack();
              _launchWhatsApp();
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF25D366).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.chat_rounded,
                color: Color(0xFF25D366),
                size: 22,
              ),
            ),
            title: Text(
              whatsappTitle,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              whatsappSubtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),

          // Email Contact Row
          ListTile(
            onTap: () {
              hapticFeedBack();
              _launchEmail();
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.email_outlined,
                color: AppColors.primaryTeal,
                size: 22,
              ),
            ),
            title: Text(
              emailTitle,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              emailSubtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 50),

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
