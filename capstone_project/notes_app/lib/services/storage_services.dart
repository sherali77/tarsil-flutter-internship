import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/models/note.dart';

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

  Future<void> saveNotesToPrefs(List<Note> notes) async {
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

  Future<void> insertNote(Note newNote) async {
    await _initPrefs();
    List<Note> notes = await loadNotes();

    int newId = 1;
    if (notes.isNotEmpty) {
      int maxId = notes.map((n) => n.id).reduce((a, b) => a > b ? a : b);
      newId = maxId + 1;
    }

    final noteWithId = newNote.copyWith(id: newId);

    notes.add(noteWithId);
    await saveNotesToPrefs(notes);
  }

  Future<void> updateNoteInPrefs(Note updatedNote) async {
    await _initPrefs();
    List<Note> notes = await loadNotes();
    int index = notes.indexWhere((note) => note.id == updatedNote.id);
    if (index == -1) {
      throw Exception('Note not found, could not update');
    }
    notes[index] = updatedNote;
    await saveNotesToPrefs(notes);
  }

  Future<void> deleteNoteFromPrefs(int id) async {
    await _initPrefs();
    List<Note> notes = await loadNotes();
    notes.removeWhere((note) => note.id == id);
    await saveNotesToPrefs(notes);
  }

  Future<void> clearNotes() async {
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