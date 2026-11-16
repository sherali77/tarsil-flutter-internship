import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? notesdb;
  DatabaseService._init();
  static final TABLE_NAME = 'notes';
  static final ID_COLOUMN = 'id';
  static final TITLE_COLOUMN = 'title';
  static final CONTENT_COLOUMN = 'content';
  static final CATEGORY_TABLE = 'category';
  static final UPDATEDat_TABLE = 'updatedAt';
  static final CREATEDat_TABLE = 'createdAt';
  Future<Database> get database async {
    if (notesdb != null) return notesdb!;
    notesdb = await _initDb('notes.db');
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
        $ID_COLOUMN INTEGER PRIMARY KEY AUTOINCREMENT,
        $TITLE_COLOUMN TEXT NOT NULL,
        $CONTENT_COLOUMN TEXT NOT NULL,
        $CATEGORY_TABLE TEXT NOT NULL,
        $CREATEDat_TABLE TEXT NOT NULL,
        $UPDATEDat_TABLE TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
