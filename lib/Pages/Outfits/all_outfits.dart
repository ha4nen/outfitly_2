import 'package:flutter/material.dart';
import 'dart:io';

import 'Catagories/Summer.dart';
import 'Catagories/Winter.dart';
import 'Catagories/Fall.dart';
import 'Catagories/Spring.dart';

class AllOutfitsPage extends StatefulWidget {
  final List<File> summerOutfits;
  final List<File> winterOutfits;
  final List<File> fallOutfits;
  final List<File> springOutfits;

  const AllOutfitsPage({
    super.key,
    required this.summerOutfits,
    required this.winterOutfits,
    required this.fallOutfits,
    required this.springOutfits, required List<File> outfits,
  });

  @override
  State<AllOutfitsPage> createState() => _AllOutfitsPageState();
}

class _AllOutfitsPageState extends State<AllOutfitsPage> {
  final Map<String, bool> _isEditingMap = {}; // Tracks editing state for each category
  final Set<int> _selectedItems = {}; // Tracks selected items for deletion
  bool _isUniversalEditing = false; // Tracks universal edit mode

  void _toggleEditMode(String categoryName) {
    setState(() {
      _isEditingMap[categoryName] = !(_isEditingMap[categoryName] ?? false);
      _selectedItems.clear(); // Clear selections when toggling modes
    });
  }

  void _toggleUniversalEditMode() {
    setState(() {
      _isUniversalEditing = !_isUniversalEditing;
      _isEditingMap.clear(); // Clear individual edit states
      _selectedItems.clear(); // Clear selections
    });
  }

  void _deleteSelectedItems(String categoryName, List<File> items) {
    setState(() {
      items.removeWhere((file) => _selectedItems.contains(items.indexOf(file)));
      _selectedItems.clear();
      _isEditingMap[categoryName] = false; // Exit edit mode after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button color set to white
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text(
          'All Outfits',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: IconButton(
                icon: Icon(
                  _isUniversalEditing ? Icons.delete : Icons.edit,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: _toggleUniversalEditMode,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summer Section
              _buildCategorySection('Summer', widget.summerOutfits, SummerOutfitsPage(outfits: widget.summerOutfits)),
              const SizedBox(height: 16),

              // Winter Section
              _buildCategorySection('Winter', widget.winterOutfits, WinterOutfitsPage(outfits: widget.winterOutfits)),
              const SizedBox(height: 16),

              // Fall Section
              _buildCategorySection('Fall', widget.fallOutfits, FallOutfitsPage(outfits: widget.fallOutfits)),
              const SizedBox(height: 16),

              // Spring Section
              _buildCategorySection('Spring', widget.springOutfits, SpringOutfitsPage(outfits: widget.springOutfits)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items, Widget destinationPage) {
    final isEditing = _isUniversalEditing || (_isEditingMap[categoryName] ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: IconButton(
                icon: Icon(isEditing ? Icons.delete : Icons.edit),
                onPressed: isEditing
                    ? () => _deleteSelectedItems(categoryName, items)
                    : () => _toggleEditMode(categoryName),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 150,
                color: Colors.grey[200], // Placeholder for items
                child: const Center(
                  child: Text('No outfits to display'),
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
                      onTap: isEditing
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