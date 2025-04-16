import 'package:flutter/material.dart';
import 'dart:io';

class ShoesPage extends StatefulWidget {
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
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
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
          'Shoes',
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
              // Sneakers Section
              _buildCategorySection('Sneakers', widget.sneakers),
              const SizedBox(height: 16),

              // Sandals Section
              _buildCategorySection('Sandals', widget.sandals),
              const SizedBox(height: 16),

              // HighKneels Section
              _buildCategorySection('HighKneels', widget.highKneels),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items) {
    final isEditing = _isUniversalEditing || (_isEditingMap[categoryName] ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
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