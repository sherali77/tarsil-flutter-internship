import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> fetchRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/quotes/random'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return jsonData;
      } else if (response.statusCode == 400) {
        throw Exception(
          'Bad Request. Please check your input. ${response.statusCode} ${response.body}',
        );
      } else if (response.statusCode == 404) {
        throw Exception('Page not found!. ${response.statusCode} ${response.body}');
      } else {
        throw Exception('Error: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}