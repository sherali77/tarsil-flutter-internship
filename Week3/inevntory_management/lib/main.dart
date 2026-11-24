import 'package:flutter/material.dart';
import 'package:inevntory_management/presentation/screens/home_page.dart';

void main() {
  runApp(const InventoryManagement());
}

class InventoryManagement extends StatelessWidget {
  const InventoryManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
