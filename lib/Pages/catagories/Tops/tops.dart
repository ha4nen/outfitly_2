import 'package:flutter/material.dart';
import 'dart:io';

class TopsPage extends StatelessWidget {
  final List<File> tops; // List of all tops items
  final List<File> tShirts; // List of T-shirts
  final List<File> shirts; // List of Shirts
  final List<File> longSleeves; // List of LongSleeves

  const TopsPage({
    super.key,
    required this.tops,
    required this.tShirts,
    required this.shirts,
    required this.longSleeves,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // Handle navigation or action when "Tops" is clicked
          },
          child: const Text(
            'Tops',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
        ),
        backgroundColor: Colors.black, // Set background color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // T-Shirts Section
              _buildCategorySection('T-Shirts', tShirts),
              const SizedBox(height: 16),

              // Shirts Section
              _buildCategorySection('Shirts', shirts),
              const SizedBox(height: 16),

              // LongSleeves Section
              _buildCategorySection('LongSleeves', longSleeves),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Handle navigation or action when the subcategory is clicked
          },
          child: Text(
            categoryName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 150,
                color: Colors.grey[200], // Placeholder for items
                child: const Center(
                  child: Text('No items to display'),
                ),
              )
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle item click (e.g., navigate to details page)
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: FileImage(items[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}