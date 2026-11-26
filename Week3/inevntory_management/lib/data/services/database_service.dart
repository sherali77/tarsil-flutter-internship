import 'dart:async';

import 'package:inevntory_management/core/errors/app_exceptions.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  Future<Database>? _db;
  Future<Database> get database async => _db ??= _initdb('inventory.db');
  DatabaseService._();
  static final tableName = 'inventory';
  static final idColumn = 'id';
  static final nameColumn = 'name';
  static final priceColumn = 'price';
  static final skuColumn = 'sku';
  static final stockcolumn = 'stock';
  static final updatedAtColumn = 'updatedAt';
  static final syncStatusColumn = 'syncStatus';
  Future<Database> _initdb(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName(
    $idColumn INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $nameColumn TEXT NOT NULL,
    $priceColumn INT NOT NULL,
    $skuColumn TEXT NOT NULL,
    $stockcolumn INT NOT NULL,
    $updatedAtColumn TEXT NOT NULL,
    $syncStatusColumn TEXT NOT NULL
    )
  ''');
  }

  Future<List<Item>> getAllItems() async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseService.tableName,
      );
      return maps.map((e) => Item.frommap(e)).toList();
    } on DatabaseException catch (e, stackTrace) {
      throw DataBaseException(
        message: "failed to load items",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> addItem(Item item) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert(
        DatabaseService.tableName,
        item.tomap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e, stackTrace) {
      throw DataBaseException(
        message: "failed to add item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(DatabaseService.tableName, item.tomap(),where: "id=?", whereArgs: [item.id]);
    } on DatabaseException catch (e, stackTrace) {
      throw DataBaseException(
        message: "failed to update item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        DatabaseService.tableName,
        where: "id=?",
        whereArgs: [id],
      );
    } on DatabaseException catch (e, stackTrace) {
      throw DataBaseException(
        message: "failed to delete item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> close() async {
    final db = await _db;
    await db!.close();
    _db = null;
  }
}
