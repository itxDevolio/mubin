import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// TODO: Update these imports to match your project directory structure
import '../../../../core/app_colors.dart';
import '../widgets/qibla_compass_widget.dart';
import '../controller/qibla_controller.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class QiblaPage extends ConsumerWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final qiblaState = ref.watch(qiblaProvider);

    final double offset = qiblaState.offset;
    final bool turnRight = offset <= 180;
    final double displayDegrees = turnRight ? offset : 360 - offset;

    // Dynamic theme-aware colors derived from AppColors
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final primaryColor = isDarkMode ? AppColors.lightTeal : AppColors.primaryTeal;
    final textColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Qibla Finder",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            onPressed: () => _showCalibrationDialog(context, isDarkMode),
            icon: Icon(Icons.info_outline, color: AppColors.accentGold),
            tooltip: "Calibration Guide",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: qiblaState.isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                const SizedBox(height: 24),
                Text(
                  "Fetching Precise Location...",
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          )
              : Padding(
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
                        ? AppColors.success.withOpacity(isDarkMode ? 0.15 : 0.08)
                        : primaryColor.withOpacity(isDarkMode ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: qiblaState.isAligned
                          ? AppColors.success.withOpacity(0.3)
                          : primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
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
                              ? "Perfect alignment achieved."
                              : "Turn ${displayDegrees.toStringAsFixed(0)}° ${turnRight ? 'right' : 'left'} for precision.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
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
                        "MECCA COORDINATES",
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
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
          ),
        ),
      ),
    );
  }

  void _showCalibrationDialog(BuildContext context, bool isDarkMode) {
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final primaryColor = isDarkMode ? AppColors.lightTeal : AppColors.primaryTeal;

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                "Sensor Calibration",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "To ensure pinpoint accuracy, please move your phone in a 'Figure 8' motion. This helps reset the internal magnetic sensors.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: textSecondaryColor,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.accentGold.withOpacity(0.4), width: 2),
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
                  child: const Text("Got it"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}