import 'package:flutter/material.dart';

import 'login_page.dart';
import 'todo_screen.dart';

class DisplayScreen extends StatefulWidget {
  final List<ToDo> initialList;
  const DisplayScreen({super.key, required this.initialList});
  // const DisplayScreen({super.key, required this.Task});
  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  late List<ToDo> localList;
  @override
  void initState() {
    super.initState();
    localList = List.from(widget.initialList);
  }

  @override
  Widget build(BuildContext context) {
    String status = "";
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, localList);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Display screen",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: localList.length,
                  itemBuilder: (context, index) {
                    final localItem = localList[index];
                    if (localItem.isDone == true) {
                      status = "done";
                    } else if (localItem.isDone == false) {
                      status = "pending";
                    }
                    return ListTile(
                      title: Text(
                        localItem.title,
                        style: TextStyle(
                          decoration: localItem.isDone == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: localItem.isDone == true
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      leading: Text("${localItem.id}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 20,
                            ),
                            onPressed: localItem.isDone == true
                                ? null
                                : () {
                                    TextEditingController editController =
                                        TextEditingController(
                                          text: localItem.title,
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
                                                  localItem.title =
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
                                      "Are you sure to delete '${localItem.title}' ?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            localList.removeWhere(
                                              (item) => item.id == localItem.id,
                                            );
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
                          Text(status),
                        ],
                      ),
                      subtitle: Text(
                        "Time: ${localItem.compAt.hour}:${localItem.compAt.minute} | Date: ${localItem.compAt.day}/${localItem.compAt.month}/${localItem.compAt.year}",
                        style: TextStyle(fontSize: 8),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// extension on bool {
//   get isDone => null;
// }
