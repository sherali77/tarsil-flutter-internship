import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/services/database_service.dart';

class ItemRepo {
  Future<List<Item>> getAllItems() async {
    try {
      return await DatabaseService.instance.getAllItems();
    } catch (e) {
      throw Exception("databse failed in load items");
    }
  }

  Future<void> addItem(Item item) async {
    try {
      return await DatabaseService.instance.addItem(item);
    } catch (e) {
      throw Exception("Database failed to add item");
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      return await DatabaseService.instance.updateItem(item);
    } catch (e) {
      throw Exception("database failed in updating item");
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      return await DatabaseService.instance.deleteItem(id);
    } catch (e) {
      throw Exception("database failed in deleting item");
    }
  }
}
