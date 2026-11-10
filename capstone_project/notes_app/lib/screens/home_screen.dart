import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/note.dart';
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
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<NotesProvider>(context, listen: false).loadNotes();
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
                setState(() {
                  _searchQuery = value;
                });
                if (value.isEmpty) {
                  Provider.of<NotesProvider>(
                    context,
                    listen: false,
                  ).loadNotes();
                } else {
                  Provider.of<NotesProvider>(
                    context,
                    listen: false,
                  ).searchNotes(value);
                }
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
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Categories')),
                DropdownMenuItem(value: 'Work', child: Text('Work')),
                DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                DropdownMenuItem(value: 'Study', child: Text('Study')),
              ],
              onChanged: (value) {
                if (value != null) {
                  Provider.of<NotesProvider>(
                    context,
                    listen: false,
                  ).filterNotesByCategory(value);
                }
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
                List<Note> noteList = notesProvider.notes;
                return noteList.isEmpty
                    ? EmptyState(
                        message: _searchQuery.isNotEmpty
                            ? 'No results found'
                            : 'No notes available. Please add a note.',
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<NotesProvider>(
                            context,
                            listen: false,
                          ).loadNotes();
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
                                if (!mounted) return;
                                Provider.of<NotesProvider>(
                                  context,
                                  listen: false,
                                ).loadNotes();
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNote()),
          );
        },
      ),
    );
  }
}
