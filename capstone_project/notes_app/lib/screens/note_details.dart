import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/format_date.dart';
import 'package:notes_app/widgets/delete_one.dart';
import 'package:provider/provider.dart';

class NoteDetails extends StatelessWidget {
  final Note note;
  const NoteDetails({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<NotesProvider>(
          builder: (context, notesProvider, child) {
            final currentNote = notesProvider.getNoteById(note.id) ?? note;
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: 'note-title-${currentNote.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                currentNote.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Chip(
                          label: Text(
                            currentNote.category,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Created: ${FormatDate.format(currentNote.createdAt)}",
                      style: TextStyle(color: theme.hintColor, fontSize: 12),
                    ),
                    if (currentNote.updatedAt.isAfter(
                      currentNote.createdAt.add(const Duration(seconds: 5)),
                    ))
                      Text(
                        "Updated: ${FormatDate.format(currentNote.updatedAt)}",
                        style: TextStyle(color: theme.hintColor, fontSize: 12),
                      ),

                    const Divider(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Hero(
                          tag: 'note-content-${currentNote.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              currentNote.content,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CreateNote(noteToEdit: currentNote);
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: theme.colorScheme.error,
                            size: 24,
                          ),
                          onPressed: () {
                            DeleteOneDialog().showDeleteConfirmation(
                              context,
                              currentNote.id,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}