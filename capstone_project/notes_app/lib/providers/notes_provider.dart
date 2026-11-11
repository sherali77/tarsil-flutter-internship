import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/repositories/notes_repo.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepo notesRepo;
  NotesProvider({required this.notesRepo});

  bool _isLoading = false;
  List<Note> _allNotes = [];
  List<Note> _notes = [];
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  bool get isLoading => _isLoading;
  List<Note> get notes => List.unmodifiable(_notes);
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  Note? getNoteById(int id) {
    for (final note in _allNotes) {
      if (note.id == id) return note;
    }
    return null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _applyFilters() {
    final keyword = _searchQuery.toLowerCase();
    _notes = _allNotes.where((note) {
      final matchesSearch =
          keyword.isEmpty || note.title.toLowerCase().contains(keyword);
      final matchesCategory =
          _selectedCategory == 'All' || note.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<bool> _run([Future<void> Function()? action]) async {
    if (_isLoading) return false;
    _setLoading(true);
    bool success = true;
    try {
      if (action != null) await action();
      _allNotes = await notesRepo.getNotes();
      _applyFilters();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      success = false;
    }
    _setLoading(false);
    return success;
  }

  Future<void> loadNotes() async {
    await _run();
  }

  void searchNotes(String keyword) {
    _searchQuery = keyword;
    _applyFilters();
    notifyListeners();
  }

  void filterNotesByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  Future<bool> addNote(Note newNote) {
    return _run(() => notesRepo.addNote(newNote));
  }

  Future<bool> updateNote(Note updatedNote) {
    return _run(() => notesRepo.updateNote(updatedNote));
  }

  Future<bool> deleteNote(int id) {
    return _run(() => notesRepo.deleteNote(id));
  }

  Future<bool> deleteAllNotes() {
    return _run(() => notesRepo.deleteAllNotes());
  }
}