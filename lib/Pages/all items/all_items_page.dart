// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/Pages/item_details_page.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Tops/tops.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Bottoms/bottoms.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Accessories/accessories.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Shoes/shoes.dart';

class AllItemsPage extends StatefulWidget {
  final List<File> items;
  final List<File> tops;
  final List<File> bottoms;
  final List<File> accessories;
  final List<File> shoes;

  const AllItemsPage({
    super.key,
    required this.items,
    required this.tops,
    required this.bottoms,
    required this.accessories,
    required this.shoes,
  });

  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  bool _isEditing = false; // Tracks whether the user is in edit mode
  final Set<int> _selectedItems = {}; // Tracks selected items for deletion

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      _selectedItems.clear(); // Clear selections when toggling modes
    });
  }

  void _deleteSelectedItems() {
    setState(() {
      widget.items.removeWhere((file) => _selectedItems.contains(widget.items.indexOf(file)));
      _selectedItems.clear();
      _isEditing = false; // Exit edit mode after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Items',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.delete : Icons.edit), // Pencil or Bin icon
            onPressed: _isEditing ? _deleteSelectedItems : _toggleEditMode,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tops Section
              _buildCategorySection('Tops', widget.tops, TopsPage(tops: widget.tops, tShirts: [], shirts: [], longSleeves: [],)),
              const SizedBox(height: 16),

              // Bottoms Section
              _buildCategorySection('Bottoms', widget.bottoms, BottomsPage(bottoms: widget.bottoms, jeans: [], shorts: [], joggers: [],)),
              const SizedBox(height: 16),

              // Accessories Section
              _buildCategorySection('Accessories', widget.accessories, AccessoriesPage(accessories: widget.accessories, bracelets: [], handBags: [], rings: [], necklaces: [],)),
              const SizedBox(height: 16),

              // Shoes Section
              _buildCategorySection('Shoes', widget.shoes, ShoesPage(shoes: widget.shoes, sneakers: [], sandals: [], highKneels: [],)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items, Widget destinationPage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the related page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destinationPage),
                );
              },
              child: Text(
                categoryName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            IconButton(
              icon: Icon(_isEditing ? Icons.delete : Icons.edit),
              onPressed: _isEditing ? _deleteSelectedItems : _toggleEditMode,
            ),
          ],
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
                    final isSelected = _selectedItems.contains(index);
                    return GestureDetector(
                      onTap: _isEditing
                          ? () {
                              setState(() {
                                if (isSelected) {
                                  _selectedItems.remove(index);
                                } else {
                                  _selectedItems.add(index);
                                }
                              });
                            }
                          : () {
                              // Handle item click (e.g., navigate to details page)
                            },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              items[index],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              color: isSelected
                                  ? Colors.black.withOpacity(0.5)
                                  : null,
                              colorBlendMode: isSelected
                                  ? BlendMode.darken
                                  : null,
                            ),
                          ),
                          if (isSelected)
                            const Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}