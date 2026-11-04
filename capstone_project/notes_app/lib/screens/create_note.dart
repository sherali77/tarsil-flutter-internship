import 'package:flutter/material.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/services/storage_services.dart';
import 'package:notes_app/widgets/validator.dart';

class CreateNote extends StatefulWidget {
  final Note? noteToEdit;
  final int? noteIndex;

  const CreateNote({super.key, this.noteToEdit, this.noteIndex});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text(
          widget.noteToEdit == null ? 'Create Note' : 'Edit Note',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
                validator: Validator().validateTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  filled: true,
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final title = _titleController.text.trim();
                    final content = _contentController.text.trim();

                    final note = Note(
                      title: title,
                      content: content,
                      category: _selectedCategory,
                      createdAt: widget.noteToEdit != null
                          ? widget.noteToEdit!.createdAt
                          : DateTime.now(),
                      updatedAt: DateTime.now(),
                      id: widget.noteToEdit != null ? widget.noteToEdit!.id : 0,
                    );
                    Navigator.pop(context, note);
                  }
                },
                child: Text(
                  widget.noteToEdit == null ? 'Save Note' : 'Update Note',
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
      ),
    );
  }
}
