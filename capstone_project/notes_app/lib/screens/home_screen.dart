import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/screens/note_details.dart';
import 'package:notes_app/screens/settings.dart';
import 'dart:async';
import 'package:notes_app/widgets/empty_state.dart';
import 'package:notes_app/widgets/note_card.dart';
import 'package:notes_app/widgets/quote_section.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String _selectedCategory = 'All';
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NotesProvider>(context, listen: false).LoadNotes();
    });
  }

  void searchNote(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
  }
  void filterNotesByCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: const Text(
          'Notes App',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              Provider.of<NotesProvider>(context, listen: false).LoadNotes();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
            child: TextField(
              onChanged: (value) {
                searchNote(value);
              },
              decoration: InputDecoration(
                labelText: 'Search by Title',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Categories')),
                DropdownMenuItem(value: 'Work', child: Text('Work')),
                DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                DropdownMenuItem(value: 'Study', child: Text('Study')),
              ],
              onChanged: (value) {
                filterNotesByCategory(value ?? 'All');
              },
              decoration: InputDecoration(
                labelText: 'Filter by Category',
                prefixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const QuoteSection(),
          const SizedBox(height: 15),
          Expanded(
            child: Consumer<NotesProvider>(
              builder: (context, notesProvider, child) {
                var noteList = notesProvider.notes;
                if (_selectedCategory != 'All') {
                  noteList = noteList.where((n) => n.category == _selectedCategory).toList();
                }
                if (_searchKeyword.isNotEmpty) {
                  noteList = noteList.where((n) => n.title.toLowerCase().contains(_searchKeyword.toLowerCase())).toList();
                }
                return noteList.isEmpty ? const EmptyState() :
                   RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<NotesProvider>(
                            context,
                            listen: false,
                          ).LoadNotes();
                        },
                        child: ListView.builder(
                          itemCount: noteList.length,
                          itemBuilder: (context, index) {
                            final note = noteList[index];
                            return NoteCard(
                              note: note,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        NoteDetails(note: note, index: index),
                                  ),
                                );
                                Provider.of<NotesProvider>(
                                  context,
                                  listen: false,
                                ).LoadNotes();
                              },
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNote()),
          );
          if (newNote != null && newNote is Note) {
            await Provider.of<NotesProvider>(
              context,
              listen: false,
            ).addNote(newNote);
          }
        },
      ),
    );
  }
}