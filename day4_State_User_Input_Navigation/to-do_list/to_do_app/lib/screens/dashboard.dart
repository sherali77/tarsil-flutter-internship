import 'package:flutter/material.dart';

import 'todo_screen.dart';
import 'profile_screen.dart';
import 'completed.dart';
import 'login_page.dart';

class MainDashboardScreen extends StatefulWidget {
  final dynamic showEmail;

  const MainDashboardScreen({super.key, required this.showEmail});
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
       final List<Widget> screens = [
      const ProfileApp(),
      TodoApp(
        todoList: todoList, 
        onTaskChanged: () {
          setState(() {}); 
        },
        onListUpdated: (newList) {
            setState(() {
            todoList = newList; 
    });
      },
      ),
      showCompleted(completedTask: completedTasks), 
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome!  ${widget.showEmail}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: screens[_currentIndex],
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
