import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class DeleteDialog {
  void showDeleteConfirmationDialog(BuildContext context) {
    final provider = context.read<NotesProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete All Notes'),
          content: const Text('Are you sure to delete all notes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                final success = await provider.deleteAllNotes();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'All notes deleted'
                          : (provider.errorMessage ?? 'Could not delete notes'),
                    ),
                    backgroundColor: errorColor,
                  ),
                );
              },
              child: Text(
                'Delete All',
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