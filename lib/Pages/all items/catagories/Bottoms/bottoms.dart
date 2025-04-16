import 'package:flutter/material.dart';
import 'dart:io';

class BottomsPage extends StatelessWidget {
  final List<File> jeans;
  final List<File> shorts;
  final List<File> joggers;

  const BottomsPage({
    super.key,
    required this.jeans,
    required this.shorts,
    required this.joggers, required List<File> bottoms,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bottoms',
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
              _buildCategorySection('Jeans', jeans),
              const SizedBox(height: 16),
              _buildCategorySection('Shorts', shorts),
              const SizedBox(height: 16),
              _buildCategorySection('Joggers', joggers),
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