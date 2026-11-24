import 'package:inevntory_management/core/errors/app_exceptions.dart';
import 'package:inevntory_management/data/services/database_service.dart';
import 'package:inevntory_management/models/item.dart';

class ItemRepo {
  Future<List<Item>> getAllItems() async {
    try {
      return await DatabaseService.instance.getAllItems();
    } on AppExceptions {
      rethrow;
    } catch (e, stackTrace) {
      throw UnexpectedExeption(
        message: "failed to retrieve items",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> addItem(Item item) async {
    try {
      return await DatabaseService.instance.addItem(item);
    } on AppExceptions {
      rethrow;
    } catch (e, stackTrace) {
      throw UnexpectedExeption(
        message: "failed to add item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      return await DatabaseService.instance.updateItem(item);
    } on AppExceptions {
      rethrow;
    } catch (e, stackTrace) {
      throw UnexpectedExeption(
        message: "failed to update item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      return await DatabaseService.instance.deleteItem(id);
    } on AppExceptions {
      rethrow;
    } catch (e, stackTrace) {
      throw UnexpectedExeption(
        message: "failed to delete item",
        orignalError: e,
        stackTrace: stackTrace,
      );
    }
  }
}
