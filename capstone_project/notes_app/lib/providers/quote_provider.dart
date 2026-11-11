import 'package:flutter/material.dart';
import 'package:notes_app/models/quote_model.dart';
import 'package:notes_app/repositories/quote_repo.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteRepo quoteRepo;
  QuoteProvider({required this.quoteRepo});
  bool _isLoading = false;
  String _errorMsg = '';
  Quote? _quoteData;
  Quote? get quoteData => _quoteData;
  String get quote => _quoteData?.quote ?? '';
  String get author => _quoteData?.author ?? '';
  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;

  Future<void> fetchQuote() async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMsg = "";
    notifyListeners();
    try {
      Quote quoteData = await quoteRepo.fetchQuote();
      _quoteData = quoteData;
      _errorMsg = '';
    } catch (e) {
      _errorMsg = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}