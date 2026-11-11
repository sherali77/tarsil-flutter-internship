import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/note_details.dart';
import 'package:notes_app/screens/settings.dart';
import 'package:notes_app/utils/search.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<NotesProvider>().loadNotes();
    });
  }

  String _emptyMessage(NotesProvider provider) {
    if (provider.searchQuery.isNotEmpty) return 'No results found';
    if (provider.selectedCategory != 'All') {
      return 'No notes in this category';
    }
    return 'No notes yet. Please add a note.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes App',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
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
                context.read<NotesProvider>().searchNotes(value);
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
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All Categories'),
                ),
                ...kCategories.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<NotesProvider>().filterNotesByCategory(value);
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

                if (notesProvider.isLoading && noteList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (notesProvider.errorMessage != null && noteList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          notesProvider.errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => notesProvider.loadNotes(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (noteList.isEmpty) {
                  return EmptyState(message: _emptyMessage(notesProvider));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<NotesProvider>().loadNotes();
                  },
                  child: ListView.builder(
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      final note = noteList[index];
                      return NoteCard(
                        note: note,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NoteDetails(note: note),
                            ),
                          );
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
        child: const Icon(Icons.add, size: 30),
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