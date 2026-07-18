import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../core/services/settings_controller.dart';
import '../../../core/services/haptic_feedback.dart';

class CalculationMethodScreen extends ConsumerWidget {
  const CalculationMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Calculation Method",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: calculationMethods.length,
        itemBuilder: (context, index) {
          final method = calculationMethods[index];
          final isSelected = settings.calculationMethod == method['key'];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: InkWell(
              onTap: () {
                hapticFeedBack();
                controller.setCalculationMethod(method['key']!);
              },
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primaryTeal.withOpacity(0.1) 
                      : (isDark ? AppColors.surfaceDark : Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primaryTeal 
                        : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    if (!isDark && isSelected)
                      BoxShadow(
                        color: AppColors.primaryTeal.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method['name']!,
                            style: GoogleFonts.poppins(
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 15,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Currently Active",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: AppColors.primaryTeal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.primaryTeal,
                        size: 24,
                      )
                    else
                      Icon(
                        Icons.radio_button_off_rounded,
                        color: isDark ? Colors.white24 : Colors.black12,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
