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
  Future<void> _refresh() async {
  final provider = context.read<QuoteProvider>();
  await provider.fetchQuote();
  if (!mounted) return;
  if (provider.errorMsg.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(provider.errorMsg),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        final quoteData = quoteProvider.quotedata;
        final currQuote = quoteProvider.currquote;
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
                child: QuoteCard(quoteObj: currQuote, onRefresh: _refresh),
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
