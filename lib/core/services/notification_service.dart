import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:hive/hive.dart';
import '../constant/db_consts.dart';
import '../../home/service/prayer_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tzdata.initializeTimeZones();
    
    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');

    await _notificationsPlugin.initialize(
      settings: InitializationSettings(android: androidInit),
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    // Create channels
    const prayerChannel = AndroidNotificationChannel(
      'prayer_times_id',
      'Prayer Notifications',
      description: 'Notifications for Salah times',
      importance: Importance.max,
      playSound: true,
    );

    const adhkarChannel = AndroidNotificationChannel(
      'adhkar_times_id',
      'Adhkar Notifications',
      description: 'Morning and Evening Adhkar reminders',
      importance: Importance.high,
      playSound: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(prayerChannel);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(adhkarChannel);
  }

  Future<void> scheduleAllNotifications() async {
    await _notificationsPlugin.cancelAll();

    final box = Hive.box(DbConstants.appBox);
    final bool enabled = box.get('notificationsEnabled', defaultValue: false);
    if (!enabled) return;

    final double? lat = box.get('lat');
    final double? lng = box.get('lng');
    final String madhabStr = box.get('madhab', defaultValue: 'hanafi');
    final String methodKey = box.get('calculationMethod', defaultValue: 'karachi');
    final bool isHanafi = madhabStr == 'hanafi';

    if (lat == null || lng == null) return;

    final prayerService = PrayerService();
    final now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final scheduleDate = now.add(Duration(days: i));
      final prayerTimes = await prayerService.getPrayerTime(
        lat, lng, isHanafi, date: scheduleDate, methodKey: methodKey
      );
      
      await _scheduleDayPrayers(i, prayerTimes, box, scheduleDate);
    }
  }

  Future<void> _scheduleDayPrayers(int dayOffset, PrayerTimes prayerTimes, Box box, DateTime date) async {
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
    
    final bool adhkarEnabled = box.get('adhkarNotification', defaultValue: true);
    final String morningTimeStr = box.get('morningAdhkarTime', defaultValue: '07:00');
    final String eveningTimeStr = box.get('eveningAdhkarTime', defaultValue: '17:00');

    int index = 0;
    for (var entry in times.entries) {
      final name = entry.key;
      final time = entry.value;
      if (time == null) continue;

      final bool isPrayerEnabled = settings[name] ?? true;

      if (isPrayerEnabled) {
        final scheduledTime = tz.TZDateTime.from(time, tz.local);
        if (scheduledTime.isAfter(tz.TZDateTime.now(tz.local))) {
          final id = (dayOffset * 10) + index;
          await _notificationsPlugin.zonedSchedule(
            id: id,
            title: '🕌 Salah Time: $name',
            body: 'It is time for $name prayer. Don\'t miss your reward!',
            scheduledDate: scheduledTime,
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'prayer_times_id',
                'Prayer Notifications',
                importance: Importance.max,
                priority: Priority.high,
                fullScreenIntent: true,
                category: AndroidNotificationCategory.alarm,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }
      }
      index++;
    }

    // Schedule Adhkar at custom times
    if (adhkarEnabled) {
      _scheduleAdhkar(dayOffset, date, morningTimeStr, 'Morning', 100, box);
      _scheduleAdhkar(dayOffset, date, eveningTimeStr, 'Evening', 200, box);
    }
  }

  Future<void> _scheduleAdhkar(int dayOffset, DateTime date, String timeStr, String type, int baseId, Box box) async {
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    
    final adhkarDateTime = DateTime(date.year, date.month, date.day, hour, minute);
    final scheduledAdhkar = tz.TZDateTime.from(adhkarDateTime, tz.local);
    
    if (scheduledAdhkar.isAfter(tz.TZDateTime.now(tz.local))) {
      final id = baseId + dayOffset;
      final icon = type == 'Morning' ? '☀️' : '🌙';
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: '$icon $type Adhkar',
        body: 'Time for your $type adhkar reminders.',
        scheduledDate: scheduledAdhkar,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'adhkar_times_id',
            'Adhkar Notifications',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
