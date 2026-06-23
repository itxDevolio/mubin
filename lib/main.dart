import 'package:auraq/core/constant/db_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'core/theme/app_theme.dart';
import 'home/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.devolio.auraq.channel.audio',
    androidNotificationChannelName: 'Quran Audio',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',
  );

  await Hive.initFlutter();
  await Hive.openBox(DbConstants.appBox);
  await Hive.openBox(DbConstants.appBox);
  runApp(const ProviderScope(child: AuraqApp()));
}

class AuraqApp extends StatelessWidget {
  const AuraqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auraq',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
