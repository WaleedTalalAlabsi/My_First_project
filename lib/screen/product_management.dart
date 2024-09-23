import 'package:flutter/material.dart';
import 'package:flutter_shopping_app_with_api/screen/components/customtextform.dart';
import 'package:flutter_shopping_app_with_api/screen/dashboard.dart';

class ProductsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Welcome, User'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Add logout functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Add New Product',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                    // Replacing TextField with CustomTextFormField
                    CustomTextFormSign(
                      mycontroller: nameController,
                      hint: 'Please Enter your Name',
                    ),
                    CustomTextFormSign(
                      mycontroller: priceController,
                      hint: 'Please Enter Price',
                    ),
                    CustomTextFormSign(
                      mycontroller: descriptionController,
                      hint: 'Please Enter Description',
                    ),

                    ElevatedButton(
                      onPressed: () {
                        // Choose file functionality here
                      },
                      child: const Text('Choose File'),
                    ),

                    CustomTextFormSign(
                      mycontroller: typeController,
                      hint: 'Enter Product Type',
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Add product functionality here
                          },
                          child: const Text('Add Product'),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            // Cancel action
                            nameController.clear();
                            priceController.clear();
                            descriptionController.clear();
                            typeController.clear();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('Image')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Chair')),
                        const DataCell(Text('This chair')),
                        const DataCell(Text('10000.00')),
                        const DataCell(Text('Image')),
                        const DataCell(Text('Furniture')),
                        DataCell(Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Edit action
                              },
                              child: const Text('Edit'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete action
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        )),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
