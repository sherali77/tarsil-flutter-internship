import 'package:notes_app/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDb {
  database()async{
    final database = openDatabase(
  join(await getDatabasesPath(), 'notes_database.db'),
  onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, category TEXT, createdAt TEXT, updatedAt TEXT)',
    );
  },
  version: 1,
);
}
}