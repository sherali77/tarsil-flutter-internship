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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: ListTile(
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${item.stock}"),
        trailing: Text(
          "Rs ${item.price}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: ontap,
      ),
    );
  }
}
