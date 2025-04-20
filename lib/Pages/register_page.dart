import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> registerUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/register/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      }),
    );

    setState(() {
      _isLoading = false;
    });

    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registered successfully!'),
          backgroundColor: Color(0xFFA9FBD7), // Mint Green
        ),
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseBody['error'] ?? 'Failed to register'),
          backgroundColor: Color(0xFFFF5C58), // Coral Red
        ),
      );
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isComplexPassword(String password) {
    final upper = RegExp(r'[A-Z]');
    final number = RegExp(r'\d');
    final symbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return upper.hasMatch(password) &&
        number.hasMatch(password) &&
        symbol.hasMatch(password) &&
        password.length >= 6;
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF222222)),
      filled: true,
      fillColor: Color(0xFFF1F0FF), // Lavender Gray
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Background
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF936DFF), // Primary Purple
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: buildInputDecoration('Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: buildInputDecoration('Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your email';
                    if (!isValidEmail(value)) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: buildInputDecoration('Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your password';
                    if (!isComplexPassword(value)) {
                      return 'Password must contain:\n- Uppercase\n- Number\n- Symbol\n- 6+ characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: buildInputDecoration('Confirm Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm your password';
                    if (value != passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => registerUser(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF936DFF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
