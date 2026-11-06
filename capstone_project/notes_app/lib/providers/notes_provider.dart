import 'package:flutter/material.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/repositories/notes_repo.dart';
import 'package:notes_app/services/storage_services.dart';

class NotesProvider extends ChangeNotifier {
  final notesRepo = NotesRepo();
  bool _isloading = false;
  List<Note> _notes = [];
  get isLoading => _isloading;
  get notes => _notes;
  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> LoadNotes() async {
    setLoading(true);
    _notes = await notesRepo.getNotes();
    setLoading(false);
    notifyListeners();
  }

  Future<void> addNote(Note newNote) async {
    setLoading(true);
    await notesRepo.addNote(newNote);
    await LoadNotes();
    setLoading(false);
    notifyListeners();
  }

  Future<void> updateNote(Note updateNote) async {
    setLoading(true);
    await notesRepo.updateNote(updateNote);
    await LoadNotes();
    setLoading(false);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    setLoading(true);
    await notesRepo.deleteNote(id);
    await LoadNotes();
    setLoading(false);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    setLoading(true);
    await notesRepo.deleteAllNotes(notes);
    _notes.clear();
    setLoading(false);
  }
}
