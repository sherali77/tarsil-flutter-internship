import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/repositories/notes_repo.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepo notesRepo;
  NotesProvider({required this.notesRepo});
  bool _isloading = false;
  List<Note> _notes = [];
  String? _errorMessage;

  bool get isLoading => _isloading;
  List<Note> get notes => List.unmodifiable(_notes);

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  String? get errorMessage => _errorMessage;

  Future<void> loadNotes() async {
    if (_isloading) return; 
    setLoading(true);
    try {
      _notes = await notesRepo.getNotes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> searchNotes(String keyword) async {
    if (_isloading) return;
    setLoading(true);
    try {
      List<Note> allNotes = await notesRepo.getNotes();
      _notes = allNotes
          .where(
            (note) => note.title.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> filterNotesByCategory(String category) async {
    if (_isloading) return;
    setLoading(true);
    try {
      List<Note> allNotes = await notesRepo.getNotes();
      if (category == 'All') {
        _notes = allNotes;
      } else {
        _notes = allNotes.where((note) => note.category == category).toList();
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> addNote(Note newNote) async {
    if (_isloading) return;
    setLoading(true);
    try {
      await notesRepo.addNote(newNote);
      _notes = await notesRepo.getNotes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> updateNote(Note updateNote) async {
    if (_isloading) return;
    setLoading(true);
    try {
      await notesRepo.updateNote(updateNote);
      _notes = await notesRepo.getNotes(); 
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> deleteNote(int id) async {
    if (_isloading) return;
    setLoading(true);
    try {
      await notesRepo.deleteNote(id);
      _notes = await notesRepo.getNotes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }

  Future<void> deleteAllNotes() async {
    if (_isloading) return;
    setLoading(true);
    try {
      await notesRepo.deleteAllNotes();
      _notes.clear();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    setLoading(false);
  }
}