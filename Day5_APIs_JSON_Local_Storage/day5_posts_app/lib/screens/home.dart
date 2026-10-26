import 'package:flutter/material.dart';

class ShowPosts extends StatefulWidget {
  ShowPosts({super.key});

  @override
  @override
  State<ShowPosts> createState() => _showPosts();
}

class _showPosts extends State<ShowPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
