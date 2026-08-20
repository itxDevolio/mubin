import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/app_colors.dart';
import '../../../core/services/settings_controller.dart';
import '../../../core/services/haptic_feedback.dart';
import '../../../core/widgets/custom_islamic_switch.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  TextStyle _getStyle({
    double fontSize = 14,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: _getStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildMasterSwitch(context, settings, controller, isDark),
          const SizedBox(height: 32),
          _buildSectionHeader("PRAYER REMINDERS", Icons.mosque_rounded),
          _buildSettingsCard(isDark, [
            _buildSettingTile(
              "Fajr",
              settings.fajrNotification,
              (val) =>
                  controller.updateNotificationSetting('fajrNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Dhuhr",
              settings.dhuhrNotification,
              (val) => controller.updateNotificationSetting(
                'dhuhrNotification',
                val,
              ),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Asr",
              settings.asrNotification,
              (val) =>
                  controller.updateNotificationSetting('asrNotification', val),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Maghrib",
              settings.maghribNotification,
              (val) => controller.updateNotificationSetting(
                'maghribNotification',
                val,
              ),
              isDark,
            ),
            _buildDivider(isDark),
            _buildSettingTile(
              "Isha",
              settings.ishaNotification,
              (val) =>
                  controller.updateNotificationSetting('ishaNotification', val),
              isDark,
            ),
          ]),
          const SizedBox(height: 32),
          _buildSectionHeader(
            "PRAYER EXPERIENCE",
            Icons.settings_suggest_rounded,
          ),
          _buildSettingsCard(isDark, [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Auto-open App",
                          style: _getStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white.withOpacity(0.9)
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Automatically opens the app when prayer notification arrives for a full-screen experience.",
                          style: _getStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomIslamicSwitch(
                    value: settings.autoOpenOnPrayer,
                    onChanged: (val) {
                      hapticFeedBack();
                      controller.updateNotificationSetting(
                        'autoOpenOnPrayer',
                        val,
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 32),
          _buildSectionHeader("ADHKAR REMINDERS", Icons.auto_awesome_rounded),
          _buildSettingsCard(isDark, [
            _buildAdhkarTile(
              context,
              "Morning Adhkar",
              settings.morningAdhkarNotification,
              settings.morningAdhkarTime,
              (val) => controller.updateNotificationSetting(
                'morningAdhkarNotification',
                val,
              ),
              () => _pickTime(
                context,
                ref,
                'morningAdhkarTime',
                settings.morningAdhkarTime,
              ),
              isDark,
            ),
            _buildDivider(isDark),
            _buildAdhkarTile(
              context,
              "Evening Adhkar",
              settings.eveningAdhkarNotification,
              settings.eveningAdhkarTime,
              (val) => controller.updateNotificationSetting(
                'eveningAdhkarNotification',
                val,
              ),
              () => _pickTime(
                context,
                ref,
                'eveningAdhkarTime',
                settings.eveningAdhkarTime,
              ),
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
            style: const TextStyle(
              fontFamily: 'Poppins',
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
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMasterSwitch(
    BuildContext context,
    SettingsState settings,
    SettingsController controller,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: settings.notificationsEnabled
              ? [AppColors.primaryTeal, AppColors.darkTeal]
              : [
                  isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.05),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          if (settings.notificationsEnabled)
            BoxShadow(
              color: AppColors.primaryTeal.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
        ],
        border: Border.all(
          color: settings.notificationsEnabled
              ? Colors.white.withOpacity(0.2)
              : (isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enable All Notifications",
                  style: _getStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: settings.notificationsEnabled
                        ? Colors.white
                        : (isDark
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black87),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  settings.notificationsEnabled
                      ? "System is fully active"
                      : "All notifications are currently paused",
                  style: _getStyle(
                    fontSize: 12,
                    color: settings.notificationsEnabled
                        ? Colors.white.withOpacity(0.7)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          CustomIslamicSwitch(
            value: settings.notificationsEnabled,
            onChanged: (val) {
              hapticFeedBack();
              controller.toggleNotifications(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    bool value,
    Function(bool) onChanged,
    bool isDark,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      title: Text(
        title,
        style: _getStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
        ),
      ),
      trailing: CustomIslamicSwitch(
        value: value,
        onChanged: (val) {
          hapticFeedBack();
          onChanged(val);
        },
      ),
    );
  }

  Widget _buildAdhkarTile(
    BuildContext context,
    String title,
    bool value,
    String time,
    Function(bool) onChanged,
    VoidCallback onTimeTap,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: _getStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? Colors.white.withOpacity(0.9)
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: value ? onTimeTap : null,
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: value
                          ? AppColors.primaryTeal.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 14,
                          color: value ? AppColors.primaryTeal : Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          time,
                          style: _getStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: value ? AppColors.primaryTeal : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomIslamicSwitch(
            value: value,
            onChanged: (val) {
              hapticFeedBack();
              onChanged(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      color: isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.black.withOpacity(0.03),
      indent: 20,
      endIndent: 20,
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    WidgetRef ref,
    String key,
    String currentTime,
  ) async {
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryTeal,
              onPrimary: Colors.white,
              surface: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.surfaceDark
                  : Colors.white,
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
