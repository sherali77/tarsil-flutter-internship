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

  Future<void> _saveNotesToPrefs(List<Note> notes) async {
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

  Future<void> addNote(Note newNote) async {
    List<Note> notes = await loadNotes();
    int newId = 1;
    if (notes.isNotEmpty) {
      int maxId = notes.map((n) => n.id).reduce((a, b) => a > b ? a : b);
      newId = maxId + 1;
    }

    final noteWithId = Note(
      id: newId,
      title: newNote.title,
      content: newNote.content,
      category: newNote.category,
      createdAt: newNote.createdAt,
      updatedAt: newNote.updatedAt,
    );

    notes.add(noteWithId);
    await _saveNotesToPrefs(notes);
  }

  Future<void> updateNote(Note updatedNote) async {
    List<Note> notes = await loadNotes();
    int index = notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      await _saveNotesToPrefs(notes);
    }
  }

  Future<void> deleteNote(int id) async {
    List<Note> notes = await loadNotes();
    notes.removeWhere((note) => note.id == id);
    await _saveNotesToPrefs(notes);
  }

  Future<void> clearAllNotes() async {
    await _initPrefs();
    await _prefs!.remove('notes');
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
