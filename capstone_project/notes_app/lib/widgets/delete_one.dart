import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class DeleteOneDialog {
  void showDeleteConfirmation(BuildContext context, int noteId) {
    final provider = context.read<NotesProvider>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                final success = await provider.deleteNote(noteId);
                if (success) {
                  navigator.pop();
                }
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Note deleted'
                          : (provider.errorMessage ?? 'Could not delete note'),
                    ),
                    backgroundColor: errorColor,
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}