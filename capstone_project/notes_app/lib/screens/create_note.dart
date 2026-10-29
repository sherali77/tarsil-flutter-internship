import 'package:flutter/material.dart';
import 'package:notes_app/screens/model_class.dart';

class CreateNote extends StatefulWidget {
  List<Note> noteList;
  VoidCallback ontaskChanged;
  CreateNote({super.key, required this.noteList, required this.ontaskChanged});
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  String selectedCategory = 'Work';
  final List<String> categories = ['Work', 'Personal', 'Study'];

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int next = widget.noteList.isEmpty
        ? 1
        : widget.noteList
                  .map((task) => task.id)
                  .reduce((a, b) => a > b ? a : b) +
              1;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 234, 234),
      appBar: AppBar(
        title: const Text(
          "Create Note",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 73, 98, 109),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title TextField
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Enter note title...",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: "Content",
                hintText: "Write your note here...",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                final titleText = titleController.text.trim();
                if (titleText.isEmpty || titleText.length < 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Title is required and must be at least 3 characters!",
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.black87,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  setState(() {
                    widget.noteList.add(
                      Note(
                        id: next,
                        title: titleController.text,
                        content: bodyController.text,
                        category: selectedCategory,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                  });
                  widget.ontaskChanged();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Note created successfully!"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("Add Note"),
            ),
          ],
        ),
      ),
    );
  }
}
