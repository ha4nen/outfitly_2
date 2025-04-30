import 'package:flutter/material.dart';

class SubDIn extends StatelessWidget {
  final String subCategory;

  const SubDIn({super.key, required this.subCategory});

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
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Dynamic app bar color
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor, // Dynamic text color
      ),
      body: ListView.builder(
        itemCount: subCategoryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              subCategoryItems[index],
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color), // Dynamic text color
            ),
          );
        },
      ),
    );
  }
}