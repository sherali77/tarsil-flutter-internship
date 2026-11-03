import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/screens/note_details.dart';
import 'package:notes_app/screens/settings.dart';
import 'package:notes_app/services/storage_services.dart';

import 'dart:async';

import 'package:notes_app/widgets/empty_state.dart';
import 'package:notes_app/widgets/note_card.dart';
import 'package:notes_app/widgets/quote_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Note> noteList = [];
  List<Note> allNotes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedNotes();
  }

  Future<void> _loadSavedNotes() async {
    final loadedNotes = await StorageService().loadNotes();
    setState(() {
      allNotes = loadedNotes;
      noteList = loadedNotes;
      FocusScope.of(context).unfocus();
    });
  }

  void searchNote(String keyword) {
    if (keyword.isEmpty) {
      noteList = allNotes;
    } else {
      noteList = allNotes
          .where(
            (note) => note.title.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int newId = 1;
    return Scaffold(
      // backgroundColor: Colors.grey[100],
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
              _loadSavedNotes();
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
          const QuoteSection(),
          Expanded(
            child: noteList.isEmpty
                ? EmptyState()
                : RefreshIndicator(
                    onRefresh: _loadSavedNotes,
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
                            _loadSavedNotes();
                          },
                        );
                      },
                    ),
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
            await StorageService().addNote(newNote);
            _loadSavedNotes();
          }
        },
      ),
    );
  }
}
