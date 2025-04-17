import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/Pages/all%20items/catagories/Tops/tops.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Bottoms/bottoms.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Accessories/accessories.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Shoes/shoes.dart';

class AllItemsPage extends StatefulWidget {
  final Map<String, List<File>> categorizedTops;
  final Map<String, List<File>> categorizedBottoms;
  final Map<String, List<File>> categorizedAccessories;
  final Map<String, List<File>> categorizedShoes;

  const AllItemsPage({
    super.key,
    required this.categorizedTops,
    required this.categorizedBottoms,
    required this.categorizedAccessories,
    required this.categorizedShoes,
  });

  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  final Set<String> _sectionsMarkedForDelete = {};
  bool _isDeleteMode = false;

  void _showAddCategoryDialog() {
    String newCategory = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF6F1E1),
          title: const Text("Add New Section", style: TextStyle(color: Color(0xFF2C3E50))),
          content: TextField(
            decoration: const InputDecoration(hintText: "Section name"),
            onChanged: (value) {
              newCategory = value;
            },
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9B1B30)),
              child: const Text("Add", style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (newCategory.isNotEmpty &&
                    !widget.categorizedTops.containsKey(newCategory)) {
                  setState(() {
                    widget.categorizedTops[newCategory] = [];
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(String categoryName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF6F1E1),
        title: const Text('Confirm Deletion', style: TextStyle(color: Color(0xFF2C3E50))),
        content: Text('Are you sure you want to delete "$categoryName"?', style: TextStyle(color: Color(0xFF2C3E50))),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6F61)),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() {
                widget.categorizedTops.remove(categoryName);
                widget.categorizedBottoms.remove(categoryName);
                widget.categorizedAccessories.remove(categoryName);
                widget.categorizedShoes.remove(categoryName);
                _sectionsMarkedForDelete.remove(categoryName);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, Map<String, List<File>> categorizedItems, Widget destinationPage) {
    final flatList = categorizedItems.values.expand((e) => e).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          },
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 8),
        flatList.isEmpty
            ? Container(
                height: 150,
                color: const Color.fromARGB(255, 240, 240, 240),
                child: const Center(child: Text('No items to display')),
              )
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: flatList.length,
                  itemBuilder: (context, index) {
                    final file = flatList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        file,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('All Items', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2C3E50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'delete') {
                setState(() {
                  _isDeleteMode = !_isDeleteMode;
                });
              } else if (value == 'customize') {
                _showAddCategoryDialog();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text(_isDeleteMode ? 'Cancel Delete Mode' : 'Delete Sections'),
              ),
              const PopupMenuItem(
                value: 'customize',
                child: Text('Customize Your Items'),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategorySection(
                'Tops',
                widget.categorizedTops,
                TopsPage(categorizedTops: widget.categorizedTops),
              ),
              _buildCategorySection(
                'Bottoms',
                widget.categorizedBottoms,
                BottomsPage(categorizedBottoms: widget.categorizedBottoms),
              ),
              _buildCategorySection(
                'Accessories',
                widget.categorizedAccessories,
                AccessoriesPage(categorizedAccessories: widget.categorizedAccessories),
              ),
              _buildCategorySection(
                'Shoes',
                widget.categorizedShoes,
                ShoesPage(categorizedShoes: widget.categorizedShoes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
