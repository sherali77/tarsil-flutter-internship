import 'package:notes_app/models/quote_model.dart';
import 'package:notes_app/services/api_service.dart';

class QuoteRepo {
  final apiService = ApiService();
  Future<Quote> fetchQuote() async {
    final quoteData = await apiService.fetchRandomQuote();
    return Quote.fromJson(quoteData);
  }
}
