import 'dart:io';
import 'package:flutter/material.dart';

class ItemDetailsFormPage extends StatefulWidget {
  final File imageFile;

  const ItemDetailsFormPage({super.key, required this.imageFile});

  @override
  State<ItemDetailsFormPage> createState() => _ItemDetailsFormPageState();
}

class _ItemDetailsFormPageState extends State<ItemDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> itemData = {
    'name': '',
    'category': '',
    'subcategory': '',
    'color': '',
    'size': '',
    'material': '',
    'season': '',
    'occasion': '',
    'condition': '',
    'purchaseDate': '',
    'brand': '',
    'price': '',
    'careInstructions': '',
    'location': '',
    'notes': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.file(widget.imageFile),
              const SizedBox(height: 10),
              _buildTextField("Name", "name"),
              _buildDropdown("Main Category", "category", [
                "Tops", "Bottoms", "Shoes", "Accessories"
              ]),
              _buildTextField("Sub-category", "subcategory"),
              _buildTextField("Color", "color"),
              _buildTextField("Size", "size"),
              _buildTextField("Material", "material"),
              _buildTextField("Season", "season"),
              _buildTextField("Occasion", "occasion"),
              _buildTextField("Condition", "condition"),
              _buildTextField("Brand", "brand"),
              _buildTextField("Price", "price"),
              _buildTextField("Location", "location"),
              _buildTextField("Notes", "notes"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text("Save Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        onChanged: (value) => itemData[key] = value,
      ),
    );
  }

  Widget _buildDropdown(String label, String key, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label),
        items: options
            .map((val) => DropdownMenuItem(value: val, child: Text(val)))
            .toList(),
        onChanged: (val) => setState(() => itemData[key] = val),
      ),
    );
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      // save logic based on category
      // TODO: pass to provider/database and navigate
      print("Saving item: $itemData");
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
