// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/mesc/loading_page.dart';
import 'package:flutter_application_1/Pages/mesc/login_page.dart';
import 'package:flutter_application_1/Pages/mesc/register_page.dart';
import 'package:flutter_application_1/Pages/MPages/main_app_page.dart';
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
      theme: ThemeData(
        primaryColor: const Color(0xFFE0BBE4), // Lavender
        hintColor: const Color(0xFF9A4DFF), // Bold Purple
        scaffoldBackgroundColor: const Color(0xFFFAFAFA), // Light Purple Grey
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF222222)), // Dark Grey
          bodyMedium: TextStyle(color: Color(0xFF222222)), // Dark Grey
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE0BBE4), // Lavender
          foregroundColor: Color(0xFF222222), // Dark Grey
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF9A4DFF), // Bold Purple
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFE0BBE4), // Lavender
          onPrimary: Color(0xFF222222), // Dark Grey
          secondary: Color(0xFF9A4DFF), // Bold Purple
          onSecondary: Color(0xFFFFFFFF), // White
          error: Color(0xFFB00020), // Error Red
          onError: Color(0xFFFFFFFF), // White
          background: Color(0xFFEDE7F6), // Light Purple Grey
          onBackground: Color(0xFF222222), // Dark Grey
          surface: Color(0xFFFFFFFF), // White
          onSurface: Color(0xFF222222), // Dark Grey
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFE0BBE4), // Lavender
        scaffoldBackgroundColor: const Color(0xFF222222), // Dark Grey
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFE0BBE4), // Lavender
          onPrimary: Color(0xFFFAFAFA), // Soft White
          secondary: Color(0xFF9A4DFF), // Bold Purple
          onSecondary: Color(0xFFFAFAFA), // Soft White
          error: Color(0xFFCF6679), // Error Red
          onError: Color(0xFF222222), // Dark Grey
          background: Color(0xFF444444), // Darker Grey
          onBackground: Color(0xFFFAFAFA), // Soft White
          surface: Color(0xFF333333), // Dark Grey
          onSurface: Color(0xFFFAFAFA), // Soft White
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFAFAFA)), // Soft White
          bodyMedium: TextStyle(color: Color(0xFFFAFAFA)), // Soft White
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9A4DFF), // Bold Purple
          foregroundColor: Color(0xFFFAFAFA), // Soft White
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF9A4DFF), // Bold Purple
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(
              imageFile: File('path/to/your/image'),
              nextPageBuilder: () => const LoginPage(),
            ), // Provide the required imageFile parameter
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => MainAppPage(items: _items, onThemeChange: _cycleTheme),
      },
    );
  }
}