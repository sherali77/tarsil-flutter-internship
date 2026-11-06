import 'package:flutter/material.dart';
import 'package:notes_app/repositories/theme_repo.dart';
import 'package:notes_app/services/storage_services.dart';
class ThemeProvider extends ChangeNotifier {
  final themeRepo = ThemeRepo();
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemeMode() async {
    bool isDarkSaved = await themeRepo.loadThemeMode();
    _themeMode = isDarkSaved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); 
    await themeRepo.saveThemeMode(isDarkMode);
  }
}