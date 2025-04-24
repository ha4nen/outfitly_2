import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/MPages/clalender%20page.dart';
import 'package:flutter_application_1/Pages/MPages/magic_page.dart';
import 'package:flutter_application_1/Pages/MPages/profile_page.dart';
import 'package:flutter_application_1/Pages/MPages/feed_page.dart';
import 'dart:io';
import 'package:flutter_application_1/Pages/The+Button/AddItemOptionsPage.dart';

class MainAppPage extends StatefulWidget {
  final List<File> items;
  final VoidCallback onThemeChange;

  const MainAppPage({super.key, required this.items, required this.onThemeChange});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      WardrobePage(posts: [
        {
          'username': 'han',
          'caption': 'Outfit of the day!',
        },
      ]),
      MagicPage(onThemeChange: widget.onThemeChange, fromCalendar: false),
      const FeedPage(),
      ProfilePage(items: widget.items, onThemeChange: widget.onThemeChange),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.black, // Set the background color of the navigation bar
        selectedItemColor: Colors.yellow, // Set the color for the selected item
        unselectedItemColor: Colors.white, // Set the color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Wardrobe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Magic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show AddItemOptionsPage dialog
          showDialog(
            context: context,
            builder: (_) => const AddItemOptionsPage(),
          );
        },
        backgroundColor: Colors.yellow, // Set the background color of the + button
        child: const Icon(Icons.add, color: Colors.black), // Set the + icon color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}