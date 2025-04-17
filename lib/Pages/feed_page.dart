import 'package:flutter/material.dart';

class WardrobePage extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  const WardrobePage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
body: posts.isEmpty
    ? const Center(child: Text("No posts available"))
    : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPost(
            username: post['username'],
            caption: post['caption'],
          );
        },
      ),

    );
  }

  Widget _buildPost({
    required String username,
    required String caption,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: const Center(child: Text("Image Placeholder")),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 4),
              Text('Like'),
            ],
          ),
          const SizedBox(height: 4),
          Text(caption, style: const TextStyle(fontSize: 14)),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WardrobePage(
        posts: [
          {
            'username': 'example_user',
            'caption': 'This is a sample caption.',
          },
        ],
      ),
    );
  }
}
