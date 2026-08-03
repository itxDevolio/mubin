import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  int _messageIndex = 0;

  final List<String> _loadingMessages = [
    "Initializing Mubin",
    "Preparing prayer times",
    "Syncing daily adhkar",
    "Calibrating qibla direction",
    "Setting up notifications",
    "Almost ready",
  ];

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() async {
    // Small delay so the fade-in feels intentional, not instant
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) setState(() => _visible = true);

    // Cycle through messages so the loading state never feels empty
    for (int i = 1; i < _loadingMessages.length; i++) {
      await Future.delayed(const Duration(milliseconds: 900));
      if (mounted) setState(() => _messageIndex = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOut,
          opacity: _visible ? 1.0 : 0.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo — simple, no scaling gimmicks
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/app_logos/mubin_app_logo.png',
                  height: 88,
                  width: 88,
                ),
              ),

              const SizedBox(height: 24),

              // Wordmark — tighter, more natural letter-spacing
              Text(
                "MUBIN",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 6,
                  color: isDark ? Colors.white : AppColors.primaryTeal,
                  fontFamily: 'Poppins',
                ),
              ),

              const SizedBox(height: 6),

              // Animated cycling loading message — keeps the screen feeling alive
              SizedBox(
                height: 20,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _loadingMessages[_messageIndex].toUpperCase(),
                    key: ValueKey(_messageIndex),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Minimal loader
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: isDark ? Colors.white38 : AppColors.primaryTeal.withOpacity(0.5),
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}