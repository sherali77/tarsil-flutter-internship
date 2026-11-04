import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/services/storage_services.dart';
import 'package:notes_app/widgets/format_date.dart';

class NoteDetails extends StatefulWidget {
  final Note note;
  final int index;
  const NoteDetails({super.key, required this.index, required this.note});

  @override
  State<NoteDetails> createState() => _Notedetails();
}

class _Notedetails extends State<NoteDetails> {
  late Note currentNote;

  @override
  void initState() {
    super.initState();
    currentNote = widget.note;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Card(
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
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (currentNote.updatedAt.isAfter(
                  currentNote.createdAt.add(const Duration(seconds: 5)),
                ))
                  Text(
                    "Updated: ${FormatDate.format(currentNote.updatedAt)}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
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
                          style: const TextStyle(
                            fontSize: 17,
                          ),
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
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                        size: 24,
                      ),
                      onPressed: () async {
                        final updatedNote = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CreateNote(
                                noteToEdit: currentNote,
                                noteIndex: widget.index,
                              );
                            },
                          ),
                        );
                        if (updatedNote != null && updatedNote is Note) {
                          setState(() {
                            currentNote = updatedNote;
                          });
                          await StorageService().updateNote(updatedNote);
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 24,
                      ),
                      onPressed: () async {
                        await StorageService().deleteNote(currentNote.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
