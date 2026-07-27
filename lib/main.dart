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
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Initialize required services for background task
    tzdata.initializeTimeZones();
    await Hive.initFlutter();
    await Hive.openBox(DbConstants.appBox);

    final notificationService = NotificationService();
    await notificationService.init();
    await notificationService.scheduleAllNotifications();

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Workmanager
  await Workmanager().initialize(callbackDispatcher);

  // Register periodic task to reschedule notifications every 24 hours
  await Workmanager().registerPeriodicTask(
    "mubin_notification_reschedule",
    "reschedule_notifications",
    frequency: const Duration(hours: 24),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    constraints: Constraints(
      networkType: NetworkType.notRequired,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    ),
  );

  // Initialize Timezone & Hive basic setup
  tzdata.initializeTimeZones();
  await Hive.initFlutter();

  // Open boxes before anything else
  await Hive.openBox(DbConstants.appBox);
  await Hive.openBox(DbConstants.hadithBox);
  await Hive.openBox('adhkar_box');
  await Hive.openBox('tasbeeh_box');

  // Start App immediately to avoid white screen
  runApp(const ProviderScope(child: MubinApp()));

  // Background Initializations (Don't block UI start)
  _initServices();
}

Future<void> _initServices() async {
  try {
    // Set local location
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
    } catch (_) {}

    // Initialize Just Audio Background
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.devolio.mubin.app.channel.audio',
      androidNotificationChannelName: 'Quran Audio',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/launcher_icon',
    );

    // Initialize Notifications
    final notificationService = NotificationService();
    await notificationService.init();

    // Pre-fetch fonts
    await AppTypography.prefetchFonts();

    // Schedule notifications (will request permissions if needed)
    await notificationService.scheduleAllNotifications();
  } catch (e) {
    debugPrint("Initialization Error: $e");
  }
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
