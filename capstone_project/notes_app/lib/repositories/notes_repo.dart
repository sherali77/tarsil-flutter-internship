import "package:notes_app/models/note.dart";
import 'package:notes_app/db/notes_db.dart';
import "package:sqflite/sql.dart";

class NotesRepo {
  Future<List<Note>> getAllNotes() async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseService.TABLE_NAME,
      );
      return maps.map((e) => Note.fromMap(e)).toList();
    } catch (e) {
      throw Exception("Failed to load notes $e");
    }
  }

  Future<void> addNote(Note note) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert(
        DatabaseService.TABLE_NAME,
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception("Failed to insert note $e");
    }
  }
  Future<void> editNote(Note note) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        DatabaseService.TABLE_NAME,
        note.toMap(),
        where: "id=?",
        whereArgs: [note.id],
      );
    } catch (e) {
      throw Exception("Failed to update note $e");
    }
  }

  Future<void> deleteNote(int? id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        DatabaseService.TABLE_NAME,
        where: "id=?",
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Failed to delete note $e");
    }
  }
  Future<void> deleteAll() async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(DatabaseService.TABLE_NAME);
    } catch (e) {
      throw Exception("Failed to delete all notes $e");
    }
  }
}
