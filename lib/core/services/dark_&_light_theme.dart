import 'package:flutter/material.dart';

bool themeDark(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  if (isDark) {
    return true;
  }
  return false;
}
