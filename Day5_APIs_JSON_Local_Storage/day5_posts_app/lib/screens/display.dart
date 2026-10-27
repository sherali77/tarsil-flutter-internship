import 'package:day5_posts_app/screens/api_service.dart';
import 'package:day5_posts_app/screens/commentmodal.dart';
import 'package:flutter/material.dart';
import 'package:day5_posts_app/screens/modalclass.dart';

class DisplayPost extends StatefulWidget {
  final Post post;
  const DisplayPost({super.key, required this.post});

  @override
  State<DisplayPost> createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  final ApiService _apiService = ApiService();
  late Future<List<Comment>> _commentsFuture;

  int get postId => widget.post.id;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    setState(() {
      _commentsFuture = _apiService.fetchcomments(postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Display Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Comment>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${snapshot.error}'.replaceAll('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _loadComments,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final comments = snapshot.data!;
            if (comments.isEmpty) {
              return const Center(child: Text('No comments found.'));
            }
            
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(widget.post.body, style: TextStyle(fontSize: 15)),
                  SizedBox(height: 20),
                  Text(
                    "Comments :",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index]; 
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 5,
                          ),
                          child: ListTile(
                            title: Text(
                              comment.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(comment.body,
                            maxLines: 2,),
                            trailing: Text(comment.email),
                            // leading: Text("Post ID: ${comment.postId}"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}