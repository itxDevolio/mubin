import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Mubin",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20,
                color: AppColors.primaryTeal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
