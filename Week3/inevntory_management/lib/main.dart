import 'package:flutter/material.dart';
import 'package:inevntory_management/data/repositories/item_repo.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:inevntory_management/presentation/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(itemrepo: ItemRepo()),
      child: InventoryManagement(),
    ),
  );
}

class InventoryManagement extends StatelessWidget {
  const InventoryManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
