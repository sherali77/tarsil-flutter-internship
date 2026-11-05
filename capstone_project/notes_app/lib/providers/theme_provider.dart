import 'package:flutter/material.dart';
import 'package:notes_app/services/storage_services.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  Future<void> loadThemeMode() async {
    bool isDarkSaved = await StorageService().loadThemeMode();
    _themeMode = isDarkSaved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  Future<void> saveThemeMode(bool isDarkMode) async {
    await StorageService().saveThemeMode(isDarkMode);
  }
}
