import 'package:flutter/material.dart';

bool themeDark(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark;
}
