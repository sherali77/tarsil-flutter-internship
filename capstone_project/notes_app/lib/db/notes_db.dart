import 'package:notes_app/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? notesdb;
  Future<Database>? _databaseFuture;
  DatabaseService._init();
  static final TABLE_NAME = 'notes';
  static final ID_COLUMN = 'id';
  static final TITLE_COLUMN = 'title';
  static final CONTENT_COLUMN = 'content';
  static final CATEGORY_COLUMN = 'category';
  static final ISPINNED_COLUMN = 'isPinned';
  static final ISARCHIVED_COLUMN = 'isArchived';
  static final UPDATEDat_COLUMN = 'updatedAt';
  static final CREATEDat_COLUMN = 'createdAt';

  Future<Database> get database async {
    if (notesdb != null) return notesdb!;
    _databaseFuture ??= _initDb('notes.db');
    notesdb = await _databaseFuture!;
    return notesdb!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_NAME (
        $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT,
        $TITLE_COLUMN TEXT NOT NULL,
        $CONTENT_COLUMN TEXT NOT NULL,
        $CATEGORY_COLUMN TEXT NOT NULL,
        $CREATEDat_COLUMN TEXT NOT NULL,
        $UPDATEDat_COLUMN TEXT NOT NULL,
        $ISPINNED_COLUMN INTEGER DEFAULT 0,
        $ISARCHIVED_COLUMN INTEGER DEFAULT 0
      )
    ''');
  }

  Future<List<Note>> getAllNotes({String? orderBy}) async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseService.TABLE_NAME,
        orderBy: orderBy,
      );
      return maps.map((e) => Note.fromMap(e)).toList();
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database failed in loading notes: $e'),
        stackTrace,
      );
    }
  }

  Future<void> addNote(Note note) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert(
        DatabaseService.TABLE_NAME,
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database insert failed: $e'),
        stackTrace,
      );
    }
  }

  Future<void> editNote(Note note) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        DatabaseService.TABLE_NAME,
        note.toMap(),
        where: "id=?",
        whereArgs: [note.id],
      );
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database update failed: $e'),
        stackTrace,
      );
    }
  }

  Future<void> deleteNote(int? id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        DatabaseService.TABLE_NAME,
        where: "id=?",
        whereArgs: [id],
      );
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database delete failed: $e'),
        stackTrace,
      );
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(DatabaseService.TABLE_NAME);
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Database deleteAll failed: $e'),
        stackTrace,
      );
    }
  }

  Future<void> togglePin(int id, bool isPinned) async {
    try {
      final db = await DatabaseService.instance.database;

      await db.update(
        DatabaseService.TABLE_NAME,
        {'isPinned': isPinned ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Databse pin note failed'),
        stackTrace,
      );
    } 
  }

   Future<void> archiveNote(int id, bool isArchived) async {
    try {
      final db = await DatabaseService.instance.database;

      await db.update(
        DatabaseService.TABLE_NAME,
        {'isArchived': isArchived ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Databse pin note failed'),
        stackTrace,
      );
    } 
  }

  Future<void> close() async {
    await notesdb!.close();
    notesdb = null;
    _databaseFuture = null;
  }
}
