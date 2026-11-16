import "package:notes_app/models/note.dart";
import 'package:notes_app/db/notes_db.dart';
import "package:sqflite/sql.dart";

class NotesRepo {
  Future<List<Note>> getAllNotes() async {
    final db = await DatabaseService.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseService.TABLE_NAME,
    );
    return maps.map((e) => Note.fromMap(e)).toList();
  }

  Future<void> addNote(Note note) async {
    final db = await DatabaseService.instance.database;
    db.insert(
      DatabaseService.TABLE_NAME,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editNote(Note note) async {
    final db = await DatabaseService.instance.database;
    db.update(
      DatabaseService.TABLE_NAME,
      note.toMap(),
      where: "id=?",
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int? id) async {
    final db = await DatabaseService.instance.database;
    db.delete(DatabaseService.TABLE_NAME, where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DatabaseService.instance.database;
    db.delete(DatabaseService.TABLE_NAME);
  }
}
