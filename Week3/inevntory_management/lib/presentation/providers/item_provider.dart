import 'package:flutter/material.dart';
import 'package:inevntory_management/core/errors/error_mapper.dart';
import 'package:inevntory_management/data/repositories/item_repo.dart';
import 'package:inevntory_management/models/item.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepo itemrepo;
  ItemProvider({required this.itemrepo});
  bool _isloading = false;
  List<Item> _itemList = [];
  String? _errormsg;
  bool get isLoading => _isloading;
  List<Item> get items => List.unmodifiable(_itemList);
  String? get errormsg => _errormsg;
  
  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> getItems() async {
    _itemList = await itemrepo.getAllItems();
  }

  Item? getItemById(int? id) {
    for (final item in _itemList) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Future<void> loadItems() async {
    setLoading(true);
    try {
      await getItems();
      _errormsg = "";
    } catch (e) {
      final faliure = ErrorMapper.map(e);
      _errormsg = faliure.message;
    } finally {
      setLoading(false);
    }
  }

  Future<void> addItem(Item item) async {
    setLoading(true);
    try {
      await itemrepo.addItem(item);
      _errormsg = '';
    } catch (e) {
      final failure = ErrorMapper.map(e);
      _errormsg = failure.message;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateItem(Item item) async {
    setLoading(true);
    try {
      await itemrepo.updateItem(item);
      _errormsg = '';
    } catch (e) {
      final failure = ErrorMapper.map(e);
      _errormsg = failure.message;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteItem(int id) async {
    setLoading(true);
    try {
      await itemrepo.deleteItem(id);
    } catch (e) {
      final failure = ErrorMapper.map(e);
      _errormsg = failure.message;
    } finally {
      setLoading(false);
    }
  }
}
