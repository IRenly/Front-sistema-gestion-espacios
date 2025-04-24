import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    "nombre": TextEditingController(),
    "apellido": TextEditingController(),
    "codigo_usuario": TextEditingController(),
    "rol": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  Future<void> registerUser() async {
    final url = Uri.parse('http://localhost:8000/usuarios/crear-usuario');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": 0,
        "nombre": controllers["nombre"]!.text,
        "apellido": controllers["apellido"]!.text,
        "codigo_usuario": controllers["codigo_usuario"]!.text,
        "rol": controllers["rol"]!.text,
        "email": controllers["email"]!.text,
        "password": controllers["password"]!.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("¡Registro exitoso!"),
          content: Text("El usuario ha sido creado correctamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el dialog
                Navigator.of(context).pop(); // Regresa a pantalla anterior
              },
              child: Text("Aceptar"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBEAEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF457B9D),
        title: Text('Registro de Usuario'),
      ),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                // Título dentro del formulario
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Registro de Usuario",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D3557),
                      ),
                    ),
                  ),
                ),
                ...controllers.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: entry.value,
                      obscureText: entry.key == "password",
                      decoration: InputDecoration(
                        labelText: entry.key,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF457B9D),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Registrarse"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





