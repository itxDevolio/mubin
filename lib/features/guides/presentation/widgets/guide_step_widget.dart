import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../domain/entities/guide_step.dart';

class GuideStepWidget extends ConsumerWidget {
  final GuideStep step;
  final bool isUrdu;

  const GuideStepWidget({
    super.key,
    required this.step,
    required this.isUrdu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUrdu) _buildStepCircle(step.stepNumber),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  isUrdu ? step.titleUr : step.titleEn,
                  textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                  style: isUrdu 
                    ? const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontSize: 19, fontWeight: FontWeight.bold, height: 1.6)
                    : const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                ),
              ),
              const SizedBox(width: 16),
              if (isUrdu) _buildStepCircle(step.stepNumber),
            ],
          ),
          const SizedBox(height: 18),
          
          // Step Content with Vertical Line
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                left: !isUrdu ? BorderSide(color: AppColors.primaryTeal.withOpacity(0.15), width: 1.5) : BorderSide.none,
                right: isUrdu ? BorderSide(color: AppColors.primaryTeal.withOpacity(0.15), width: 1.5) : BorderSide.none,
              ),
            ),
            child: Column(
              crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Instructions
                Text(
                  isUrdu ? step.contentUr : step.contentEn,
                  textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                  style: isUrdu 
                    ? TextStyle(fontFamily: 'NotoNastaliqUrdu', fontSize: 15, color: isDark ? Colors.white70 : Colors.black87, height: 2.3)
                    : TextStyle(fontFamily: 'Poppins', fontSize: 15, color: isDark ? Colors.white70 : Colors.black87, height: 1.7),
                ),

                // Arabic Prayer Card
                if (step.arabic != null) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.04)),
                      boxShadow: [
                        if (!isDark) BoxShadow(
                          color: Colors.black.withOpacity(0.03),
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

                // Localized Translation
                if (isUrdu && step.translationUr != null) ...[
                  const SizedBox(height: 18),
                  Text(
                    step.translationUr!,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontSize: 14, height: 2.4, color: AppColors.primaryTeal),
                  ),
                ],
                if (!isUrdu && step.translationEn != null) ...[
                  const SizedBox(height: 18),
                  Text(
                    step.translationEn!,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontStyle: FontStyle.italic, color: AppColors.primaryTeal.withOpacity(0.9), height: 1.6),
                  ),
                ],

                const SizedBox(height: 24),

                // AUTHENTIC REFERENCE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.025),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bookmark_added_rounded, size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                           "Reference: ${step.reference}",
                          style: isUrdu 
                            ? TextStyle(fontFamily: 'NotoNastaliqUrdu', fontSize: 12, color: Colors.grey.shade600)
                            : TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey.shade600, letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(String number) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: AppColors.primaryTeal,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}
