import 'package:flutter/material.dart';

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
  const TodoApp({super.key});
  @override
  State<TodoApp> createState() => _todoAppState();
}

class _todoAppState extends State<TodoApp> {
  List<ToDo> todoList = [];
  final TextEditingController taskController = TextEditingController();
  String name = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("To-Do-App", style: TextStyle(fontSize: 18)),
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
                          if (taskController.text.isEmpty) {
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
                              todoList.add(
                                ToDo(
                                  id: todoList.length + 1,
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
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todoItem = todoList[index];
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
                            todoList.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${todoItem.title} deleted"),
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () {
                                  setState(() {
                                    todoList.insert(index, todoItem);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            todoList[index].title,
                            style: TextStyle(
                              decoration: todoList[index].isDone == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todoList[index].isDone == true
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: todoList[index].isDone,
                                onChanged: (value) {
                                  setState(() {
                                    todoList[index].isDone = value!;
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
                                      TextEditingController(
                                        text: todoItem.title,
                                      );
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
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                todoItem.title =
                                                    editController.text;
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
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                todoList.removeAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Display"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text("The title is : '${todoItem.title.toString()}' "),
                                            SizedBox(height: 10),
                                            Text(
                                            "Time: ${todoItem.compAt.hour}:${todoItem.compAt.minute}  |  Date: ${todoItem.compAt.day}/${todoItem.compAt.month}/${todoItem.compAt.year}"),
                                            SizedBox(height: 10),
                                            Text("Id is : '${todoItem.id.toString()}'"),
                                          ],
                                        ),
                                      );
                                    },
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
              ],
            ),
          );
        },
      ),
    );
  }
}
