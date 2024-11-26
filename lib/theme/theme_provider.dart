import 'package:flutter/material.dart';
import 'package:vigenesia/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default ke tema sistem

  ThemeMode get themeMode => _themeMode;

  ThemeData get themeData {
    switch (_themeMode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
      default:
        // Kembalikan tema default sistem perangkat (untuk Dynamic Theme)
        return WidgetsBinding.instance.window.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
