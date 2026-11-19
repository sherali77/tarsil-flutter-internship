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

  void nullFun() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        final quoteData = quoteProvider.quotedata;
        final currQuote = quoteProvider.currquote;
        final snackBar = SnackBar(content: Text(quoteProvider.errorMsg));
        if (quoteProvider.isLoading) {
          return Stack(
            alignment: Alignment.center,
            children: [
              QuoteCard(quoteObj: currQuote, onRefresh: _refresh),
              CircularProgressIndicator(),
            ],
          );
        } else if (quoteProvider.errorMsg.isNotEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: QuoteCard(quoteObj: currQuote, onRefresh: nullFun),
              ),
              TextButton.icon(
                onPressed: () {
                  _refresh();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
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
