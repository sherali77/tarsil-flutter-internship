import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/screens/model_class.dart';

class StorageService {
  static const String _key = 'Saved_notes';

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      notes.map((note) => note.toJson()).toList(),
    );
    await prefs.setString(_key, encodedData);
  }

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_key);
    if (encodedData == null) return [];

    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((item) => Note.fromJson(item)).toList();
  }
}