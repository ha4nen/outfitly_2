import 'dart:io';
import 'package:flutter/material.dart';

class WardrobePage extends StatefulWidget {
  final List<Map<String, dynamic>> posts;

  const WardrobePage({super.key, required this.posts});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  List<Map<String, dynamic>> get posts => widget.posts;

  void _deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index]['liked'] = !(posts[index]['liked'] ?? false);
    });
  }

  // Add this for tracking the "like heart" animation per post
  List<bool> _showHeart = List.generate(10, (_) => false);  // Assuming 10 posts for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[100],
      body: posts.isEmpty
          ? const Center(child: Text("No posts available"))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => _buildPost(index),
            ),
    );
  }

  Widget _buildPost(int index) {
    final post = posts[index];
    final bool isLiked = post['liked'] ?? false;
    bool showHeart = _showHeart[index];  // Track heart visibility per post

    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _toggleLike(index);
          _showHeart[index] = true;  // Show heart animation on double-tap
        });

        // Hide the heart after a brief duration (600ms)
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            _showHeart[index] = false;
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(post['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Delete Post'),
                          content: const Text('Are you sure you want to delete this post?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _deletePost(index);
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: post['image'] != null && File(post['image']).existsSync()
                        ? Image.file(
                            File(post['image']),
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 300,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(child: Text("Image not found")),
                          ),
                  ),
                  if (showHeart)
                    const Icon(Icons.favorite, color: Colors.red, size: 80), // Heart animation
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleLike(index),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        post['caption'] ?? '',
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}