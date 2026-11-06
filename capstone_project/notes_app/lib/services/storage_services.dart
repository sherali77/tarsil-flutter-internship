import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/models/model_class.dart';

import 'dart:convert';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  StorageService._internal();
  factory StorageService() {
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void>saveNotesToPrefs(List<Note> notes) async {
    await _initPrefs();
    List<String> noteStringList = notes
        .map((note) => jsonEncode(note.toJson()))
        .toList();
    await _prefs!.setStringList('notes', noteStringList);
  }

  Future<List<Note>> loadNotes() async {
    await _initPrefs();
    List<String>? noteStringList = _prefs!.getStringList('notes');
    if (noteStringList == null) return [];
    return noteStringList
        .map((noteString) => Note.fromJson(jsonDecode(noteString)))
        .toList();
  }
    
  Future<void> saveThemeMode(bool isDark) async {
    await _initPrefs();
    await _prefs!.setBool('isDarkMode', isDark);
  }

  Future<bool> loadThemeMode() async {
    await _initPrefs();
    return _prefs!.getBool('isDarkMode') ?? false;
  }
}
