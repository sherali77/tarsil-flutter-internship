import 'package:flutter/material.dart';
import 'package:notes_app/screens/model_class.dart';

class CreateNote extends StatefulWidget {
  final Note? noteToEdit;
  final int? noteIndex;

  const CreateNote({super.key, this.noteToEdit, this.noteIndex});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedCategory = 'Work';

  final List<String> _categories = ['Work', 'Personal', 'Study'];

  @override
  void initState() {
    super.initState();
  
    _titleController = TextEditingController(
      text: widget.noteToEdit != null ? widget.noteToEdit!.title : '',
    );
    _contentController = TextEditingController(
      text: widget.noteToEdit != null ? widget.noteToEdit!.content : '',
    );
    
    if (widget.noteToEdit != null) {
      _selectedCategory = widget.noteToEdit!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text(
          'Create/Edit Note',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                final title = _titleController.text.trim();
                final content = _contentController.text.trim();

                if (title.isEmpty || content.isEmpty) return;
                final note = Note(
                  title: title,
                  content: content,
                  category: _selectedCategory, id: '', createdAt: DateTime.now().toIso8601String(), updatedAt:  DateTime.now().toIso8601String(),
                );
                Navigator.pop(context, note);
              },
              child: Text(
                 'Save Note',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}