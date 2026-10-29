import 'package:flutter/material.dart';
import 'package:notes_app/screens/model_class.dart';

class NoteDetails extends StatefulWidget {
  List<Note> displayList;
  NoteDetails({super.key, required this.displayList});

  @override
  State<NoteDetails> createState() => _Notedetails();
}

class _Notedetails extends State<NoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Expanded(
            child: widget.displayList.isEmpty
                ? const Center(
                    child: Text(
                      'No notes yet',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.displayList.length,
                    itemBuilder: (context, index) {
                      final note = widget.displayList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
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
                      );
                    },
                  ),
          ),
    );
  }
}
