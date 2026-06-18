import 'package:auraq/core/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void userProfileDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: AppColors.textSecondaryDark,

      child: SizedBox(
        width: 250,
        height: 300,

        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8),
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        ),
      ),
    ),
  );
}
