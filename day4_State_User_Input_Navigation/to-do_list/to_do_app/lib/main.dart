import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class ToDo {
  final int id;
  final String title;
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
                                  id: DateTime.now().millisecondsSinceEpoch,
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
                    itemBuilder: (context, index){
                        final todoItem = todoList[index];
                        return Dismissible(
                          key: Key(todoItem.id.toString()),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
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
                            trailing: Checkbox(
                              value: todoList[index].isDone,
                              onChanged: (value) {
                                setState(() {
                                  todoList[index].isDone = value!;
                                });
                              },
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
