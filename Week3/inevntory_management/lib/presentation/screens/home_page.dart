import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:inevntory_management/presentation/screens/create_item.dart';
import 'package:inevntory_management/presentation/screens/detail_Item.dart';
import 'package:inevntory_management/presentation/widgets/empty_state.dart';
import 'package:inevntory_management/presentation/widgets/item_card.dart';
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
    Future.microtask(() {
      if (!mounted) return;
      context.read<ItemProvider>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: GoogleFonts.poppins(fontSize: 25 ,fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 200, 189, 189)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 69, 68, 68),
      ),
      body:Column(
      children: [
        SizedBox(height: 20,),
        Text("Product List",
        style: GoogleFonts.poppins(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: const Color.fromARGB(255, 21, 9, 125),
        ),
        textAlign: TextAlign.center,
        ),
        SizedBox(height: 30,),
        Expanded(
        child: Consumer<ItemProvider>(
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
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => itemProvider.loadItems(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ),
                ],
              );
            }
            if (itemList.isEmpty) {
              return Center(child: EmptyState(message: "No Items yet"));
            }
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ItemProvider>().loadItems();
              },
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  final item = itemList[index];
                  return ItemCard(
                    item: item,
                    index: index,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailItem(item: item)),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
      ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 69, 68, 68),
        child: Icon(Icons.add, size: 18,color: Colors.white,),
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
