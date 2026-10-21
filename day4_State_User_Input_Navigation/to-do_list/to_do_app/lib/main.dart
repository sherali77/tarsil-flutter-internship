import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo app",
      theme: ThemeData(colorSchemeSeed: Colors.lightBlueAccent,
      useMaterial3: true,
      ),
      home: SignupScreen(),
    );
  }
}
