import 'package:flutter/material.dart';
import 'package:inevntory_management/models/item.dart';
import 'package:inevntory_management/presentation/providers/item_provider.dart';
import 'package:inevntory_management/presentation/screens/create_item.dart';
import 'package:inevntory_management/presentation/utils/date_format.dart';
import 'package:inevntory_management/presentation/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailItem extends StatelessWidget {
  final Item item;
  const DetailItem({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Screen",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 200, 189, 189)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 69, 68, 68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ItemProvider>(
          builder: (context, itemProvider, child) {
            final currentItem = itemProvider.getItemById(item.id) ?? item;
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentItem.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$ ${currentItem.price}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sku: ${currentItem.sku}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'stock: ${currentItem.stock}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Chip(
                      label: Text(
                        (currentItem.syncStatus),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                      (DateFormat.format(currentItem.updatedAt)),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green, size: 24),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CreateItem(itemEdit: currentItem);
                                },
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 24),
                          onPressed: () {
                            DeleteDialog().showDeleteConfirmation(
                              context,
                              currentItem.id,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
