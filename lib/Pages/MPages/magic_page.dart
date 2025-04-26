// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MagicPage extends StatefulWidget {
  final VoidCallback onThemeChange;

  const MagicPage({super.key, required this.onThemeChange, required bool fromCalendar});

  @override
  State<MagicPage> createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  int? selectedItemIndex;
  double _trulyAiScale = 1.0;
  double _makeYourOwnScale = 1.0;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description field
            const Text(
              'Click the button for a Truly AI Generated OUTFIT, Choose an Item to generate around that ITEM.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16), // Space below description

            // Item selection grid with VFX
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 6, // Number of items (empty for now)
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle selection
                                selectedItemIndex = selectedItemIndex == index ? null : index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedItemIndex == index ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedItemIndex == index ? Colors.blueAccent : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Item ${index + 1}',
                                  style: TextStyle(
                                    color: selectedItemIndex == index ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16), // Space below grid

            // Truly AI button with VFX
            GestureDetector(
              onTapDown: (_) => setState(() => _trulyAiScale = 0.95),
              onTapUp: (_) => setState(() => _trulyAiScale = 1.0),
              child: AnimatedScale(
                scale: _trulyAiScale,
                duration: const Duration(milliseconds: 100),
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for Truly AI button
                    if (selectedItemIndex != null) {
                      print('Help with AI for Item ${selectedItemIndex! + 1}');
                    } else {
                      print('Truly AI button clicked');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                  ),
                  child: Text(selectedItemIndex != null ? 'Help with AI' : 'Truly AI'),
                ),
              ),
            ),
            const SizedBox(height: 16), // Space below Truly AI button

            // Make your own button with VFX
            GestureDetector(
              onTapDown: (_) => setState(() => _makeYourOwnScale = 0.95),
              onTapUp: (_) => setState(() => _makeYourOwnScale = 1.0),
              child: AnimatedScale(
                scale: _makeYourOwnScale,
                duration: const Duration(milliseconds: 100),
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for Make your own button
                    print('Make your own button clicked');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                  ),
                  child: const Text('Make ur own'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}