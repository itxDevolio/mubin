import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_colors.dart';

class GlassLoadingOverlay extends StatelessWidget {
  final String? message;
  const GlassLoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        // Backdrop Blur Effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.2),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              color: (isDark ? Colors.grey[900]! : Colors.white).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryTeal,
                    strokeWidth: 3,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
