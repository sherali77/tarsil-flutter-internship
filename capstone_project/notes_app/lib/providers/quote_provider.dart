import 'package:flutter/material.dart';
import 'package:notes_app/models/quote_model.dart';
import 'package:notes_app/repositories/quote_repo.dart';

class QuoteProvider extends ChangeNotifier {
  final quoteRepo = QuoteRepo();
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
    _errorMsg = "";
    notifyListeners();
    try {
      Quote quoteData = await quoteRepo.fetchQuote();
      _quote = quoteData.quote;
      _author = quoteData.author;
      _errorMsg = '';
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
