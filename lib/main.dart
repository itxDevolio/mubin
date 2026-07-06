import 'package:mubin/core/constant/db_consts.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'core/theme/app_theme.dart';
import 'home/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.devolio.mubin.channel.audio',
    androidNotificationChannelName: 'Quran Audio',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',
  );

  await Hive.initFlutter();
  await Hive.openBox(DbConstants.appBox);
  await Hive.openBox(DbConstants.hadithBox);
  await Hive.openBox('adhkar_box');
  await Hive.openBox('tasbeeh_box');
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
