import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaConfirmarReset extends StatefulWidget {
  const PantallaConfirmarReset({super.key});

  @override
  State<PantallaConfirmarReset> createState() =>
      _PantallaConfirmarResetState();
}

class _PantallaConfirmarResetState
    extends State<PantallaConfirmarReset> {

  final _formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();
  final nuevaPasswordController = TextEditingController();

  Future<void> confirmarReset(String correo) async {
    final url =
        Uri.parse("http://192.168.150.72:8000/api/confirmar-reset");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "correo_electronico": correo,
          "token": tokenController.text,
          "nueva_contrasenia": nuevaPasswordController.text,
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Contraseña actualizada correctamente")),
        );

        Navigator.pushNamedAndRemoveUntil(context,'/login', (route) => false, );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error de conexión")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final correo =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Confirmar Token")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Correo: $correo"),
              const SizedBox(height: 20),
              TextFormField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: "Token",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nuevaPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Nueva Contraseña",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    confirmarReset(correo);
                  }
                },
                child: const Text("Actualizar Contraseña"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}