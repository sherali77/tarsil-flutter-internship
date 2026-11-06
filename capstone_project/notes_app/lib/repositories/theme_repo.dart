import 'package:notes_app/services/storage_services.dart';

class ThemeRepo {
  final StorageService _storageService = StorageService();

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _storageService.saveThemeMode(isDarkMode);
  }

  Future<bool> loadThemeMode() async {
    return await _storageService.loadThemeMode();
  }
}
