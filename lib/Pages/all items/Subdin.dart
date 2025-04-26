import 'package:flutter/material.dart';

class SubDIn extends StatelessWidget {
  final String subCategory;

  const SubDIn({Key? key, required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final items = {
      'Electronics': ['Laptop', 'Smartphone', 'Tablet'],
      'Clothing': ['Shirt', 'Pants', 'Jacket'],
      'Books': ['Fiction', 'Non-fiction', 'Comics'],
    };

    // Get items for the selected subcategory
    final subCategoryItems = items[subCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Items in $subCategory'),
      ),
      body: ListView.builder(
        itemCount: subCategoryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subCategoryItems[index]),
          );
        },
      ),
    );
  }
}