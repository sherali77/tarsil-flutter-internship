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
  String _orderBy = 'isPinned DESC, createdAt DESC';
  bool _showArchived = false;
  bool get isLoading => _isLoading;
  List<Note> get notes => List.unmodifiable(_notes);
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get showArchived => _showArchived;

  Note? getNoteById(int? id) {
    for (final note in _allNotes) {
      if (note.id == id) {
        return note;
      }
    }
    return null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _refreshNotes() async {
    _allNotes = await notesRepo.getAllNotes(orderBy: _orderBy);
    _applyFilters();
  }

  void _applyFilters() {
    final keyword = _searchQuery.toLowerCase();

    _notes = _allNotes.where((note) {
      final matchesSearch =
          keyword.isEmpty || note.title.toLowerCase().contains(keyword);

      final matchesCategory =
          _selectedCategory == 'All' || note.category == _selectedCategory;

       final matchesArchive =
        _showArchived ? note.isArchived == true : note.isArchived != true;

    return matchesSearch &&
        matchesCategory &&
        matchesArchive;
    }).toList();
  }

  Future<void> loadNotes() async {
    _setLoading(true);
    try {
      await _refreshNotes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addNote(Note newNote) async {
    _setLoading(true);
    try {
      await notesRepo.addNote(newNote);
      await _refreshNotes();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateNote(Note updatedNote) async {
    _setLoading(true);
    try {
      await notesRepo.editNote(updatedNote);
      await _refreshNotes();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteNote(int? id) async {
    _setLoading(true);
    try {
      await notesRepo.deleteNote(id);
      await _refreshNotes();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteAllNotes() async {
    _setLoading(true);
    try {
      await notesRepo.deleteAll();
      await _refreshNotes();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> togglePin(int id, bool isPinned) async {
    _setLoading(true);

    try {
      await notesRepo.togglePin(id, isPinned);
      await _refreshNotes();

      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> archiveNote(int id, bool isArchived) async {
    _setLoading(true);

    try {
      await notesRepo.archiveNote(id, isArchived);
      await _refreshNotes();

      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> orderBy(String sorting) async {
    if (sorting == 'Newest') {
      _orderBy = 'isPinned DESC, createdAt DESC';
    } else if (sorting == 'Oldest') {
      _orderBy = 'isPinned DESC, createdAt ASC';
    }
    await loadNotes();
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

  void showArchivedNotes(bool value) {
  _showArchived = value;
  _applyFilters();
  notifyListeners();
}
}
