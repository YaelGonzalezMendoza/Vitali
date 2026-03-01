import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaSolicitarReset extends StatefulWidget {
  const PantallaSolicitarReset({super.key});

  @override
  State<PantallaSolicitarReset> createState() =>
      _PantallaSolicitarResetState();
}

class _PantallaSolicitarResetState
    extends State<PantallaSolicitarReset> {

  final _formKey = GlobalKey<FormState>();
  final correoController = TextEditingController();

  Future<void> solicitarToken() async {
    final url =
        Uri.parse("http://192.168.150.72:8000/api/solicitar-reset");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "correo_electronico": correoController.text
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Token generado: ${data['token']}",
            ),
          ),
        );

        Navigator.pushNamed(
          context,
          '/confirmarReset',
          arguments: correoController.text,
        );
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
    return Scaffold(
      appBar: AppBar(title: const Text("Recuperar Contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: correoController,
                decoration: const InputDecoration(
                  labelText: "Correo Electrónico",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    solicitarToken();
                  }
                },
                child: const Text("Solicitar Token"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}