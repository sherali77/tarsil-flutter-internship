import 'package:flutter/material.dart';
import 'package:to_do_app/screens/display.dart';
import 'dart:math';

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
}

class TodoApp extends StatefulWidget {
  final List<ToDo> todoList;
  final VoidCallback onTaskChanged;

  const TodoApp({
    super.key,
    required this.todoList,
    required this.onTaskChanged,
  });
  @override
  State<TodoApp> createState() => _todoAppState();
}

class _todoAppState extends State<TodoApp> {
  // List<String> completedlist = [];
  final TextEditingController taskController = TextEditingController();
  String name = "";
  int counter = 0;
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
    : widget.todoList.map((task) => task.id).reduce((a, b) => a > b ? a : b) + 1;
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
                              if (widget.todoList[index].isDone) {
                                counter++;
                                // completedlist.add(todoItem.title);
                              } else {
                                counter--;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 20,
                          ),
                          onPressed: () {
                            TextEditingController editController =
                                TextEditingController(text: todoItem.title);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Edit Task"),
                                  content: TextField(
                                    controller: editController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Update task",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          todoItem.title = editController.text;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text('Edit'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete Task"),
                                  content: Text(
                                    "Are you sure to delete '${todoItem.title}' ?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.todoList.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.green,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return displayAll(task: todoItem);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    leading: Text(todoItem.id.toString()),
                    subtitle: Text(
                      "Time: ${todoItem.compAt.hour}:${todoItem.compAt.minute}  |  Date: ${todoItem.compAt.day}/${todoItem.compAt.month}/${todoItem.compAt.year}",
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            "You had done $counter tasks",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
