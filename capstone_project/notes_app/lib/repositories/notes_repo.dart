import "package:notes_app/models/note.dart";
import 'package:notes_app/db/notes_db.dart';
import "package:sqflite/sqflite.dart";

class NotesRepo {
  Future<List<Note>> getAllNotes({String? orderBy}) async {
  try {
    return await DatabaseService.instance.getAllNotes(
      orderBy: orderBy,
    );
  } on DatabaseException catch (e, stackTrace) {
    Error.throwWithStackTrace(
      Exception('Failed to get notes'),
      stackTrace,
    );
  }
}

  Future<void> addNote(Note note) async {
    try{
    await DatabaseService.instance.addNote(note);
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to add note'),
        stackTrace,
      );
    }
  }

   Future<void> editNote(Note note) async {
    try{
    await DatabaseService.instance.editNote(note);
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to update note'),
        stackTrace,
      );
    }
  }

   Future<void> deleteNote(int? id) async {
    try{
    await DatabaseService.instance.deleteNote(id);
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to delete note'),
        stackTrace,
      );
    }
  }

   Future<void> deleteAll() async {
    try{
    await DatabaseService.instance.deleteAll();
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to deleteAll notes'),
        stackTrace,
      );
    }
  }

  Future<void> togglePin(int id, bool isPinned) async {
    try{
    await DatabaseService.instance.togglePin(id, isPinned);
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to pin a note'),
        stackTrace,
      );
    }
  }

  Future<void> archiveNote(int id, bool isArchived) async {
    try{
    await DatabaseService.instance.archiveNote(id, isArchived);
    }on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed to archive a note'),
        stackTrace,
      );
    }
  }
}
