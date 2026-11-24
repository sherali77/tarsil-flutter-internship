import 'package:flutter/material.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:inevntory_management/presentation/screens/create_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    context.read<ItemProvider>().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<ItemProvider>(
            builder: (context, itemProvider, child) {
              List<Item> itemList = itemProvider.items;
              if (itemProvider.isLoading && itemList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (itemProvider.errormsg != null && itemList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(itemProvider.errormsg!),
                    ElevatedButton.icon(
                      onPressed: () => itemProvider.loadItems(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                );
              }
              return Text("done");//tommarow i will continue from here
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 14),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateItem()),
          );
        },
      ),
    );
  }
}
