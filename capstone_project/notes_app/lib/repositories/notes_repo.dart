import "package:notes_app/models/note.dart";
import "package:notes_app/services/storage_services.dart";

class NotesRepo {
  final StorageService _localStorageService = StorageService();

  Future<List<Note>> getNotes() async {
    return await _localStorageService.loadNotes();
  }

  Future<void> addNote(Note newNote) async {
    await _localStorageService.insertNote(newNote);
  }

  Future<void> updateNote(Note updatedNote) async {
    await _localStorageService.updateNoteInPrefs(updatedNote);
  }

  Future<void> deleteNote(int id) async {
    await _localStorageService.deleteNoteFromPrefs(id);
  }

  Future<void> deleteAllNotes() async {
    await _localStorageService.clearNotes();
  }
}