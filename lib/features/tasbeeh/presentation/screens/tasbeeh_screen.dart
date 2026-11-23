import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tasbeeh_provider.dart';
import '../widgets/real_tasbeeh_beads_widget.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class TasbeehScreen extends ConsumerWidget {
  final String dhikrId;
  final String dhikrTitle;

  const TasbeehScreen({
    super.key,
    required this.dhikrId,
    required this.dhikrTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(tasbeehProvider(dhikrId));
    final notifier = ref.read(tasbeehProvider(dhikrId).notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final bool isPashto = settings.language == 'ps';
    final bool isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu
              ? "تسبیح کاؤنٹر"
              : (isPashto ? "د تسبیح شمیرونکی" : "Tasbeeh Counter"),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              hapticFeedBack();
              notifier.reset();
            },
            tooltip: isUrdu
                ? 'ری سیٹ کریں'
                : (isPashto ? 'صفر کول' : 'Reset Count'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              hapticFeedBack();
              notifier.increment();
              if ((count + 1) > 0 && (count + 1) % 5 == 0) {
                AdHelper.showInterstitialWithLoading(context, onContinue: () {}, onSkip: () {});
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  const AdBannerWidget(),
                  const Spacer(flex: 1),

                  // Arabic Text Display (Dynamic & Elegant)
                  Hero(
                    tag: 'dhikr_$dhikrId',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        dhikrTitle,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 22,
                          color: AppColors.primaryTeal,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Modern Large Counter with Neon Glow effect
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.primaryTeal.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      "$count",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: constraints.maxWidth * 0.1,
                        color: isDark
                            ? Colors.white
                            : AppColors.textPrimaryLight,
                        letterSpacing: -2,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Animated Real Tasbeeh Beads Widget
                  RealTasbeehBeadsWidget(
                    count: count,
                    onTap: () {
                      hapticFeedBack();
                      notifier.increment();
                      if ((count + 1) > 0 && (count + 1) % 5 == 0) {
                        AdHelper.showInterstitialWithLoading(context, onContinue: () {}, onSkip: () {});
                      }
                    },
                  ),

                  const Spacer(flex: 2),

                  // Animated Instruction
                  _buildInstruction(isDark, isUrdu, isPashto, isRtl, fontFamily),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstruction(
    bool isDark,
    bool isUrdu,
    bool isPashto,
    bool isRtl,
    String fontFamily,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.touch_app_outlined,
          size: 16,
          color: isDark ? Colors.white38 : Colors.black38,
        ),
        const SizedBox(width: 8),
        Text(
          isUrdu
              ? "شمار کرنے کے لیے کہیں بھی ٹیپ کریں"
              : (isPashto
                  ? "د شمیرلو لپاره هرچیرې ټپ کړئ"
                  : "TAP ANYWHERE TO COUNT"),
          style: TextStyle(
            color: isDark ? Colors.white24 : Colors.black26,
            letterSpacing: isRtl ? 0 : 1.5,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 12 : 11,
            fontFamily: fontFamily,
          ),
        ),
      ],
    );
  }
}
