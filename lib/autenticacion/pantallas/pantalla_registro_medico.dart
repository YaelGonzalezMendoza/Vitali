import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaRegistroMedico extends StatefulWidget {
  const PantallaRegistroMedico({super.key});

  @override
  State<PantallaRegistroMedico> createState() =>
      _PantallaRegistroMedicoState();
}

class _PantallaRegistroMedicoState
    extends State<PantallaRegistroMedico> {

  final _formKey = GlobalKey<FormState>();
  bool aceptaTerminos = false;

  // Controllers
  final nombreController = TextEditingController();
  final apellidoPController = TextEditingController();
  final apellidoMController = TextEditingController();
  final correoController = TextEditingController();
  final curpController = TextEditingController();
  final fechaController = TextEditingController();
  final passwordController = TextEditingController();
  final especialidadController = TextEditingController();
  final cedulaController = TextEditingController();

  Future<void> registrarMedico() async {
    print("REGISTRO MÉDICO EJECUTÁNDOSE");

    final url = Uri.parse("http://192.168.150.72:8000/api/register");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "nombre": nombreController.text,
          "apellido_paterno": apellidoPController.text,
          "apellido_materno": apellidoMController.text,
          "correo_electronico": correoController.text,
          "contrasenia": passwordController.text,
          "curp": curpController.text,
          "fecha_nacimiento": fechaController.text,
          "id_rol": 2,
          "especialidad": especialidadController.text,
          "cedula_profesional": cedulaController.text
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registro Médico enviado para validación 🩺"),
          ),
        );

        Navigator.pushReplacementNamed(context, '/login');
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
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Registro Profesional"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                _campo("Nombre", nombreController),
                const SizedBox(height: 16),

                _campo("Apellido Paterno", apellidoPController),
                const SizedBox(height: 16),

                _campo("Apellido Materno", apellidoMController),
                const SizedBox(height: 16),

                _campo("Correo Electrónico", correoController),
                const SizedBox(height: 16),

                _campo("CURP", curpController),
                const SizedBox(height: 16),

                _campo("Fecha de Nacimiento (YYYY-MM-DD)", fechaController),
                const SizedBox(height: 16),

                _campo("Contraseña", passwordController, esPassword: true),
                const SizedBox(height: 16),

                _campo("Especialidad Médica", especialidadController),
                const SizedBox(height: 16),

                _campo("Número de Cédula Profesional", cedulaController),

                const SizedBox(height: 20),

                CheckboxListTile(
                  value: aceptaTerminos,
                  onChanged: (value) {
                    setState(() {
                      aceptaTerminos = value ?? false;
                    });
                  },
                  title: const Text(
                    "Acepto los Términos y Condiciones",
                    style: TextStyle(fontSize: 14),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: aceptaTerminos
                          ? const Color(0xFF2563EB)
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: aceptaTerminos
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              registrarMedico();
                            }
                          }
                        : null,
                    child: const Text("Confirmar Registro"),
                  ),
                ),

                const SizedBox(height: 20),

                _cajaInfo(
                  "Validación Profesional",
                  "Su cuenta será activada una vez que el equipo valide su cédula profesional.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller,
      {bool esPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: esPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _cajaInfo(String titulo, String texto) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(texto),
        ],
      ),
    );
  }
}