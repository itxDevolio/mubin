import 'package:flutter_riverpod/legacy.dart';
import 'package:mubin/features/quran/domain/entities/reciter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/db_consts.dart';
import 'notification_service.dart';

class SettingsState {
  final String language;
  final Reciter currentReciter;
  final bool keepPlayingInBackground;
  final String madhab; // 'hanafi' or 'shafi'
  final ThemeMode themeMode;
  final String calculationMethod; 

  // Notification Settings
  final bool notificationsEnabled;
  final bool fajrNotification;
  final bool dhuhrNotification;
  final bool asrNotification;
  final bool maghribNotification;
  final bool ishaNotification;
  final bool morningAdhkarNotification;
  final bool eveningAdhkarNotification;
  
  // Custom Adhkar Times (Stored as "HH:mm")
  final String morningAdhkarTime;
  final String eveningAdhkarTime;

  SettingsState({
    this.language = 'en',
    Reciter? currentReciter,
    this.keepPlayingInBackground = false,
    this.madhab = 'hanafi',
    this.themeMode = ThemeMode.system,
    this.calculationMethod = 'karachi',
    this.notificationsEnabled = false,
    this.fajrNotification = true,
    this.dhuhrNotification = true,
    this.asrNotification = true,
    this.maghribNotification = true,
    this.ishaNotification = true,
    this.morningAdhkarNotification = true,
    this.eveningAdhkarNotification = true,
    this.morningAdhkarTime = '07:00',
    this.eveningAdhkarTime = '17:00',
  }) : currentReciter = currentReciter ?? availableReciters.first;

  SettingsState copyWith({
    String? language,
    Reciter? currentReciter,
    bool? keepPlayingInBackground,
    String? madhab,
    ThemeMode? themeMode,
    String? calculationMethod,
    bool? notificationsEnabled,
    bool? fajrNotification,
    bool? dhuhrNotification,
    bool? asrNotification,
    bool? maghribNotification,
    bool? ishaNotification,
    bool? morningAdhkarNotification,
    bool? eveningAdhkarNotification,
    String? morningAdhkarTime,
    String? eveningAdhkarTime,
  }) {
    return SettingsState(
      language: language ?? this.language,
      currentReciter: currentReciter ?? this.currentReciter,
      keepPlayingInBackground: keepPlayingInBackground ?? this.keepPlayingInBackground,
      madhab: madhab ?? this.madhab,
      themeMode: themeMode ?? this.themeMode,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      fajrNotification: fajrNotification ?? this.fajrNotification,
      dhuhrNotification: dhuhrNotification ?? this.dhuhrNotification,
      asrNotification: asrNotification ?? this.asrNotification,
      maghribNotification: maghribNotification ?? this.maghribNotification,
      ishaNotification: ishaNotification ?? this.ishaNotification,
      morningAdhkarNotification: morningAdhkarNotification ?? this.morningAdhkarNotification,
      eveningAdhkarNotification: eveningAdhkarNotification ?? this.eveningAdhkarNotification,
      morningAdhkarTime: morningAdhkarTime ?? this.morningAdhkarTime,
      eveningAdhkarTime: eveningAdhkarTime ?? this.eveningAdhkarTime,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final box = Hive.box(DbConstants.appBox);

    final String lang = box.get('language', defaultValue: 'en');
    final bool keepBg = box.get('keepPlayingInBackground', defaultValue: false);
    final String madhab = box.get('madhab', defaultValue: 'hanafi');
    final String calcMethod = box.get('calculationMethod', defaultValue: 'karachi');
    final String? reciterName = box.get('reciterName');
    final int themeIndex = box.get('themeMode', defaultValue: 0);
    
    // Notifications
    final bool notifEnabled = box.get('notificationsEnabled', defaultValue: false);
    final bool fajr = box.get('fajrNotification', defaultValue: true);
    final bool dhuhr = box.get('dhuhrNotification', defaultValue: true);
    final bool asr = box.get('asrNotification', defaultValue: true);
    final bool maghrib = box.get('maghribNotification', defaultValue: true);
    final bool isha = box.get('ishaNotification', defaultValue: true);
    final bool morningAdhkar = box.get('morningAdhkarNotification', defaultValue: true);
    final bool eveningAdhkar = box.get('eveningAdhkarNotification', defaultValue: true);
    
    final String morningTime = box.get('morningAdhkarTime', defaultValue: '07:00');
    final String eveningTime = box.get('eveningAdhkarTime', defaultValue: '17:00');

    final themeMode = ThemeMode.values[themeIndex];

    Reciter reciter = availableReciters.first;
    if (reciterName != null) {
      reciter = availableReciters.firstWhere(
            (r) => r.name == reciterName,
        orElse: () => availableReciters.first,
      );
    }

    state = state.copyWith(
      language: lang,
      currentReciter: reciter,
      keepPlayingInBackground: keepBg,
      madhab: madhab,
      themeMode: themeMode,
      calculationMethod: calcMethod,
      notificationsEnabled: notifEnabled,
      fajrNotification: fajr,
      dhuhrNotification: dhuhr,
      asrNotification: asr,
      maghribNotification: maghrib,
      ishaNotification: isha,
      morningAdhkarNotification: morningAdhkar,
      eveningAdhkarNotification: eveningAdhkar,
      morningAdhkarTime: morningTime,
      eveningAdhkarTime: eveningTime,
    );
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      // Request permissions only when user tries to enable
      final status = await Permission.notification.request();
      await Permission.scheduleExactAlarm.request();
      
      if (status.isDenied) {
        return;
      }
    }

    final box = Hive.box(DbConstants.appBox);
    await box.put('notificationsEnabled', value);
    
    state = state.copyWith(notificationsEnabled: value);
    
    NotificationService().scheduleAllNotifications();
  }

  Future<void> updateNotificationSetting(String key, bool value) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put(key, value);
    
    switch(key) {
      case 'fajrNotification': state = state.copyWith(fajrNotification: value); break;
      case 'dhuhrNotification': state = state.copyWith(dhuhrNotification: value); break;
      case 'asrNotification': state = state.copyWith(asrNotification: value); break;
      case 'maghribNotification': state = state.copyWith(maghribNotification: value); break;
      case 'ishaNotification': state = state.copyWith(ishaNotification: value); break;
      case 'morningAdhkarNotification': state = state.copyWith(morningAdhkarNotification: value); break;
      case 'eveningAdhkarNotification': state = state.copyWith(eveningAdhkarNotification: value); break;
    }
    
    NotificationService().scheduleAllNotifications();
  }
  
  Future<void> setAdhkarTime(String key, TimeOfDay time) async {
    final box = Hive.box(DbConstants.appBox);
    final timeStr = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    await box.put(key, timeStr);
    
    if (key == 'morningAdhkarTime') {
      state = state.copyWith(morningAdhkarTime: timeStr);
    } else {
      state = state.copyWith(eveningAdhkarTime: timeStr);
    }
    
    NotificationService().scheduleAllNotifications();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('themeMode', mode.index);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLanguage(String lang) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('language', lang);
    state = state.copyWith(language: lang);
  }

  Future<void> setMadhab(String madhab) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('madhab', madhab);
    state = state.copyWith(madhab: madhab);
    NotificationService().scheduleAllNotifications();
  }

  Future<void> setCalculationMethod(String method) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('calculationMethod', method);
    state = state.copyWith(calculationMethod: method);
    NotificationService().scheduleAllNotifications();
  }

  Future<void> setReciter(Reciter reciter) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('reciterName', reciter.name);
    state = state.copyWith(currentReciter: reciter);
  }

  Future<void> setKeepPlayingInBackground(bool value) async {
    final box = Hive.box(DbConstants.appBox);
    await box.put('keepPlayingInBackground', value);
    state = state.copyWith(keepPlayingInBackground: value);
  }
}

final settingsControllerProvider =
StateNotifierProvider<SettingsController, SettingsState>(
      (ref) => SettingsController(),
);

// Helper to get CalculationParameters from string
CalculationParameters getCalculationParams(String methodKey, Madhab madhab) {
  switch (methodKey) {
    case 'karachi':
      return CalculationParameters(
        method: CalculationMethod.karachi,
        fajrAngle: 18.0,
        ishaAngle: 18.0,
        madhab: madhab,
      );
    case 'ummAlQura':
      return CalculationParameters(
        method: CalculationMethod.ummAlQura,
        fajrAngle: 18.5,
        ishaAngle: 0.0,
        ishaInterval: 90,
        madhab: madhab,
      );
    case 'muslimWorldLeague':
      return CalculationParameters(
        method: CalculationMethod.muslimWorldLeague,
        fajrAngle: 18.0,
        ishaAngle: 17.0,
        madhab: madhab,
      );
    case 'egyptian':
      return CalculationParameters(
        method: CalculationMethod.egyptian,
        fajrAngle: 19.5,
        ishaAngle: 17.5,
        madhab: madhab,
      );
    case 'northAmerica':
      return CalculationParameters(
        method: CalculationMethod.northAmerica,
        fajrAngle: 15.0,
        ishaAngle: 15.0,
        madhab: madhab,
      );
    case 'dubai':
      return CalculationParameters(
        method: CalculationMethod.dubai,
        fajrAngle: 18.2,
        ishaAngle: 18.2,
        madhab: madhab,
      );
    case 'kuwait':
      return CalculationParameters(
        method: CalculationMethod.kuwait,
        fajrAngle: 18.0,
        ishaAngle: 17.5,
        madhab: madhab,
      );
    case 'qatar':
      return CalculationParameters(
        method: CalculationMethod.qatar,
        fajrAngle: 18.0,
        ishaAngle: 0.0,
        ishaInterval: 90,
        madhab: madhab,
      );
    case 'singapore':
      return CalculationParameters(
        method: CalculationMethod.singapore,
        fajrAngle: 20.0,
        ishaAngle: 18.0,
        madhab: madhab,
      );
    case 'turkey':
      return CalculationParameters(
        method: CalculationMethod.turkiye,
        fajrAngle: 18.0,
        ishaAngle: 17.0,
        madhab: madhab,
      );
    default:
      return CalculationParameters(
        method: CalculationMethod.karachi,
        fajrAngle: 18.0,
        ishaAngle: 18.0,
        madhab: madhab,
      );
  }
}

final List<Map<String, String>> calculationMethods = [
  {'key': 'karachi', 'name': 'University of Islamic Sciences, Karachi'},
  {'key': 'ummAlQura', 'name': 'Umm al-Qura University, Makkah'},
  {'key': 'muslimWorldLeague', 'name': 'Muslim World League'},
  {'key': 'egyptian', 'name': 'Egyptian General Authority of Survey'},
  {'key': 'northAmerica', 'name': 'Islamic Society of North America (ISNA)'},
  {'key': 'dubai', 'name': 'Dubai'},
  {'key': 'kuwait', 'name': 'Kuwait'},
  {'key': 'qatar', 'name': 'Qatar'},
  {'key': 'singapore', 'name': 'Singapore'},
  {'key': 'turkey', 'name': 'Turkey'},
];
