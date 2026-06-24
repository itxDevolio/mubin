import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/dhikr_entity.dart';
import '../controller/adhkar_provider.dart';

class AdhkarListScreen extends ConsumerWidget {
  final List<DhikrEntity> dhikrList;
  final String title;

  const AdhkarListScreen({super.key, required this.dhikrList, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: dhikrList.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final dhikr = dhikrList[index];
          final count = ref.watch(adhkarCountProvider(dhikr.id));
          final isCompleted = count >= dhikr.targetCount;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: isCompleted 
                      ? AppColors.primaryTeal.withOpacity(0.1) 
                      : Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                child: InkWell(
                  onTap: isCompleted ? null : () {
                    hapticFeedBack();
                    ref.read(adhkarCountProvider(dhikr.id).notifier).increment();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryTeal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  color: AppColors.primaryTeal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (isCompleted)
                              const Icon(Icons.check_circle_rounded, color: AppColors.primaryTeal, size: 24),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          dhikr.arabic,
                          style: GoogleFonts.amiri(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.8,
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 16),
                        if (isUrdu)
                          _buildTranslationBlock(dhikr.urdu, "ترجمہ", isDark, isUrdu: true)
                        else
                          _buildTranslationBlock(dhikr.english, "Translation", isDark, isUrdu: false),
                        
                        if (dhikr.reference != null && dhikr.reference!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Icon(Icons.bookmark_outline, size: 14, color: AppColors.primaryTeal.withOpacity(0.6)),
                              const SizedBox(width: 4),
                              Text(
                                dhikr.reference!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: isDark ? Colors.white54 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 24),
                        
                        // Counter Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isUrdu ? "ہدف: ${dhikr.targetCount} مرتبہ" : "Goal: Read ${dhikr.targetCount} times",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isCompleted ? AppColors.primaryTeal : (isDark ? Colors.white70 : Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: (count / dhikr.targetCount).clamp(0.0, 1.0),
                                      backgroundColor: AppColors.primaryTeal.withOpacity(0.1),
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryTeal),
                                      minHeight: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Modern Counter Indicator
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted ? AppColors.primaryTeal : AppColors.primaryTeal.withOpacity(0.1),
                                border: Border.all(color: AppColors.primaryTeal, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "$count",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted ? Colors.white : AppColors.primaryTeal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTranslationBlock(String text, String label, bool isDark, {bool isUrdu = false}) {
    return Column(
      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTeal.withOpacity(0.8),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: isUrdu 
            ? GoogleFonts.amiri(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.4,
              )
            : TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.4,
              ),
          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}
