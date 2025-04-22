// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String itemName;
  final String color;
  final String size;
  final String season;
  final List<String> tags;

  const ItemDetails({
    super.key,
    required this.itemName,
    required this.color,
    required this.size,
    required this.season,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName), // Display the item name in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image Container
            Center(
              child: Container(
                width: 200, // Fixed width
                height: 200, // Fixed height
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder background color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/example_item.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Item Name
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Item Details
            Text(
              'Details:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text('Colour: $color', style: const TextStyle(fontSize: 16)),
            Text('Size: $size', style: const TextStyle(fontSize: 16)),
            Text('Season: $season', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Tags
            Text(
              'Tags:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}