import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'core/app_colors.dart';
import 'core/constant/db_consts.dart';
import 'core/services/notification_service.dart';
import 'core/services/settings_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_typography.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

    // Initialize AdMob
    await MobileAds.instance.initialize();

    // Initialize Notifications
    final notificationService = NotificationService();
    await notificationService.init();

    // Schedule notifications (will request permissions if needed)
    await notificationService.scheduleAllNotifications();
  } catch (e) {
    debugPrint("Initialization Error: $e");
  }
}

class MubinApp extends ConsumerStatefulWidget {
  const MubinApp({super.key});

  @override
  ConsumerState<MubinApp> createState() => _MubinAppState();
}

class _MubinAppState extends ConsumerState<MubinApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Perform all critical initializations here
    final startTime = DateTime.now();
    
    await _initServices();

    // Ensure splash screen shows for at least 4.5 seconds for a smooth animation experience
    final endTime = DateTime.now();
    final elapsed = endTime.difference(startTime);
    if (elapsed < const Duration(milliseconds: 4500)) {
      await Future.delayed(Duration(milliseconds: 4500 - elapsed.inMilliseconds));
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);

    if (!_isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: settings.themeMode,
        home: const SplashScreen(),
      );
    }

    return MaterialApp(
      title: 'Mubin',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: settings.themeMode,
      home: const HomeScreen(),
    );
  }
}
