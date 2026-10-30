import 'package:flutter/material.dart';
import 'package:notes_app/screens/api_service.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/screens/model_class.dart';
import 'package:notes_app/screens/note_details.dart';
import 'package:notes_app/services/storage_services.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Note> noteList = [];
  final ApiService _apiService = ApiService();
  late Future _notesFuture;
  String quotes = "";

  @override
  void initState() {
    super.initState();
    _loadSavedNotes();

    _notesFuture = _apiService.fetchRandomQuote().then((quote) {
      setState(() {
        quotes = quote['quote'] ?? '';
      });
      return quote;
    });
  }

  Future<void> _loadSavedNotes() async {
    final loadedNotes = await StorageService.loadNotes();
    setState(() {
      noteList = loadedNotes;
    });
  }

  Future<void> _loadQuotes() async {
    final quotesFetch = await _apiService.fetchRandomQuote();
    setState(() {
      quotes = quotesFetch['quote'] ?? '';
      _notesFuture = Future.value(quotesFetch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: _notesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Card(
                  margin: const EdgeInsets.all(12.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 28,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${snapshot.error}'.replaceAll('Exception: ', ''),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => _loadQuotes(),
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                final quoteData = snapshot.data as Map<String, dynamic>?;
                if (quoteData == null || quoteData.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Card(
                  margin: const EdgeInsets.all(12.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote,
                          size: 24,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"${quoteData['quote']}"',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '— ${quoteData['author']}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 18),
                          onPressed: () => _loadQuotes(),
                          tooltip: 'New Quote',
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: noteList.isEmpty
                ? const Center(
                    child: Text(
                      'No notes yet — tap + to add one',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : RefreshIndicator(onRefresh: _loadSavedNotes,
                   child: ListView.builder(
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      final note = noteList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            note.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            note.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Chip(
                            label: Text(
                              note.category,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NoteDetails();
                                },
                              ),
                            );
                          },
                        ),
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
            MaterialPageRoute(
              builder: (context) {
                return const CreateNote();
              },
            ),
          );

          if (newNote != null && newNote is Note) {
            setState(() {
              noteList.add(newNote);
            });
            await StorageService.saveNotes(noteList);
          }
        },
      ),
    );
  }
}
