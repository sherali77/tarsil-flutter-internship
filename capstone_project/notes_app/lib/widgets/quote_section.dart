import 'package:flutter/material.dart';
import 'package:notes_app/services/api_service.dart';
import 'package:notes_app/widgets/quote_card.dart';

class QuoteSection extends StatefulWidget {
  const QuoteSection({super.key});

  @override
  State<QuoteSection> createState() => _QuoteSectionState();
}

class _QuoteSectionState extends State<QuoteSection> {
  late Future<Map<String, dynamic>> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = ApiService().fetchRandomQuote();
  }

  void _refresh() {
    setState(() {
      _quoteFuture = ApiService().fetchRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _quoteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 28),
                  const SizedBox(height: 6),
                  Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        final data = snapshot.data;
        if (data == null || data.isEmpty) return const SizedBox.shrink();

        return QuoteCard(
          quote: data['quote'] ?? '',
          author: data['author'] ?? '',
          onRefresh: _refresh,
        );
      },
    );
  }
}