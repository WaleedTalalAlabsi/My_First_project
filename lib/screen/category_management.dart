import 'package:flutter/material.dart';
import 'package:flutter_shopping_app_with_api/screen/components/customtextform.dart';
import 'package:flutter_shopping_app_with_api/screen/dashboard.dart';

class CategoriesScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final navigationController = Provider.of<NavigationController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
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
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Add New Category',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                    // Replacing TextField with CustomTextFormField
                    CustomTextFormSign(
                      mycontroller: nameController,
                      hint: 'Please Enter your Name',
                    ),
                    CustomTextFormSign(
                      mycontroller: descriptionController,
                      hint: 'Please Enter Description',
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Add category functionality here
                          },
                          child: const Text('Add Category'),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            // Cancel action
                            nameController.clear();
                            descriptionController.clear();
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
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('2')),
                        const DataCell(Text('Dining Set')),
                        const DataCell(Text('fa-utensils-alt')),
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
