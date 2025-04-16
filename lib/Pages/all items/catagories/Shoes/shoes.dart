import 'package:flutter/material.dart';
import 'dart:io';

class ShoesPage extends StatelessWidget {
  final List<File> sneakers;
  final List<File> sandals;
  final List<File> highKneels;

  const ShoesPage({
    super.key,
    required this.sneakers,
    required this.sandals,
    required this.highKneels, required List<File> shoes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategorySection('Sneakers', sneakers),
              const SizedBox(height: 16),
              _buildCategorySection('Sandals', sandals),
              const SizedBox(height: 16),
              _buildCategorySection('HighKneels', highKneels),
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
                color: Colors.grey[200],
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
                        // Handle item click
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