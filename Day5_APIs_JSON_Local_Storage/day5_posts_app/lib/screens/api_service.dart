import 'dart:convert';

import 'package:day5_posts_app/screens/modalclass.dart';
import 'package:http/http.dart' as http;
import 'package:day5_posts_app/screens/commentmodal.dart';

// import 'post_model.dart';

class ApiService {
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Post.fromJson(item)).toList();
      } else if (response.statusCode == 400) {
        throw Exception(
          'Bad Request. Please check your input. ${response.statusCode}',
        );
      } else if (response.statusCode == 404) {
        throw Exception('Page not found!. ${response.statusCode}');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Comment>> fetchcomments(int postId) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/$postId/comments',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> JsonData = jsonDecode(response.body);
        return JsonData.map((item) => Comment.fromJson(item)).toList();
      } else if (response.statusCode == 400) {
        throw Exception(
          'Bad Request. Please check your input. ${response.statusCode}',
        );
      } else if (response.statusCode == 404) {
        throw Exception('Page not found!. ${response.statusCode}');
      } else {
        throw Exception('Error : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
