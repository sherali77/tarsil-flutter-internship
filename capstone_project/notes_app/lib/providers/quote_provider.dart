import 'package:flutter/material.dart';
import 'package:notes_app/services/api_service.dart';

class QuoteProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMsg = '';
  String _quote = '';
  String _author = '';
  String get quote => _quote;
  String get author => _author;
  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;
  Future<void> fetchQuote() async {
    _isLoading = true;
    notifyListeners();
    try {
      final quoteData = await ApiService().fetchRandomQuote();
      _quote = quoteData['content'] ?? '';
      _author = quoteData['author'] ?? '';
      _errorMsg = '';
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
