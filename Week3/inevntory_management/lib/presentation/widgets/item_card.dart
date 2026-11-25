import 'package:flutter/material.dart';
import 'package:inevntory_management/models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback ontap;
  const ItemCard({super.key, required this.item, required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      color: Color.fromARGB(255, 69, 68, 68),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: ListTile(
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text("${item.stock}",style: TextStyle(color: Colors.white),),
        trailing: Text(
          "Rs ${item.price}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onTap: ontap,
      ),
    );
  }
}
