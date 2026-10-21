import 'package:flutter/material.dart';

import 'todo_screen.dart';
import 'profile_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});
  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}
class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    // const HomeTab(),
    // const SignupScreen(),
    const ProfileApp(),
    const TodoApp(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person, color: Colors.red),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.list, color: Colors.blue),
            label: 'To-Do',
          ),
        ],
      ),
    );
  }
}
