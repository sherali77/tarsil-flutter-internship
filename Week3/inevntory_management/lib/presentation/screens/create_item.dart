import 'package:flutter/material.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});
  @override
  State<StatefulWidget> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _skuController=TextEditingController();
  final TextEditingController _stockController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "name",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: "price",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(
                  labelText: "sku",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(
                  labelText: "stock",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 25,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color.fromARGB(255, 89, 205, 255),
                ),
                child: Text("Add Item"),
                onPressed: () {
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
