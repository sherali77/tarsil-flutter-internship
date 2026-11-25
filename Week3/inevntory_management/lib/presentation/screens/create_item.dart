import 'package:flutter/material.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:provider/provider.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});
  @override
  State<StatefulWidget> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _syncStatus = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _skuController.dispose();
    _stockController.dispose();
  }

  Future<void> _save() async {
    final provider = context.read<ItemProvider>();
    final name = _nameController.text.trim();
    final price = int.parse(_priceController.text);
    final sku = _skuController.text.trim();
    final stock = int.parse(_stockController.text);
    final status = _syncStatus.text.trim();
    final item = Item(
      id: null,
      name: name,
      price: price,
      sku: sku,
      stock: stock,
      syncStatus: status,
    );
    provider.addItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Create Item",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Expanded(
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "name",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "price",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _skuController,
                  decoration: InputDecoration(
                    labelText: "sku",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "stock",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _syncStatus,
                  decoration: InputDecoration(
                    labelText: "status",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 66, 76, 80),
                  ),
                  child: Text(
                    "Add Item",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    _save();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
