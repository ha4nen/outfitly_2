// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../mesc/settings_page.dart';
import 'package:flutter_application_1/Pages/all%20items/all_items_page.dart';
import 'package:flutter_application_1/Pages/Outfits/all_outfits.dart';
import 'package:flutter_application_1/Pages/all items/ItemDetails.dart'; // Ensure this is the correct path

class ProfilePage extends StatefulWidget {
  final VoidCallback onThemeChange;
  final List<File> items; // Shared list of items

  const ProfilePage({super.key, required this.onThemeChange, required this.items});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  bool _isEditing = false; // Tracks whether the user is in edit mode
  final Set<int> _selectedItems = {}; // Tracks selected items for deletion

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  Future<void> _saveProfileImage(String path) async {
    // Save profile image path locally (e.g., using SharedPreferences)
  }

  Future<void> _loadProfileImage() async {
    // Load profile image path from local storage
  }

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
          'Profile',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      SettingsPage(onThemeChange: widget.onThemeChange),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              // Followers and Following Count
              const Text(
                '@username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '0 Following  |  0 Followers',
                style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 16),

              // Divider
              const Divider(thickness: 1),

              // Items Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllItemsPage(
                            categorizedTops: {
                              'T-Shirts': [],
                              'Shirts': [],
                              'Blouses': [],
                              'Tank Tops': [],
                              'Sweaters': [],
                              'Hoodies': [],
                              'Cardigans': [],
                              'Crop Tops': [],
                              'Jackets': [],
                              'Coats': [],
                              'Vests': [],
                              'Sportswear Tops': [],
                            },
                            categorizedBottoms: {
                              'Jeans': [],
                              'Trousers': [],
                              'Leggings': [],
                              'Shorts': [],
                              'Skirts': [],
                              'Modest Bottoms': [],
                              'Culottes': [],
                              'Joggers': [],
                              'Sweatpants': [],
                              'Formal Pants': [],
                              'Overalls': [],
                              'Capris': [],
                            },
                            categorizedAccessories: {
                              'Hats': [],
                              'Scarves': [],
                              'Belts': [],
                              'Bags': [],
                              'Jewelry': [],
                              'Earrings': [],
                              'Necklaces': [],
                              'Bracelets': [],
                              'Rings': [],
                              'Gloves': [],
                              'Sunglasses': [],
                              'Watches': [],
                              'Hair Accessories': [],
                              'Ties & Bowties': [],
                              'Socks': [],
                              'Hijabs & Covers': [],
                              'Chiffon Hijabs': [],
                              'Jersey Hijabs': [],
                              'Undercaps': [],
                              'Shawls': [],
                              'Niqabs': [],
                              'Khimars': [],
                            },
                            categorizedShoes: {
                              'Sneakers': [],
                              'Boots': [],
                              'Flats': [],
                              'Heels': [],
                              'Sandals': [],
                              'Flip-Flops': [],
                              'Formal Shoes': [],
                              'Slippers': [],
                              'Sports Shoes': [],
                              'Winter Shoes': [],
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                                        builder: (context) => ItemDetails(
                                          item: widget.items[index],
                                          itemName: 'Sample Item Name', // Replace with actual item name
                                          color: 'Sample Color', // Replace with actual color
                                          size: 'Sample Size', // Replace with actual size
                                          season: 'Sample Season', // Replace with actual season
                                          tags: ['Sample Tag 1', 'Sample Tag 2'], // Replace with actual tags
                                        ),
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
                                        builder: (context) => ItemDetails(
                                          item: widget.items[index],
                                          itemName: 'Sample Item Name', // Replace with actual item name
                                          color: 'Sample Color', // Replace with actual color
                                          size: 'Sample Size', // Replace with actual size
                                          season: 'Sample Season', // Replace with actual season
                                          tags: ['Sample Tag 1', 'Sample Tag 2'], // Replace with actual tags
                                        ),
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
      ),
    );
  }
}