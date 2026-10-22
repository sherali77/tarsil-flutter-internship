import 'package:flutter/material.dart';

import 'todo_screen.dart';
import 'profile_screen.dart';
import 'completed.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});
  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  List<ToDo> todoList = [];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final completedTasks = todoList
        .where((task) => task.isDone == true)
        .map((task) => task.title)
        .toList();
       final List<Widget> _screens = [
      const ProfileApp(),
      TodoApp(
        todoList: todoList, 
        onTaskChanged: () {
          setState(() {}); 
        },
      ),
      showCompleted(completedTask: completedTasks), 
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome to Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
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
          NavigationDestination(
            icon: Icon(Icons.done, color: Colors.green),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
