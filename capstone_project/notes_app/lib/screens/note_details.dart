import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/screens/model_class.dart';
import 'package:notes_app/services/storage_services.dart';

import 'dart:async';

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
  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}";
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
                      child: Text(
                        currentNote.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
                  "Created: ${_formatDate(currentNote.createdAt)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (currentNote.updatedAt.isAfter(currentNote.createdAt.add(const Duration(seconds: 5))))
                  Text(
                    "Updated: ${_formatDate(currentNote.updatedAt)}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                const Divider(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      currentNote.content,
                      style: const TextStyle(fontSize: 16, height: 1.5),
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
                          final loadedNotes =
                              await StorageService.loadNotes();
                          loadedNotes[widget.index] = updatedNote;
                          await StorageService.saveNotes(loadedNotes);
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
                        final loadedNotes =
                            await StorageService.loadNotes();
                        loadedNotes.removeAt(widget.index);
                        await StorageService.saveNotes(loadedNotes);
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