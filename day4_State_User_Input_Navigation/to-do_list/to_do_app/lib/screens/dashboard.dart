import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

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
  bool isDark = true;
  // bool flag = true;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadList();
  }

  Future<void> _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('saved_tasks');
    if (tasksString != null) {
      final List<dynamic> decodedList = jsonDecode(tasksString);
      setState(() {
        todoList = decodedList.map((item) => ToDo.fromJson(item)).toList();
      });
    }
  }

  Future<void> _savedList() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(
      todoList.map((task) => task.toJson()).toList(),
    );
    await prefs.setString('saved_tasks', encodedList);
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = todoList
        .where((task) => task.isDone == true)
        .map((task) => task.title)
        .toList();
    final List<Widget> screens = [
      ProfileScreen(
        onThemeChanged: (bool flag) {
          setState(() {
            isDark = flag;
          });
        },
      ),
      TodoApp(
        todoList: todoList,
        onTaskChanged: () {
          setState(() {});
          _savedList();
        },
        onListUpdated: (newList) {
          setState(() {
            todoList = newList;
          });
          _savedList();
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
        leading: IconButton(
          icon: Icon(Icons.logout,color: Colors.red,size: 20,),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool("is logged in", false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignupScreen(isLogedin: (flag) {}),
              ),
            );
          },
        ),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _savedList();
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
