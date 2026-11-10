import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Hero(
          tag: 'note-title-${note.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              note.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        subtitle: Hero(
    tag: 'note-content-${note.id}',
    child: Material(
      color: Colors.transparent,
      child: Text(
        note.content,
        style: const TextStyle(fontSize: 17,),
        maxLines: 2,
      ),
    ),
  ),
        leading: CircleAvatar(
          child: Text(
            '${note.id}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Chip(
          label: Text(note.category, style: const TextStyle(fontSize: 11)),
        ),
        onTap: onTap,
      ),
    );
  }
}
