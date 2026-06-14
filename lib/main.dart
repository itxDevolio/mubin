import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'home/ui/screens/home_screen.dart';

void main() {
  // ProviderScope is mandatory for Riverpod
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
