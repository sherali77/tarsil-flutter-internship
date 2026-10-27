import 'package:day5_posts_app/screens/display.dart';
import 'package:flutter/material.dart';
import 'package:day5_posts_app/screens/modalclass.dart';
import 'package:day5_posts_app/screens/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _postsFuture;
  List<Post> allPosts = [];
  List<Post> filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }
  Future<void> _loadPosts() async {
    final posts = await _apiService.fetchPosts();
    setState(() {
      allPosts = posts;     
      filteredPosts = posts;    
      _postsFuture = Future.value(posts);
    });
  }

  void searchPost(String keyword) {
    List<Post> searchList = [];
    if (keyword.isEmpty) {
      searchList = allPosts;
    } else {
      searchList = allPosts
          .where(
            (post) => post.title.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
    setState(() {
      filteredPosts = searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JsonPlaceholder Posts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
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
                      onPressed: () => _loadPosts(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            if (filteredPosts.isEmpty) {
              return const Center(child: Text('No posts found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => searchPost(value),
                    decoration: InputDecoration(
                      labelText: 'Search by Title',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _loadPosts(),
                      child: ListView.builder(
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(child: Text('${post.id}')),
                              title: Text(
                                post.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPost(post: post),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}
