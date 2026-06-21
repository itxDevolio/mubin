import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/features/quran/domain/entities/reciter.dart';
import 'package:auraq/features/quran/presentation/controllers/quran_audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final audioState = ref.watch(quranAudioPlayerControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: 0.5,
          ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('General Preferences'),
              _buildSettingsCard(
                isDark,
                children: [
                  _buildSettingsTile(
                    icon: Icons.language_rounded,
                    title: 'App Language',
                    subtitle: settings.language == 'en' ? 'English' : 'Urdu (اردو)',
                    isDark: isDark,
                    onTap: () => _showLanguageDialog(context, ref, settings.language),
                  ),
                  _buildDivider(isDark),
                  _buildSettingsTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Theme Mode',
                    subtitle: isDark ? 'Dark Mode' : 'Light Mode',
                    isDark: isDark,
                    trailing: Switch(
                      value: isDark,
                      onChanged: (val) {
                        hapticFeedBack();
                        // Theme switching logic
                      },
                      activeTrackColor: AppColors.primaryTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Quran & Audio'),
              _buildSettingsCard(
                isDark,
                children: [
                  _buildSettingsTile(
                    icon: Icons.record_voice_over_outlined,
                    title: 'Audio Reciter',
                    subtitle: audioState.currentReciter.name,
                    isDark: isDark,
                    onTap: () => _showReciterDialog(context, ref, audioState.currentReciter),
                  ),
                  _buildDivider(isDark),
                  _buildSettingsTile(
                    icon: Icons.translate_rounded,
                    title: 'Quran Translation',
                    subtitle: 'English / Urdu text',
                    isDark: isDark,
                    onTap: () {},
                  ),
                  _buildDivider(isDark),
                  _buildSettingsTile(
                    icon: Icons.font_download_outlined,
                    title: 'Arabic Script & Size',
                    subtitle: 'Amiri / IndoPak script',
                    isDark: isDark,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Support & About'),
              _buildSettingsCard(
                isDark,
                children: [
                  _buildSettingsTile(
                    icon: Icons.share_outlined,
                    title: 'Share Auraq',
                    subtitle: 'Invite friends and family',
                    isDark: isDark,
                    onTap: () {},
                  ),
                  _buildDivider(isDark),
                  _buildSettingsTile(
                    icon: Icons.star_border_rounded,
                    title: 'Rate & Review',
                    subtitle: 'Support us on App Store',
                    isDark: isDark,
                    onTap: () {},
                  ),
                  _buildDivider(isDark),
                  _buildSettingsTile(
                    icon: Icons.info_outline_rounded,
                    title: 'App Version',
                    subtitle: 'Version 1.0.0 (Beta)',
                    isDark: isDark,
                    trailing: const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTeal,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(bool isDark, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(children: children),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withAlpha(20),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primaryTeal, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: isDark ? Colors.white30 : Colors.black26,
          ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      color: isDark ? AppColors.borderDark : AppColors.borderLight,
      height: 1,
      indent: 56,
    );
  }

  void _showReciterDialog(BuildContext context, WidgetRef ref, Reciter currentReciter) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Reciter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
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
                      leading: CircleAvatar(
                        backgroundColor: isSelected ? AppColors.primaryTeal : Colors.transparent,
                        child: Icon(
                          Icons.person_rounded,
                          color: isSelected ? Colors.white : AppColors.primaryTeal,
                        ),
                      ),
                      title: Text(
                        reciter.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.primaryTeal) : null,
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

  void _showLanguageDialog(BuildContext context, WidgetRef ref, String currentLang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          title: Text(
            'Select Language',
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context, 
                ref, 
                title: 'English', 
                value: 'en', 
                isSelected: currentLang == 'en',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildLanguageOption(
                context, 
                ref, 
                title: 'اردو (Urdu)', 
                value: 'ur', 
                isSelected: currentLang == 'ur',
                isDark: isDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, 
    WidgetRef ref, {
    required String title, 
    required String value, 
    required bool isSelected,
    required bool isDark,
  }) {
    return InkWell(
      onTap: () {
        hapticFeedBack();
        ref.read(settingsControllerProvider.notifier).setLanguage(value);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryTeal.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryTeal : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primaryTeal, size: 20),
          ],
        ),
      ),
    );
  }
}