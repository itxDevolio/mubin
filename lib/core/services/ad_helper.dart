import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_colors.dart';

class AdHelper {
  static const String _admobInterstitialAndroid = 'ca-app-pub-5751989678728366/1280518889';
  static const String _admobInterstitialIos = 'ca-app-pub-5751989678728366/1280518889';

  static String get interstitialAdUnitId =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? _admobInterstitialIos
          : _admobInterstitialAndroid;

  // Show Interstitial ad with a 10-second full-screen loading counter dialog
  static void showInterstitialWithLoading(
    BuildContext context, {
    required VoidCallback onContinue,
    required VoidCallback onSkip,
  }) {
    bool adHandled = false;
    int secondsRemaining = 10;
    Timer? countdownTimer;
    BuildContext? dialogContext;
    InterstitialAd? interstitialAd;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        return StatefulBuilder(
          builder: (context, setStateModal) {
            if (countdownTimer == null) {
              countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
                if (secondsRemaining > 1) {
                  secondsRemaining--;
                  if (context.mounted) {
                    setStateModal(() {});
                  }
                } else {
                  timer.cancel();
                  if (!adHandled) {
                    adHandled = true;
                    if (dialogContext != null && Navigator.canPop(dialogContext!)) {
                      Navigator.pop(dialogContext!);
                    }
                    interstitialAd?.dispose();
                    onContinue();
                  }
                }
              });
            }

            final isDark = Theme.of(context).brightness == Brightness.dark;
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryTeal,
                        strokeWidth: 3.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Loading Advertisement...",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Please wait while ad loads\nContinuing in 00:${secondsRemaining.toString().padLeft(2, '0')}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    countdownTimer?.cancel();
                    if (!adHandled) {
                      adHandled = true;
                      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
                        Navigator.pop(dialogContext!);
                      }
                      interstitialAd?.dispose();
                      onSkip();
                    }
                  },
                  child: const Text("Skip", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          if (adHandled) {
            ad.dispose();
            return;
          }
          adHandled = true;
          countdownTimer?.cancel();
          if (dialogContext != null && Navigator.canPop(dialogContext!)) {
            Navigator.pop(dialogContext!);
          }

          interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              onContinue();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
              onContinue();
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (adHandled) return;
          adHandled = true;
          countdownTimer?.cancel();
          debugPrint('InterstitialAd failed to load: $error');
          if (dialogContext != null && Navigator.canPop(dialogContext!)) {
            Navigator.pop(dialogContext!);
          }
          onContinue();
        },
      ),
    );
  }

  // Surah/Juz ad: every 5th open, max 5 per day
  static Future<void> maybeShowSurahJuzAd(
    BuildContext context, {
    required VoidCallback onContinue,
    required VoidCallback onSkip,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int surahOpens = prefs.getInt('surah_open_count') ?? 0;
      surahOpens++;
      await prefs.setInt('surah_open_count', surahOpens);

      final todayStr = DateTime.now().toIso8601String().split('T')[0];
      final lastDate = prefs.getString('surah_juz_ad_date') ?? '';
      int dailyCount = prefs.getInt('surah_juz_ad_count') ?? 0;

      if (lastDate != todayStr) {
        dailyCount = 0;
        await prefs.setString('surah_juz_ad_date', todayStr);
      }

      if (surahOpens % 5 == 0 && dailyCount < 5) {
        dailyCount++;
        await prefs.setInt('surah_juz_ad_count', dailyCount);
        showInterstitialWithLoading(context, onContinue: onContinue, onSkip: onSkip);
        return;
      }
    } catch (e) {
      debugPrint('Error showing Surah/Juz ad: $e');
    }
    onContinue();
  }

  // Khatam ad: every 5th open
  static Future<void> maybeShowKhatamAd(
    BuildContext context, {
    required VoidCallback onContinue,
    required VoidCallback onSkip,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int khatamOpens = prefs.getInt('khatam_open_count') ?? 0;
      khatamOpens++;
      await prefs.setInt('khatam_open_count', khatamOpens);

      if (khatamOpens % 5 == 0) {
        showInterstitialWithLoading(context, onContinue: onContinue, onSkip: onSkip);
        return;
      }
    } catch (e) {
      debugPrint('Error showing Khatam ad: $e');
    }
    onContinue();
  }

  // Qibla ad: every 5th open
  static Future<void> maybeShowQiblaAd(
    BuildContext context, {
    required VoidCallback onContinue,
    required VoidCallback onSkip,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int qiblaOpens = prefs.getInt('qibla_open_count') ?? 0;
      qiblaOpens++;
      await prefs.setInt('qibla_open_count', qiblaOpens);

      if (qiblaOpens % 5 == 0) {
        showInterstitialWithLoading(context, onContinue: onContinue, onSkip: onSkip);
        return;
      }
    } catch (e) {
      debugPrint('Error showing Qibla ad: $e');
    }
    onContinue();
  }

  // Guide / Funeral / Istikhara ad: every 3rd open
  static Future<void> maybeShowGuideAd(
    BuildContext context, {
    required VoidCallback onContinue,
    required VoidCallback onSkip,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int guideOpens = prefs.getInt('guide_open_count') ?? 0;
      guideOpens++;
      await prefs.setInt('guide_open_count', guideOpens);

      if (guideOpens % 3 == 0) {
        showInterstitialWithLoading(context, onContinue: onContinue, onSkip: onSkip);
        return;
      }
    } catch (e) {
      debugPrint('Error showing Guide ad: $e');
    }
    onContinue();
  }
}
