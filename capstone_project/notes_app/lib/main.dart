import 'package:flutter/material.dart';
import 'package:notes_app/providers/quote_provider.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/services/storage_services.dart';
import 'package:notes_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_provider.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NotesApp());
}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Notes App',
            themeMode: themeNotifier.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.amber,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.amber,
              brightness: Brightness.dark,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}