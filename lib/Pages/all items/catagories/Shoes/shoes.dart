import 'package:flutter/material.dart';
import 'dart:io';
import '../../SubDetails.dart'; // Import SubDetails page

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamic background color
      appBar: AppBar(
        title: const Text('Shoes'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Dynamic app bar color
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor, // Dynamic text color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color), // Dynamic icon color
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color), // Dynamic icon color
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
                child: Text(
                  _isDeleteMode ? 'Cancel Delete Mode' : 'Delete Categories',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color), // Dynamic text color
                ),
              ),
              PopupMenuItem(
                value: 'customize',
                child: Text(
                  'Customize Your Shoes',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color), // Dynamic text color
                ),
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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubDetails(subcategoryName: categoryName),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary, // Dynamic text color
                ),
              ),
              if (_isDeleteMode)
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error), // Dynamic icon color
                  onPressed: () => _showDeleteConfirmation(categoryName),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Dynamic placeholder background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'No items to display',
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color), // Dynamic text color
                  ),
                ),
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
                          color: Theme.of(context).shadowColor.withOpacity(0.1), // Dynamic shadow color
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
