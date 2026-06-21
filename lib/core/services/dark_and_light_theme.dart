import 'package:flutter/material.dart';

bool themeDark(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark;
}

Color getThemeColor(BuildContext context, {Color light = Colors.white, required Color dark}) {
  return themeDark(context) ? dark : light;
}
