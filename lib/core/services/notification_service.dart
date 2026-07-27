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
    settings:   const InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      ),
    );

    // ✅ FIXED: New IDs ensure Android refreshes channel settings (Sound/Importance)
    const prayerChannel = AndroidNotificationChannel(
      'mubin_prayer_v1', 
      'Prayer Notifications',
      description: 'Salah time alerts with Adhan sound',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('adhan_sound'),
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );

    const adhkarChannel = AndroidNotificationChannel(
      'mubin_adhkar_v1',
      'Adhkar Reminders',
      description: 'Morning and Evening Adhkar notifications',
      importance: Importance.high,
      playSound: true,
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
    final box = Hive.box(DbConstants.appBox);
    final bool enabled = box.get('notificationsEnabled', defaultValue: false);

    // Cancel all existing to prevent ghost notifications or overlaps
    await _notificationsPlugin.cancelAll();

    if (!enabled) return;

    // Safety: Ensure Timezone is correctly set
    try {
      if (tz.local.name == 'UTC') {
        tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
      }
    } catch (_) {}

    // Request necessary permissions for scheduling exact alarms
    await Permission.notification.request();
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
    
    // Request battery optimization exemption for reliability
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }

    final double? lat = box.get('lat');
    final double? lng = box.get('lng');
    if (lat == null || lng == null) return;

    final prayerService = PrayerService();
    final now = DateTime.now();
    final isHanafi = box.get('madhab', defaultValue: 'hanafi') == 'hanafi';
    final methodKey = box.get('calculationMethod', defaultValue: 'karachi');

    // Schedule for 10 days to ensure notifications keep coming even if app isn't opened
    for (int i = 0; i < 10; i++) {
      final scheduleDate = now.add(Duration(days: i));
      final prayerTimes = await prayerService.getPrayerTime(
        lat, lng, isHanafi,
        date: scheduleDate,
        methodKey: methodKey,
      );

      await _schedulePrayersForDay(i, prayerTimes, box, scheduleDate);
    }
  }

  Future<void> _schedulePrayersForDay(
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

    final List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    for (int i = 0; i < prayers.length; i++) {
      final name = prayers[i];
      final time = times[name];
      if (time == null) continue;

      final bool isEnabled = box.get('${name.toLowerCase()}Notification', defaultValue: true);
      if (!isEnabled) continue;

      final scheduledTime = tz.TZDateTime.from(time, tz.local);
      final nowTime = tz.TZDateTime.now(tz.local);

      if (scheduledTime.isAfter(nowTime)) {
        final id = (dayOffset * 100) + i;
        
        await _notificationsPlugin.zonedSchedule(
          id: id,
          title: '🕌 Salah Time: $name',
          body: 'It is time for $name prayer. Success is in Salah.',
          scheduledDate: scheduledTime,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              'mubin_prayer_v1',
              'Prayer Notifications',
              importance: Importance.max,
              priority: Priority.max,
              sound: const RawResourceAndroidNotificationSound('adhan_sound'),
              fullScreenIntent: true,
              category: AndroidNotificationCategory.alarm,
              color: AppColors.primaryTeal,
              visibility: NotificationVisibility.public,
              styleInformation: BigTextStyleInformation(
                'It is time for $name prayer. "Indeed, prayer has been decreed upon the believers a decree of specified times." (4:103)',
                contentTitle: '🕌 Salah Time: $name',
              ),
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: 'adhan_sound.m4a',
              interruptionLevel: InterruptionLevel.critical,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        );
      }
    }

    // Schedule Adhkar Reminders
    if (box.get('morningAdhkarNotification', defaultValue: true)) {
      await _scheduleAdhkar(dayOffset, date, box.get('morningAdhkarTime', defaultValue: '07:00'), 'Morning', 50);
    }
    if (box.get('eveningAdhkarNotification', defaultValue: true)) {
      await _scheduleAdhkar(dayOffset, date, box.get('eveningAdhkarTime', defaultValue: '17:00'), 'Evening', 60);
    }
  }

  Future<void> _scheduleAdhkar(
    int dayOffset,
    DateTime date,
    String timeStr,
    String type,
    int subId,
  ) async {
    final parts = timeStr.split(':');
    final adhkarDt = DateTime(date.year, date.month, date.day, int.parse(parts[0]), int.parse(parts[1]));
    final scheduledDate = tz.TZDateTime.from(adhkarDt, tz.local);

    if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await _notificationsPlugin.zonedSchedule(
        id: (dayOffset * 100) + subId,
        title: '${type == 'Morning' ? '☀️' : '🌙'} $type Adhkar',
        body: 'Time for your $type adhkar reminders.',
        scheduledDate: scheduledDate,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'mubin_adhkar_v1',
            'Adhkar Reminders',
            importance: Importance.high,
            priority: Priority.high,
            color: AppColors.primaryTeal,
            visibility: NotificationVisibility.public,
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
