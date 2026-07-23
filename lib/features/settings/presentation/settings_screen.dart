import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/features/quran/domain/entities/reciter.dart';
import 'package:mubin/features/quran/presentation/controllers/quran_audio_player_controller.dart';
import 'package:mubin/features/settings/presentation/notification_settings_screen.dart';
import 'package:mubin/features/settings/presentation/calculation_method_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  TextStyle _getStyle({double fontSize = 14, FontWeight? fontWeight, Color? color, double? height}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        children: [
          _buildSectionHeader('PREFERENCES'),
          _buildSettingsCard(
            isDark,
            children: [
              _buildSettingsTile(
                icon: Icons.brightness_4_rounded,
                title: 'App Theme',
                subtitle: _getThemeModeName(settings.themeMode),
                isDark: isDark,
                onTap: () => _showThemeDialog(context, ref, settings.themeMode),
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.translate_rounded,
                title: 'App Language',
                subtitle: settings.language == 'en' ? 'English' : 'Urdu (اردو)',
                isDark: isDark,
                onTap: () => _showLanguageDialog(context, ref, settings.language),
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: settings.notificationsEnabled ? 'Enabled' : 'Disabled',
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.auto_awesome_mosaic_rounded,
                title: 'Calculation Method',
                subtitle: calculationMethods.firstWhere((m) => m['key'] == settings.calculationMethod)['name']!,
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculationMethodScreen(),
                    ),
                  );
                },
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.brightness_high_rounded,
                title: 'Madhab (Asr)',
                subtitle: settings.madhab == 'hanafi' ? 'Hanafi (Later Asr)' : 'Shafi\'i (Earlier Asr)',
                isDark: isDark,
                onTap: () => _showMadhabDialog(context, ref, settings.madhab),
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.headphones_rounded,
                title: 'Background Play',
                subtitle: 'Keep audio active when app is minimized',
                isDark: isDark,
                trailing: CupertinoSwitch(
                  value: settings.keepPlayingInBackground,
                  activeTrackColor: AppColors.primaryTeal,
                  onChanged: (val) {
                    hapticFeedBack();
                    ref.read(settingsControllerProvider.notifier).setKeepPlayingInBackground(val);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSectionHeader('QURAN AUDIO'),
          _buildSettingsCard(
            isDark,
            children: [
              _buildSettingsTile(
                icon: Icons.mic_external_on_rounded,
                title: 'Primary Reciter',
                subtitle: audioState.currentReciter.name,
                isDark: isDark,
                onTap: () => _showReciterDialog(context, ref, audioState.currentReciter),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSectionHeader('SUPPORT & MISSION'),
          _buildSettingsCard(
            isDark,
            children: [
              _buildSettingsTile(
                icon: Icons.favorite_rounded,
                title: 'Support Our Mission',
                subtitle: 'Help us keep the app ad-free',
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  _showSupportDialog(context, isDark);
                },
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.ios_share_rounded,
                title: 'Share Mubin',
                subtitle: 'Spread the word to friends & family',
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  // Share logic
                },
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.star_outline_rounded,
                title: 'Rate & Review',
                subtitle: 'Support us on the Play Store',
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  // Store link logic
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSectionHeader('LEGAL'),
          _buildSettingsCard(
            isDark,
            children: [
              _buildSettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About Mubin',
                subtitle: 'Our mission and vision',
                isDark: isDark,
                onTap: () => _showAboutDialog(context, isDark),
              ),
              _buildDivider(isDark),
              _buildSettingsTile(
                icon: Icons.policy_outlined,
                title: 'Privacy Policy',
                subtitle: 'Data protection terms',
                isDark: isDark,
                onTap: () {
                  hapticFeedBack();
                  // Policy link logic
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Opacity(
              opacity: 0.3,
              child: Column(
                children: [
                  Text(
                    'MUBIN ISLAMIC SUITE',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Designed for the Modern Ummah',
                    style: _getStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 0, bottom: 10.0),
      child: Text(
        title,
        style: _getStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: AppColors.primaryTeal,
        ).copyWith(letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildSettingsCard(bool isDark, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: _buildTileIcon(icon),
      trailing: trailing ?? Icon(Icons.chevron_right_rounded, size: 20, color: isDark ? Colors.white12 : Colors.black12),
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: _getStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87),
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.left,
        style: _getStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.black45),
      ),
    );
  }

  Widget _buildTileIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.primaryTeal, size: 20),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
      height: 1,
      indent: 20,
      endIndent: 20,
    );
  }

  void _showSupportDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(
          'Support Our Mission',
          textAlign: TextAlign.left,
          style: _getStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Help us keep Mubin ad-free. Your support helps us grow.',
              textAlign: TextAlign.left,
              style: _getStyle(fontSize: 14, height: 1.8),
            ),
            const SizedBox(height: 24),
            _buildSupportOption(
              icon: Icons.chat_rounded,
              title: 'WhatsApp',
              color: Colors.green,
              onTap: () => _launchWhatsApp(),
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
              icon: Icons.email_rounded,
              title: 'Email',
              color: AppColors.primaryTeal,
              onTap: () => _launchEmail(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: _getStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(title, style: _getStyle(color: color, fontWeight: FontWeight.bold)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/923499383654?text=Salam! I want to support Mubin development.");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  void _launchEmail() async {
    final Uri url = Uri.parse("mailto:ajmalkhan.dev@gmail.com?subject=Supporting Mubin App&body=Salam! I would like to help with Mubin development.");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch Email');
    }
  }

  void _showAboutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(
            'About Mubin',
            textAlign: TextAlign.left,
            style: _getStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        content: Text(
          'Mubin is an Islamic companion designed to bring peace through Quran and Prayer tools.',
          textAlign: TextAlign.left,
          style: _getStyle(fontSize: 14, height: 1.8),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: _getStyle(color: AppColors.primaryTeal)),
          ),
        ],
      ),
    );
  }

  void _showReciterDialog(BuildContext context, WidgetRef ref, Reciter currentReciter) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Reciter',
                style: _getStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: availableReciters.length,
                  itemBuilder: (context, index) {
                    final reciter = availableReciters[index];
                    final isSelected = currentReciter.name == reciter.name;
                    return ListTile(
                      onTap: () {
                        hapticFeedBack();
                        ref.read(quranAudioPlayerControllerProvider.notifier).setReciter(reciter);
                        Navigator.pop(context);
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                      leading: _buildReciterAvatar(isSelected),
                      trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryTeal) : null,
                      title: Text(
                        reciter.name,
                        textAlign: TextAlign.left,
                        style: _getStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReciterAvatar(bool isSelected) {
    return CircleAvatar(
      backgroundColor: isSelected ? AppColors.primaryTeal : AppColors.primaryTeal.withValues(alpha: 0.1),
      child: Icon(
        Icons.person_rounded,
        color: isSelected ? Colors.white : AppColors.primaryTeal,
        size: 20,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref, String currentLang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          title: Text(
            'Select Language',
            style: _getStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(
                context,
                ref,
                title: 'English',
                value: 'en',
                isSelected: currentLang == 'en',
                isDark: isDark,
                onSelect: (val) => ref.read(settingsControllerProvider.notifier).setLanguage(val),
              ),
              const SizedBox(height: 12),
              _buildOption(
                context,
                ref,
                title: 'Urdu (اردو)',
                value: 'ur',
                isSelected: currentLang == 'ur',
                isDark: isDark,
                onSelect: (val) => ref.read(settingsControllerProvider.notifier).setLanguage(val),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          title: Text(
            'Select Theme',
            textAlign: TextAlign.left,
            style: _getStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(context, ref, 'System Default', ThemeMode.system, currentMode == ThemeMode.system, isDark),
              const SizedBox(height: 12),
              _buildThemeOption(context, ref, 'Light Mode', ThemeMode.light, currentMode == ThemeMode.light, isDark),
              const SizedBox(height: 12),
              _buildThemeOption(context, ref, 'Dark Mode', ThemeMode.dark, currentMode == ThemeMode.dark, isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, WidgetRef ref, String title, ThemeMode mode, bool isSelected, bool isDark) {
    return InkWell(
      onTap: () {
        hapticFeedBack();
        ref.read(settingsControllerProvider.notifier).setThemeMode(mode);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryTeal.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryTeal : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: _getStyle(fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal, color: isDark ? Colors.white : Colors.black87),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.primaryTeal, size: 22),
              ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
    }
  }

  void _showMadhabDialog(BuildContext context, WidgetRef ref, String currentMadhab) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          title: Text(
            'Select Madhab',
            textAlign: TextAlign.left,
            style: _getStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(
                context,
                ref,
                title: 'Hanafi (Later Asr)',
                value: 'hanafi',
                isSelected: currentMadhab == 'hanafi',
                isDark: isDark,
                onSelect: (val) => ref.read(settingsControllerProvider.notifier).setMadhab(val),
              ),
              const SizedBox(height: 12),
              _buildOption(
                context,
                ref,
                title: 'Shafi\'i (Earlier Asr)',
                value: 'shafi',
                isSelected: currentMadhab == 'shafi',
                isDark: isDark,
                onSelect: (val) => ref.read(settingsControllerProvider.notifier).setMadhab(val),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
      BuildContext context,
      WidgetRef ref, {
        required String title,
        required String value,
        required bool isSelected,
        required bool isDark,
        required Function(String) onSelect,
      }) {
    return InkWell(
      onTap: () {
        hapticFeedBack();
        onSelect(value);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryTeal.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryTeal : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: _getStyle(fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal, color: isDark ? Colors.white : Colors.black87),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.primaryTeal, size: 22),
              ),
          ],
        ),
      ),
    );
  }
}