import 'package:flutter/material.dart';
import 'todo_screen.dart';

class displayAll extends StatelessWidget {
  final ToDo task;
  const displayAll({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Display screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "The title of the current task is '${task.title}'",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "The id of the current task is '${task.id}'",
          ),
          SizedBox(height: 15),
          Text(
            "'${task.compAt}'",
          )
        ],
      ),
      )
    );
  }
}
