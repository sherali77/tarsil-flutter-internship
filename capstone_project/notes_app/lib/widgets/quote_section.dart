import 'package:flutter/material.dart';
import 'package:notes_app/providers/quote_provider.dart';
import 'package:notes_app/widgets/quote_card.dart';
import 'package:provider/provider.dart';

class QuoteSection extends StatefulWidget {
  const QuoteSection({super.key});

  @override
  State<QuoteSection> createState() => _QuoteSectionState();
}

class _QuoteSectionState extends State<QuoteSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<QuoteProvider>().fetchQuote();
    });
  }

  void _refresh() {
    context.read<QuoteProvider>().fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        final quoteData = quoteProvider.quoteData;
        if (quoteProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (quoteProvider.errorMsg.isNotEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text(quoteProvider.errorMsg)),
              TextButton.icon(
                onPressed: _refresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          );
        } else if (quoteData == null) {
          return const SizedBox.shrink();
        } else {
          return QuoteCard(quoteObj: quoteData, onRefresh: _refresh);
        }
      },
    );
  }
}