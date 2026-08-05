import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mubin/features/adhkar/data/models/adhkar_constants.dart';
import 'package:mubin/features/adhkar/presentation/screens/adhkar_list_screen.dart';
import 'package:mubin/main.dart';
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

    // ✅ Using ic_launcher for better compatibility across devices as small icon
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
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
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload == null || navigatorKey.currentState == null) return;

        if (payload == 'prayer') {
          // Home screen is the default, so we just pop to it or do nothing if already there
          navigatorKey.currentState?.popUntil((route) => route.isFirst);
        } else if (payload == 'adhkar_morning') {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => AdhkarListScreen(
                dhikrList: AdhkarConstants.morningAdhkar,
                title: 'Morning Adhkar',
              ),
            ),
          );
        } else if (payload == 'adhkar_evening') {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => AdhkarListScreen(
                dhikrList: AdhkarConstants.eveningAdhkar,
                title: 'Evening Adhkar',
              ),
            ),
          );
        }
      },
    );

    // ✅ FIXED: Using v3 ID for improved device compatibility and banner visibility
    const prayerChannel = AndroidNotificationChannel(
      'mubin_prayer_v3',
      'Prayer Notifications',
      description: 'Salah time alerts with Adhan sound',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('adhan_sound'),
      audioAttributesUsage: AudioAttributesUsage.alarm,
      enableVibration: true,
      showBadge: true,
    );

    const adhkarChannel = AndroidNotificationChannel(
      'mubin_adhkar_v2',
      'Adhkar Reminders',
      description: 'Morning and Evening Adhkar notifications',
      importance: Importance.max,
      // Max importance for head-up display (banner)
      playSound: true,
      enableVibration: true,
      showBadge: true,
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

    // Request necessary permissions for scheduling notifications
    final status = await Permission.notification.status;
    if (status.isDenied || status.isLimited) {
      await Permission.notification.request();
    }

    // Request necessary permissions for scheduling exact alarms (Android 12+)
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

    // Request battery optimization exemption for reliability
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }

    // Safety: Ensure Timezone is correctly set
    try {
      if (tz.local.name == 'UTC') {
        // Fallback to Karachi if timezone is not set,
        // ideally this should be set to the user's actual timezone in init()
        tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
      }
    } catch (_) {}

    double? lat = box.get('lat');
    double? lng = box.get('lng');

    // If location is missing, try to fetch it to avoid returning early
    if (lat == null || lng == null) {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: const Duration(seconds: 5),
        );
        lat = position.latitude;
        lng = position.longitude;
        await box.put('lat', lat);
        await box.put('lng', lng);
      } catch (e) {
        debugPrint("Location not available for scheduling: $e");
        return;
      }
    }

    final prayerService = PrayerService();
    final now = DateTime.now();
    final isHanafi = box.get('madhab', defaultValue: 'hanafi') == 'hanafi';
    final methodKey = box.get('calculationMethod', defaultValue: 'karachi');

    // Schedule for 10 days to ensure notifications keep coming even if app isn't opened
    for (int i = 0; i < 10; i++) {
      final scheduleDate = now.add(Duration(days: i));
      final prayerTimes = await prayerService.getPrayerTime(
        lat,
        lng,
        isHanafi,
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

      final bool isEnabled = box.get(
        '${name.toLowerCase()}Notification',
        defaultValue: true,
      );
      if (!isEnabled) continue;

      final scheduledTime = tz.TZDateTime.from(time, tz.local);
      final nowTime = tz.TZDateTime.now(tz.local);

      if (scheduledTime.isAfter(nowTime)) {
        final id = (dayOffset * 100) + i;

        try {
          await _notificationsPlugin.zonedSchedule(
            id: id,
            title: name,
            body: 'Success is in Salah',
            payload: 'prayer',
            scheduledDate: scheduledTime,
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                'mubin_prayer_v3',
                'Prayer Notifications',
                importance: Importance.max,
                priority: Priority.max,
                sound: const RawResourceAndroidNotificationSound('adhan_sound'),
                fullScreenIntent: true,
                category: AndroidNotificationCategory.alarm,
                color: AppColors.primaryTeal,
                visibility: NotificationVisibility.public,
                ticker: 'Prayer Reminder: $name',
                icon: 'ic_launcher_foreground',
                largeIcon: const DrawableResourceAndroidBitmap(
                  '@mipmap/launcher_icon',
                ),
                styleInformation: BigTextStyleInformation(
                  'It is time for $name prayer. "Indeed, prayer has been decreed upon the believers at specified times." (4:103)',
                  contentTitle: name,
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
        } catch (e) {
          // Fallback if custom sound fails
          await _notificationsPlugin.zonedSchedule(
            id: id,
            title: name,
            body: 'Success is in Salah',
            payload: 'prayer',
            scheduledDate: scheduledTime,
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'mubin_prayer_v3',
                'Prayer Notifications',
                importance: Importance.max,
                priority: Priority.max,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
          debugPrint("Error scheduling notification with sound: $e");
        }
      }
    }

    // Schedule Adhkar Reminders
    if (box.get('morningAdhkarNotification', defaultValue: true)) {
      await _scheduleAdhkar(
        dayOffset,
        date,
        box.get('morningAdhkarTime', defaultValue: '07:00'),
        'Morning',
        50,
      );
    }
    if (box.get('eveningAdhkarNotification', defaultValue: true)) {
      await _scheduleAdhkar(
        dayOffset,
        date,
        box.get('eveningAdhkarTime', defaultValue: '17:00'),
        'Evening',
        60,
      );
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
    final adhkarDt = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
    final scheduledDate = tz.TZDateTime.from(adhkarDt, tz.local);

    if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await _notificationsPlugin.zonedSchedule(
        id: (dayOffset * 100) + subId,
        title: '$type Adhkar',
        body: 'Stay connected with your Creator',
        payload: type == 'Morning' ? 'adhkar_morning' : 'adhkar_evening',
        scheduledDate: scheduledDate,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'mubin_adhkar_v2',
            'Adhkar Reminders',
            importance: Importance.max,
            priority: Priority.max,
            color: AppColors.primaryTeal,
            visibility: NotificationVisibility.public,
            ticker: '$type Adhkar Reminder',
            icon: 'ic_launcher_foreground',
            largeIcon: const DrawableResourceAndroidBitmap(
              '@mipmap/launcher_icon',
            ),
            styleInformation: BigTextStyleInformation(
              'Take a moment for your $type adhkar and find peace in remembrance.',
              contentTitle: '$type Adhkar',
            ),
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
