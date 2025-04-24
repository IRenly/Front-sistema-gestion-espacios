import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> login() async {
    final url = Uri.parse('http://localhost:8000/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _message = 'Token: ${json['access_token']}';
      });
    } else {
      setState(() {
        _message = 'Login failed: ${response.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBEAEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF457B9D),
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 900,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                'Sistema de Espacios Físicos',
                style: TextStyle(
                  color: Color(0xFF1D3557),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ingrese sus credenciales para acceder al sistema',
                style: TextStyle(
                  color: Color(0xFF5D7A89),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Text('Usuario', style: TextStyle(color: Color(0xFF1A2A33))),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: '20210001',
                  filled: true,
                  fillColor: Color(0xFFF5F9FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFDDE8EE)),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: FaIcon(FontAwesomeIcons.envelope, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Contraseña', style: TextStyle(color: Color(0xFF1A2A33))),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: '********',
                  filled: true,
                  fillColor: Color(0xFFF5F9FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFDDE8EE)),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: FaIcon(FontAwesomeIcons.lock, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF457B9D),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Iniciar sesión'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(
                          color: Color(0xFF457B9D),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterPage()),
                        );
                      },
                      child: Text(
                        '¿No tienes cuenta? Regístrate aquí',
                        style: TextStyle(
                          color: Color(0xFF457B9D),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(_message),
            ],
                    // ... Todo el contenido que ya tienes dentro del Container ..
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
