import 'package:flutter/material.dart';
import 'dart:io';

class ShoesPage extends StatefulWidget {
  final Map<String, List<File>> categorizedShoes;

  const ShoesPage({
    super.key,
    required this.categorizedShoes,
  });

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  final Set<String> _sectionsMarkedForDelete = {};
  bool _isDeleteMode = false;

  void _showAddCategoryDialog() {
    String newCategory = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Shoe Category"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Category name"),
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
              child: const Text("Add"),
              onPressed: () {
                if (newCategory.isNotEmpty &&
                    !widget.categorizedShoes.containsKey(newCategory)) {
                  setState(() {
                    widget.categorizedShoes[newCategory] = [];
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
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete "$categoryName"?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Delete'),
            onPressed: () {
              setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Shoes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
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
                child: Text(_isDeleteMode ? 'Cancel Delete Mode' : 'Delete Categories'),
              ),
              const PopupMenuItem(
                value: 'customize',
                child: Text('Customize Your Shoes'),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: widget.categorizedShoes.entries.map((entry) {
              return _buildCategorySection(entry.key, entry.value);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            if (_isDeleteMode)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _showDeleteConfirmation(categoryName),
              ),
          ],
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('No items to display')),
              )
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: items.map((file) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
        const SizedBox(height: 24),
      ],
    );
  }
}
