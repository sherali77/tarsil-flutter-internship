import 'package:flutter/material.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:provider/provider.dart';

class DeleteDialog {
  void showDeleteConfirmation(BuildContext context, int? itemId) {
    final provider = context.read<ItemProvider>();
    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await provider.deleteItem(itemId!);
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Item deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
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
