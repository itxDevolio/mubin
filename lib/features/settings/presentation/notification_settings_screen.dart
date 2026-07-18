import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../core/services/settings_controller.dart';
import '../../../core/services/haptic_feedback.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildMasterSwitch(context, settings, controller, isDark),
          const SizedBox(height: 30),
          _buildSectionHeader("PRAYER REMINDERS", Icons.mosque_rounded),
          _buildSettingsCard(isDark, [
            _buildSettingTile(
              "Fajr",
              settings.fajrNotification,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('fajrNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Dhuhr",
              settings.dhuhrNotification,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('dhuhrNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Asr",
              settings.asrNotification,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('asrNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Maghrib",
              settings.maghribNotification,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('maghribNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Isha",
              settings.ishaNotification,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('ishaNotification', val),
              isDark,
            ),
          ]),
          const SizedBox(height: 30),
          _buildSectionHeader("ADHKAR REMINDERS", Icons.auto_awesome_rounded),
          _buildSettingsCard(isDark, [
            _buildAdhkarTile(
              context,
              "Morning Adhkar",
              settings.adhkarNotification,
              settings.morningAdhkarTime,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('adhkarNotification', val),
              () => _pickTime(context, ref, 'morningAdhkarTime', settings.morningAdhkarTime),
              isDark,
            ),
            _buildDivider(isDark),
            _buildAdhkarTile(
              context,
              "Evening Adhkar",
              settings.adhkarNotification,
              settings.eveningAdhkarTime,
              settings.notificationsEnabled,
              (val) => controller.updateNotificationSetting('adhkarNotification', val),
              () => _pickTime(context, ref, 'eveningAdhkarTime', settings.eveningAdhkarTime),
              isDark,
            ),
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primaryTeal),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryTeal,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMasterSwitch(BuildContext context, SettingsState settings, SettingsController controller, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: settings.notificationsEnabled 
            ? [AppColors.primaryTeal, AppColors.darkTeal]
            : [Colors.grey.withOpacity(0.1), Colors.grey.withOpacity(0.2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (settings.notificationsEnabled)
            BoxShadow(
              color: AppColors.primaryTeal.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enable All Notifications",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: settings.notificationsEnabled ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                ),
              ),
              Text(
                settings.notificationsEnabled ? "Everything is active" : "Notifications are paused",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: settings.notificationsEnabled ? Colors.white.withOpacity(0.8) : Colors.grey,
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: settings.notificationsEnabled,
            activeTrackColor: Colors.white24,
            activeColor: Colors.white,
            onChanged: (val) {
              hapticFeedBack();
              controller.toggleNotifications(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, bool value, bool masterEnabled, Function(bool) onChanged, bool isDark) {
    return Opacity(
      opacity: masterEnabled ? 1.0 : 0.4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15, 
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        trailing: Switch.adaptive(
          value: value,
          activeColor: AppColors.primaryTeal,
          onChanged: masterEnabled ? (val) {
            hapticFeedBack();
            onChanged(val);
          } : null,
        ),
      ),
    );
  }

  Widget _buildAdhkarTile(
    BuildContext context, 
    String title, 
    bool value, 
    String time, 
    bool masterEnabled, 
    Function(bool) onChanged,
    VoidCallback onTimeTap,
    bool isDark
  ) {
    return Opacity(
      opacity: masterEnabled ? 1.0 : 0.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15, 
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: masterEnabled && value ? onTimeTap : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTeal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time_filled_rounded, size: 14, color: AppColors.primaryTeal),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: value,
              activeColor: AppColors.primaryTeal,
              onChanged: masterEnabled ? (val) {
                hapticFeedBack();
                onChanged(val);
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
      indent: 20,
      endIndent: 20,
    );
  }

  Future<void> _pickTime(BuildContext context, WidgetRef ref, String key, String currentTime) async {
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryTeal,
              onPrimary: Colors.white,
              surface: Theme.of(context).brightness == Brightness.dark ? AppColors.surfaceDark : Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      hapticFeedBack();
      ref.read(settingsControllerProvider.notifier).setAdhkarTime(key, picked);
    }
  }
}
