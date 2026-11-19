import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/guide_step.dart';

class GuideStepWidget extends ConsumerWidget {
  final GuideStep step;
  final bool isUrdu; // kept for backwards compatibility or override

  const GuideStepWidget({
    super.key,
    required this.step,
    this.isUrdu = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settings = ref.watch(settingsControllerProvider);
    final isUrduLang = settings.language == 'ur';
    final isPashtoLang = settings.language == 'ps';
    final isRtl = isUrdu || isUrduLang || isPashtoLang;

    final title = isPashtoLang && step.titlePs.isNotEmpty
        ? step.titlePs
        : (isRtl ? step.titleUr : step.titleEn);

    final content = isPashtoLang && step.contentPs.isNotEmpty
        ? step.contentPs
        : (isRtl ? step.contentUr : step.contentEn);

    final translation = isPashtoLang && step.translationPs?.isNotEmpty == true
        ? step.translationPs!
        : (isRtl ? step.translationUr : step.translationEn);

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment:
            isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            children: [
              _buildStepCircle(step.stepNumber),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  textAlign: isRtl ? TextAlign.right : TextAlign.left,
                  style: isRtl
                      ? const TextStyle(
                          fontFamily: 'NotoNastaliqUrdu',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        )
                      : const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Step Content with Vertical Line
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                left: !isRtl
                    ? BorderSide(
                        color: AppColors.primaryTeal.withValues(alpha: 0.15),
                        width: 1.5,
                      )
                    : BorderSide.none,
                right: isRtl
                    ? BorderSide(
                        color: AppColors.primaryTeal.withValues(alpha: 0.15),
                        width: 1.5,
                      )
                    : BorderSide.none,
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Instructions
                Text(
                  content,
                  textAlign: isRtl ? TextAlign.right : TextAlign.left,
                  style: isRtl
                      ? TextStyle(
                          fontFamily: 'NotoNastaliqUrdu',
                          fontSize: 15,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 2.3,
                        )
                      : TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.7,
                        ),
                ),

                // Arabic Prayer Card
                if (step.arabic != null) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? Colors.white10
                            : Colors.black.withValues(alpha: 0.04),
                      ),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                    child: Text(
                      step.arabic!,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 20,
                        height: 2.2,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],

                // Translation Card
                if (translation != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryTeal.withValues(alpha: 0.05)
                          : AppColors.primaryTeal.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryTeal.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      translation,
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                      style: isRtl
                          ? TextStyle(
                              fontFamily: 'NotoNastaliqUrdu',
                              fontSize: 15,
                              color: isDark ? Colors.white70 : Colors.black87,
                              height: 2.2,
                            )
                          : TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black87,
                              height: 1.6,
                            ),
                    ),
                  ),
                ],

                // Reference
                if (step.reference.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 14,
                        color: AppColors.primaryTeal.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          step.reference,
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(String number) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryTeal.withValues(alpha: 0.3),
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: AppColors.primaryTeal,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
