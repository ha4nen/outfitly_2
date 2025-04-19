// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/loading_page.dart';
import 'package:flutter_application_1/Pages/login_page.dart';
import 'package:flutter_application_1/Pages/register_page.dart';
import 'package:flutter_application_1/Pages/main_app_page.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _cycleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  final List<File> _items = []; // Initialize the shared items list

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit App',
      theme: ThemeData.light().copyWith(
        splashColor: Color.fromARGB(255, 243, 225, 88).withOpacity(0.2),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => MainAppPage(items: _items, onThemeChange: _cycleTheme),
      },
    );
  }
}