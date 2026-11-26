import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:provider/provider.dart';

class CreateItem extends StatefulWidget {
  final Item? itemEdit;
  const CreateItem({super.key, this.itemEdit});
  @override
  State<StatefulWidget> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _skuController;
  late TextEditingController _stockController;
  late TextEditingController _syncStatus;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.itemEdit != null ? widget.itemEdit!.name : '',
    );
     _priceController = TextEditingController(
      text: widget.itemEdit != null ?  widget.itemEdit!.price.toString() : '',
    );
     _skuController = TextEditingController(
      text: widget.itemEdit != null ? widget.itemEdit!.sku : '',
    );
     _stockController = TextEditingController(
      text: widget.itemEdit != null ? widget.itemEdit!.stock.toString() : '',
    );
     _syncStatus = TextEditingController(
      text: widget.itemEdit != null ? widget.itemEdit!.syncStatus : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _skuController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final provider = context.read<ItemProvider>();
    final name = _nameController.text.trim();
    final price = int.parse(_priceController.text);
    final sku = _skuController.text.trim();
    final stock = int.parse(_stockController.text);
    final status = _syncStatus.text.trim();
    final editing = widget.itemEdit;
    if (editing == null) {
      final item = Item(
        id: null,
        name: name,
        price: price,
        sku: sku,
        stock: stock,
        syncStatus: status,
      );
      await provider.addItem(item);
    } else {
      final updated = editing.copywith(
        id: null,
        name: name,
        price: price,
        sku: sku,
        stock: stock,
        syncStatus: status,
      );
     await provider.updateItem(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add Screen",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 200, 189, 189)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 69, 68, 68),
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
