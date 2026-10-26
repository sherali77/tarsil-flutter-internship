import 'package:flutter/material.dart';
import 'package:to_do_app/screens/display.dart';


class ToDo {
  final int id;
  String title;
  bool isDone;
  final DateTime compAt;

  ToDo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.compAt,
  });

  // bool operator [](int other) {}
}

class TodoApp extends StatefulWidget {
  List<ToDo> todoList;
  VoidCallback onTaskChanged;
  final Function(List<ToDo>) onListUpdated;
    TodoApp({
    super.key,
    required this.todoList,
    required this.onTaskChanged,
    required this.onListUpdated,
  });
  @override
  State<TodoApp> createState() => _todoAppState();
}

class _todoAppState extends State<TodoApp> {
  // List<String> completedlist = [];
  final TextEditingController taskController = TextEditingController();
  String name = "";
  // List counter =
  // String flag = "";
  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int next = widget.todoList.isEmpty
        ? 1
        : widget.todoList
                  .map((task) => task.id)
                  .reduce((a, b) => a > b ? a : b) +
              1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do-App",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter task",
                      hintText: "Water refil...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("should not be empty!"),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.black87,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      setState(() {
                        widget.todoList.add(
                          ToDo(
                            id: next,
                            title: taskController.text,
                            compAt: DateTime.now(),
                          ),
                        );
                        taskController.clear();
                      });
                    }
                  },
                  child: const Text("add"),
                ),
              ],
            ),
          ),
          // Text("Your name is :  $name"),
          Expanded(
            child: ListView.builder(
              itemCount: widget.todoList.length,
              itemBuilder: (context, index) {
                final todoItem = widget.todoList[index];
                return Dismissible(
                  key: Key(todoItem.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      widget.todoList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${todoItem.title} deleted"),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            setState(() {
                              widget.todoList.insert(index, todoItem);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      widget.todoList[index].title,
                      style: TextStyle(
                        decoration: widget.todoList[index].isDone == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: widget.todoList[index].isDone == true
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: widget.todoList[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              widget.todoList[index].isDone = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    leading: Text(todoItem.id.toString()),
                    subtitle: Text(
                      "Time: ${todoItem.compAt.hour}:${todoItem.compAt.minute} | Date: ${todoItem.compAt.day}/${todoItem.compAt.month}/${todoItem.compAt.year}",
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsetsGeometry.all(16),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           IconButton(
             icon: const Icon(
               Icons.visibility,
               color: Colors.green,
               size: 40,
             ),
             onPressed: () async {
               final updatedList = await Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) {
                     return DisplayScreen(initialList: widget.todoList);
                   },
                 ),
               );
               if (updatedList != null) {
                 widget.onListUpdated(updatedList);
               }
             },
           ),
          Text(
            "You had done ${widget.todoList.where((task) => task.isDone).length} tasks out of '${widget.todoList.length}'",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
            ],
          ),
          )
        ],
      ),
    );
  }
}
