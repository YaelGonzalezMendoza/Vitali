import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {

  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    print("Botón presionado");

    final url = Uri.parse("http://192.168.150.72:8000/api/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo_electronico": correoController.text.trim(),
          "contrasenia": passwordController.text.trim(),
        }),
      );

      print("Status code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
       final usuario = data["user"];
        final int rol = usuario["id_rol"];

        print("Rol recibido: $rol");

        if (rol == 1) {
          Navigator.pushReplacementNamed(
            context,
            '/homePaciente',
            arguments: usuario, // 👈 AQUÍ ESTÁ EL CAMBIO
          );
        } else if (rol == 2) {
          Navigator.pushReplacementNamed(
            context,
            '/homeMedico',
            arguments: usuario, // opcional pero recomendable
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Rol no reconocido")),
          );
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Credenciales incorrectas")),
        );
      }

    } catch (e) {
      print("Error conexión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error de conexión")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Iniciar Sesión"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [

                const SizedBox(height: 20),

                const Icon(
                  Icons.local_hospital,
                  size: 80,
                  color: Color(0xFF2563EB),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: correoController,
                  decoration: InputDecoration(
                    labelText: "Correo electrónico",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: login,
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
  onPressed: () {
    Navigator.pushNamed(context, '/solicitarReset');
  },
  child: const Text(
    "¿Olvidaste tu contraseña?",
    style: TextStyle(
      color: Color(0xFF2563EB),
    ),
  ),
),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/seleccionRol');
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(color: Color(0xFF2563EB)),
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