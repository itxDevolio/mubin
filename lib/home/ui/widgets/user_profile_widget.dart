import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/home/ui/widgets/user_profile_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class UserProfileWidget extends StatelessWidget {
  final String name; // Made final as it's a StatelessWidget
  final String pUrl; // Made final as it's a StatelessWidget

  const UserProfileWidget({super.key, required this.name, required this.pUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // Sirf utni width lega jitni content ko chahiye
      children: [
        GestureDetector(
          onTap: () {
            hapticFeedBack();
            userProfileDialog(context, pUrl);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.textSecondaryLight,
            backgroundImage: CachedNetworkImageProvider(pUrl),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Assalam o Alaikum",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(width: 12), // Text aur Avatar k darmiyan gap
        // Profile Avatar (Jo pehle trailing me tha)
      ],
    );
  }
}
