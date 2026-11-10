import 'package:flutter/material.dart';
import 'package:notes_app/models/quote_model.dart';
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
    Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
  }

  void _refresh() {
    Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        if (quoteProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (quoteProvider.errorMsg.isNotEmpty) {
          return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(quoteProvider.errorMsg),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
          ],);
        } else {
          return QuoteCard(
            quoteObj: Quote(
              quote: quoteProvider.quote,
              author: quoteProvider.author,
            ),
            onRefresh: _refresh,
          );
        }
      },
    );
  }
}
