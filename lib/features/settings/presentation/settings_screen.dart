import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildSectionHeader('Preference'),
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.primaryTeal),
            title: const Text('App Language'),
            subtitle: Text(
              settings.language == 'en' ? 'English' : 'Urdu (اردو)',
            ),
            trailing: DropdownButton<String>(
              value: settings.language,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ur', child: Text('Urdu')),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref
                      .read(settingsControllerProvider.notifier)
                      .setLanguage(val);
                }
              },
            ),
          ),
          const Divider(),
          _buildSectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline, color: AppColors.primaryTeal),
            title: Text('App Version'),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTeal,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
