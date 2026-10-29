import 'package:flutter/material.dart';
// import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/screens/home_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Home page',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

