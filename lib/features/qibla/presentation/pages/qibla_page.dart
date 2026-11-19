import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../widgets/qibla_compass_widget.dart';
import '../controller/qibla_controller.dart';
import '../../domain/entities/qibla_state.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class QiblaPage extends ConsumerWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final qiblaState = ref.watch(qiblaProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;

    final double offset = qiblaState.offset;
    final bool turnRight = offset <= 180;
    final double displayDegrees = turnRight ? offset : 360 - offset;

    // Dynamic theme-aware colors derived from AppColors
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final primaryColor = isDarkMode ? AppColors.lightTeal : AppColors.primaryTeal;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          isUrdu
              ? 'قبلہ نما'
              : (isPashto ? 'د قبله موندونکی' : 'Qibla Finder'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
            fontSize: isRtl ? 16 : 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            onPressed: () => _showCalibrationDialog(context, isDarkMode, isUrdu, isPashto, isRtl),
            icon: Icon(Icons.info_outline, color: AppColors.accentGold),
            tooltip: isUrdu
                ? 'کیलिब्रেশন گائیڈ'
                : (isPashto ? 'د سینسر تنظیم لارښود' : 'Calibration Guide'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: qdataLoadingCheck(qiblaState, isDarkMode, textColor, textSecondaryColor, primaryColor, displayDegrees, turnRight, isUrdu, isPashto, isRtl),
          ),
        ),
      ),
    );
  }

  Widget qdataLoadingCheck(
    QiblaState qiblaState,
    bool isDarkMode,
    Color textColor,
    Color textSecondaryColor,
    Color primaryColor,
    double displayDegrees,
    bool turnRight,
    bool isUrdu,
    bool isPashto,
    bool isRtl,
  ) {
    if (qiblaState.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
            const SizedBox(height: 24),
            Text(
              isUrdu
                  ? 'مقام حاصل کیا جا رہا ہے...'
                  : (isPashto ? 'ځای ترلاسه کیږي...' : 'Fetching Precise Location...'),
              style: TextStyle(
                color: textSecondaryColor,
                fontSize: isRtl ? 12 : 14,
                fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      );
    }

    final turnText = isUrdu
        ? "درستگی کے لیے ${displayDegrees.toStringAsFixed(0)}° ${turnRight ? 'دائیں' : 'بائیں'} گھمائیں۔"
        : (isPashto
            ? "د دقیقوالي لپاره ${displayDegrees.toStringAsFixed(0)}° ${turnRight ? 'ښي' : 'چپ'} ته وګرځوئ."
            : "Turn ${displayDegrees.toStringAsFixed(0)}° ${turnRight ? 'right' : 'left'} for precision.");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // Minimal Dynamic Info Box with AppColors Integration
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: qiblaState.isAligned
                  ? AppColors.success.withValues(alpha: isDarkMode ? 0.15 : 0.08)
                  : primaryColor.withValues(alpha: isDarkMode ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: qiblaState.isAligned
                    ? AppColors.success.withValues(alpha: 0.3)
                    : primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Icon(
                  qiblaState.isAligned ? Icons.check_circle_outline : Icons.explore_outlined,
                  color: qiblaState.isAligned ? AppColors.success : primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    qiblaState.isAligned
                        ? (isUrdu
                            ? "بہترین سمت حاصل ہو گئی ہے۔"
                            : (isPashto ? "پوره سمت ترلاسه شو." : "Perfect alignment achieved."))
                        : turnText,
                    style: TextStyle(
                      fontSize: isRtl ? 12 : 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: isRtl ? 'NotoNastaliqUrdu' : "Poppins",
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: QiblaCompassWidget(),
          ),
          // Minimal Footer
          Opacity(
            opacity: 0.6,
            child: Column(
              children: [
                Text(
                  isUrdu
                      ? "مکہ مکرمہ کے مختصات"
                      : (isPashto ? "د مکه مکرمه مختصات" : "MECCA COORDINATES"),
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: isRtl ? 9 : 8,
                    fontWeight: FontWeight.w900,
                    fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: AppColors.accentGold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "21.4225° N, 39.8262° E",
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const AdBannerWidget(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showCalibrationDialog(BuildContext context, bool isDarkMode, bool isUrdu, bool isPashto, bool isRtl) {
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final primaryColor = isDarkMode ? AppColors.lightTeal : AppColors.primaryTeal;

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: surfaceColor,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.vibration, size: 48, color: AppColors.accentGold),
                const SizedBox(height: 24),
                Text(
                  isUrdu
                      ? "سینسر کیلیبریشن"
                      : (isPashto ? "د سینسر تنظیم" : "Sensor Calibration"),
                  style: TextStyle(
                    fontSize: isRtl ? 16 : 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isUrdu
                      ? "درستگی کو یقینی بنانے کے لیے، براہ کرم اپنے فون کو '8' کی شکل میں حرکت دیں۔"
                      : (isPashto
                          ? "د دقیقوالي د ډاډ لپاره، مهرباني وکړئ خپل تلیفون د '8' په شکل کې وخوځوئ."
                          : "To ensure pinpoint accuracy, please move your phone in a 'Figure 8' motion. This helps reset the internal magnetic sensors."),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isRtl ? 13 : 14,
                    height: 1.5,
                    fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                    color: textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.4), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(Icons.loop, size: 24, color: AppColors.accentGold),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      isUrdu ? "سمجھ گئے" : (isPashto ? "پوه شوم" : "Got it"),
                      style: TextStyle(
                        fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
