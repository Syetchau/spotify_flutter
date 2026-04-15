import 'package:flutter/material.dart';

extension ThemeUtils on BuildContext {

  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  Color get adaptiveTextColor {
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color get adaptiveOpaqueColor {
    return isDarkMode
        ? Colors.white.withValues(alpha: 0.03)
        : Colors.black.withValues(alpha: 0.04);
  }
}