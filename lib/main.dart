import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_screen.dart';

void main() {
  runApp(const AuraqApp());
}

class AuraqApp extends StatelessWidget {
  const AuraqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auraq',
      debugShowCheckedModeBanner: false,

      // Professional Theme Setup
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: ThemeMode.system,

      // Auto-switch based on phone settings
      home: HomeScreen(),
    );
  }
}
