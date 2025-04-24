import 'package:flutter/material.dart';

class MagicPage extends StatefulWidget {
  final VoidCallback onThemeChange;

  const MagicPage({super.key, required this.onThemeChange, required bool fromCalendar});

  @override
  State<MagicPage> createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  bool isLeftFocused = true; // Track which side is focused

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI/Create Outfit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Row(
        children: [
          // Left Side: Outfit Creation
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLeftFocused = true;
                });
              },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isLeftFocused ? 1.0 : 0.5,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Create Your Outfit',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10, // Replace with the actual number of user items
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Item ${index + 1}'), // Replace with actual item names
                              leading: const Icon(Icons.checkroom),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // No functionality linked
                          },
                          child: const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right Side: AI
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLeftFocused = false;
                });
              },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isLeftFocused ? 0.5 : 1.0,
                child: Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text(
                      'AI Outfit Suggestions (Non-functional)',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}