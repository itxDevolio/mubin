import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:hive/hive.dart';
import '../constant/db_consts.dart';
import '../app_colors.dart';
import '../../home/service/prayer_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tzdata.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _notificationsPlugin.initialize(
      settings: const InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      ),
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    // Request permissions for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    // Create channels
    const prayerChannel = AndroidNotificationChannel(
      'prayer_times_v1', // ID changed to force update on Android
      'Prayer Notifications',
      description: 'Notifications for Salah times',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      ledColor: AppColors.primaryTeal,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      sound: RawResourceAndroidNotificationSound('adhan_sound'),
    );

    const adhkarChannel = AndroidNotificationChannel(
      'adhkar_times_id',
      'Adhkar Notifications',
      description: 'Morning and Evening Adhkar reminders',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(prayerChannel);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(adhkarChannel);
  }

  Future<void> scheduleAllNotifications() async {
    // Clear all existing to avoid overlaps after time/setting changes
    await _notificationsPlugin.cancelAll();
    debugPrint("--- SCHEDULING ALL NOTIFICATIONS ---");

    final box = Hive.box(DbConstants.appBox);
    final bool enabled = box.get('notificationsEnabled', defaultValue: false);

    if (enabled) {
      // Ensure we have necessary permissions
      await Permission.notification.request();
      final status = await Permission.scheduleExactAlarm.status;
      if (status.isDenied) {
        await Permission.scheduleExactAlarm.request();
      }
    }

    if (!enabled) return;

    final double? lat = box.get('lat');
    final double? lng = box.get('lng');
    final String madhabStr = box.get('madhab', defaultValue: 'hanafi');
    final String methodKey = box.get(
      'calculationMethod',
      defaultValue: 'karachi',
    );
    final bool isHanafi = madhabStr == 'hanafi';

    if (lat == null || lng == null) return;

    final prayerService = PrayerService();
    final now = DateTime.now();

    // Schedule for 30 days to cover the month
    for (int i = 0; i < 30; i++) {
      final scheduleDate = now.add(Duration(days: i));
      final prayerTimes = await prayerService.getPrayerTime(
        lat,
        lng,
        isHanafi,
        date: scheduleDate,
        methodKey: methodKey,
      );

      await _scheduleDayPrayers(i, prayerTimes, box, scheduleDate);
    }
  }

  Future<void> _scheduleDayPrayers(
    int dayOffset,
    PrayerTimes prayerTimes,
    Box box,
    DateTime date,
  ) async {
    final Map<String, DateTime?> times = {
      'Fajr': prayerTimes.fajr,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };

    final Map<String, bool> settings = {
      'Fajr': box.get('fajrNotification', defaultValue: true),
      'Dhuhr': box.get('dhuhrNotification', defaultValue: true),
      'Asr': box.get('asrNotification', defaultValue: true),
      'Maghrib': box.get('maghribNotification', defaultValue: true),
      'Isha': box.get('ishaNotification', defaultValue: true),
    };

    final bool morningEnabled = box.get(
      'morningAdhkarNotification',
      defaultValue: true,
    );
    final bool eveningEnabled = box.get(
      'eveningAdhkarNotification',
      defaultValue: true,
    );
    final String morningTimeStr = box.get(
      'morningAdhkarTime',
      defaultValue: '07:00',
    );
    final String eveningTimeStr = box.get(
      'eveningAdhkarTime',
      defaultValue: '17:00',
    );

    int index = 0;
    for (var entry in times.entries) {
      final name = entry.key;
      final time = entry.value;
      if (time == null) {
        index++;
        continue;
      }

      final bool isPrayerEnabled = settings[name] ?? true;

      if (isPrayerEnabled) {
        final scheduledTime = tz.TZDateTime.from(time, tz.local);
        final now = tz.TZDateTime.now(tz.local);
        
        if (scheduledTime.isAfter(now)) {
          // Unique ID for each prayer of each day (Day 0: 0-4, Day 1: 100-104...)
          final id = (dayOffset * 100) + index;
          debugPrint("✅ SCHEDULING SUCCESS: $name at $scheduledTime (ID: $id)");
          await _notificationsPlugin.zonedSchedule(
            id: id,
            title: '🕌 Salah Time: $name',
            body: 'It is time for $name prayer. Don\'t miss your reward!',
            scheduledDate: scheduledTime,
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                'prayer_times_v1', // New channel ID match
                'Prayer Notifications',
                channelDescription: 'Notifications for Salah times',
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
                sound: const RawResourceAndroidNotificationSound('adhan_sound'),
                fullScreenIntent: true,
                category: AndroidNotificationCategory.alarm,
                visibility: NotificationVisibility.public,
                showWhen: true,
                ticker: 'Salah Time: $name',
                color: AppColors.primaryTeal,
                ledColor: AppColors.primaryTeal,
                ledOnMs: 1000,
                ledOffMs: 500,
                styleInformation: BigTextStyleInformation(
                  'It is time for $name prayer. "Indeed, prayer has been decreed upon the believers a decree of specified times." (4:103)',
                  contentTitle: '🕌 Salah Time: $name',
                  summaryText: 'Prayer Reminder',
                ),
                actions: <AndroidNotificationAction>[
                  const AndroidNotificationAction(
                    'open_app',
                    'Open App',
                    showsUserInterface: true,
                  ),
                ],
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                interruptionLevel: InterruptionLevel.critical,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }
      } else {
        debugPrint("⏭️ SKIPPING $name: Time $time has already passed (Now: ${tz.TZDateTime.now(tz.local)})");
      }
      index++;
    }

    // Schedule Adhkar with unique IDs
    if (morningEnabled) {
      await _scheduleAdhkar(dayOffset, date, morningTimeStr, 'Morning', 50, box);
    }
    if (eveningEnabled) {
      await _scheduleAdhkar(dayOffset, date, eveningTimeStr, 'Evening', 60, box);
    }
  }

  Future<void> _scheduleAdhkar(
    int dayOffset,
    DateTime date,
    String timeStr,
    String type,
    int subId,
    Box box,
  ) async {
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final adhkarDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
    final scheduledAdhkar = tz.TZDateTime.from(adhkarDateTime, tz.local);

    if (scheduledAdhkar.isAfter(tz.TZDateTime.now(tz.local))) {
      final id = (dayOffset * 100) + subId;
      final icon = type == 'Morning' ? '☀️' : '🌙';
      debugPrint("Scheduling $type Adhkar at $scheduledAdhkar (ID: $id)");
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: '$icon $type Adhkar',
        body: 'Time for your $type adhkar reminders.',
        scheduledDate: scheduledAdhkar,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'adhkar_times_id',
            'Adhkar Notifications',
            channelDescription: 'Morning and Evening Adhkar reminders',
            importance: Importance.high,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
            showWhen: true,
            color: AppColors.primaryTeal,
            styleInformation: BigTextStyleInformation(
              'Time for your $type adhkar reminders. Remember Allah and find peace.',
              contentTitle: '$icon $type Adhkar',
            ),
            actions: <AndroidNotificationAction>[
              const AndroidNotificationAction(
                'read_adhkar',
                'Read Adhkar',
                showsUserInterface: true,
              ),
            ],
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
