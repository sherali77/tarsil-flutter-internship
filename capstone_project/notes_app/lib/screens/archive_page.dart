import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:notes_app/screens/note_details.dart';
import 'package:notes_app/widgets/empty_state.dart';
import 'package:notes_app/widgets/note_card.dart';
import 'package:provider/provider.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchiveState();
}

class _ArchiveState extends State<ArchivePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<NotesProvider>().showArchivedNotes(true);
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
        title: Text(
          "Archive Page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Expanded(
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
    );
  }
}
