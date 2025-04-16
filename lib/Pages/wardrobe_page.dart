// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/all%20items/all_items_page.dart';
import 'package:flutter_application_1/Pages/Outfits/all_outfits.dart';
import 'dart:io';
import 'item_details_page.dart';

class WardrobePage extends StatefulWidget {
  final List<File> items;

  const WardrobePage({super.key, required this.items});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
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
          'Wardrobe',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Items Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page to view all items
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllItemsPage(
                          items: widget.items,
                          tops: [],
                          bottoms: [],
                          accessories: [],
                          shoes: [],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color set to black
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Items',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_isEditing ? Icons.delete : Icons.edit),
                  onPressed: _isEditing ? _deleteSelectedItems : _toggleEditMode,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Items Section
            widget.items.isEmpty
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
                      itemCount: widget.items.length,
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
                                  // Navigate to the ItemDetailsPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetailsPage(item: widget.items[index]),
                                    ),
                                  );
                                },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  widget.items[index],
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

            const SizedBox(height: 16), // Add spacing between sections

            // Outfits Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page to view all outfits
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllOutfitsPage(
                          outfits: widget.items,
                          summerOutfits: [],
                          winterOutfits: [],
                          fallOutfits: [],
                          springOutfits: [],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color set to black
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Outfits',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_isEditing ? Icons.delete : Icons.edit),
                  onPressed: _isEditing ? _deleteSelectedItems : _toggleEditMode,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Outfits Section
            widget.items.isEmpty
                ? Container(
                    height: 150,
                    color: Colors.grey[200], // Placeholder for outfits
                    child: const Center(
                      child: Text('No outfits to display'),
                    ),
                  )
                : SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.items.length,
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
                                  // Navigate to the ItemDetailsPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetailsPage(item: widget.items[index]),
                                    ),
                                  );
                                },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  widget.items[index],
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
        ),
      ),
    );
  }
}