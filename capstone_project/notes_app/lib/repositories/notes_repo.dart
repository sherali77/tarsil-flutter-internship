import 'dart:convert';

import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/services/storage_services.dart';

class NotesRepo {
  final StorageService _localStorageService = StorageService();

  Future<List<Note>> getNotes() async {
    return await _localStorageService.loadNotes();
  }

  Future<void> addNote(Note newNote) async {
    List<Note> notes = await _localStorageService.loadNotes();
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
    await _localStorageService.saveNotesToPrefs(notes);
  }

  Future<void> updateNote(Note updatedNote) async {
    final List<Note> notes = await _localStorageService.loadNotes();
    int index = notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      await _localStorageService.saveNotesToPrefs(notes);
    }
  }

  Future<void> deleteNote(int id) async {
    final List<Note> notes = await _localStorageService.loadNotes();
    notes.removeWhere((note) => note.id == id);
    await _localStorageService.saveNotesToPrefs(notes);
  }

  Future<void> deleteAllNotes(List<Note> notes) async {
    notes.clear();
    await _localStorageService.saveNotesToPrefs(notes);
  }
}
