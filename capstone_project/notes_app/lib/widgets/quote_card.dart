import 'package:flutter/material.dart';
import 'package:notes_app/models/quote_model.dart'; 

class QuoteCard extends StatelessWidget {
  final Quote quoteObj; 
  final VoidCallback onRefresh;

  const QuoteCard({
    super.key,
    required this.quoteObj,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.format_quote, size: 24, color: Colors.amber),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('"${quoteObj.quote}"',
                      style: const TextStyle(
                          fontSize: 13, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('— ${quoteObj.author}',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, size: 18),
              onPressed: onRefresh,
              tooltip: 'New Quote',
            ),
          ],
        ),
      ),
    );
  }
}