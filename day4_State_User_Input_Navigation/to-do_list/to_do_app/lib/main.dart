import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/screens/dashboard.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool islog = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      islog = prefs.getBool('is logged in') ?? false;
      isLoading = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo app",
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlueAccent,
        useMaterial3: true,
      ),
      home: islog
          ? const MainDashboardScreen(showEmail: "") 
          : SignupScreen(
              isLogedin: (bool flag) {
                setState(() {
                  islog = flag;
                });
              },
            ),
    );
  }
}