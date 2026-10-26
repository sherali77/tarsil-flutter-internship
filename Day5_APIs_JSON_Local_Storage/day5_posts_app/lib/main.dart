import 'package:day5_posts_app/screens/home.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatelessWidget {
  MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Posts",
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlueAccent,
        useMaterial3: true,
      ),
      home: ShowPosts(),
    );
  }
}
