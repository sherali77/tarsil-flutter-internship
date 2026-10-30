import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/screens/model_class.dart';
import 'package:notes_app/services/storage_services.dart';

import 'dart:async';

class NoteDetails extends StatefulWidget {
  // List<Note> displayList=[];
  const NoteDetails({super.key});

  @override
  State<NoteDetails> createState() => _Notedetails();
}

class _Notedetails extends State<NoteDetails> {
  List<Note> displayList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedNotes();
    // _savedNotes();
  }

  Future<void> _loadSavedNotes() async {
    final loadedNotes = await StorageService.loadNotes();
    setState(() {
      displayList = loadedNotes;
    });
  }

  // Future<void> _savedNotes() async {
  //   await StorageService.saveNotes(displayList);
  //   setState(() {});
  // }

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
      body: displayList.isEmpty
          ? const Center(
              child: Text(
                'No notes yet',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final note = displayList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        title: Text(
                          note.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          note.content,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Chip(
                          label: Text(
                            note.category,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text("Time: ${note.createdAt.hour}:${note.createdAt.minute} | Date: ${note.createdAt.day}/${note.createdAt.month}}",),
                          SizedBox(width: 20,),
                          Text("${note.createdAt.toString()}"),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 20,
                            ),
                            onPressed: () async {
                              final updatedNote = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CreateNote(
                                      noteToEdit: note,
                                      noteIndex: index,
                                    );
                                  },
                                ),
                              );
                              if (updatedNote != null && updatedNote is Note) {
                                setState(() {
                                  displayList[index] = updatedNote;
                                });
                                await StorageService.saveNotes(displayList);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () async {
                              setState(() {
                                displayList.removeAt(index);
                              });
                              await StorageService.saveNotes(displayList);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
