import 'package:flutter/material.dart';
import '../app_colors.dart';

Widget loading() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryTeal),
  );
}
