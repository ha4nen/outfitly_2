// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

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
  int _previousIndex = 0;

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

  void _navigateToPage(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          final isNavigatingRight = _currentIndex > _previousIndex;
          var tween = Tween(
            begin: Offset(isNavigatingRight ? 1.0 : -1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            _navigateToPage(index);
          }
        },
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Dynamic background color
        selectedItemColor: Theme.of(context).colorScheme.secondary, // Dynamic selected item color
        unselectedItemColor: Theme.of(context).colorScheme.onBackground, // Dynamic unselected item color
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
        backgroundColor: Theme.of(context).colorScheme.secondary, // Dynamic background color
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary), // Dynamic icon color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}