import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'core/constant/db_consts.dart';
import 'core/services/notification_service.dart';
import 'core/services/settings_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_typography.dart';
import 'home/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Timezone
  tzdata.initializeTimeZones();
  // Set local location - usually Asia/Karachi for this context
  // or you can try to detect it.
  try {
    tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
  } catch (e) {
    // Fallback if location not found
  }

  // Initialize Just Audio Background
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.devolio.mubin.channel.audio',
    androidNotificationChannelName: 'Quran Audio',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',
  );

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox(DbConstants.appBox);
  await Hive.openBox(DbConstants.hadithBox);
  await Hive.openBox('adhkar_box');
  await Hive.openBox('tasbeeh_box');

  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.init();

  // Request location permission on start as it's needed for prayer times UI
  await Permission.location.request();

  // Pre-fetch fonts to avoid UI flickering on first install
  await AppTypography.prefetchFonts();

  // Schedule notifications on app start
  await notificationService.scheduleAllNotifications();

  runApp(const ProviderScope(child: MubinApp()));
}

class MubinApp extends ConsumerWidget {
  const MubinApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);

    return MaterialApp(
      title: 'Mubin',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: settings.themeMode,
      home: const HomeScreen(),
    );
  }
}
