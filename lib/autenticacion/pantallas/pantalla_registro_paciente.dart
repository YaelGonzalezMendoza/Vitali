import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaRegistroPaciente extends StatefulWidget {
  const PantallaRegistroPaciente({super.key});

  @override
  State<PantallaRegistroPaciente> createState() =>
      _PantallaRegistroPacienteState();
}

class _PantallaRegistroPacienteState
    extends State<PantallaRegistroPaciente> {

  final _formKey = GlobalKey<FormState>();

  bool aceptaTerminos = false;

  // 🔹 Controllers
  final nombreController = TextEditingController();
  final apellidoPController = TextEditingController();
  final apellidoMController = TextEditingController();
  final correoController = TextEditingController();
  final curpController = TextEditingController();
  final passwordController = TextEditingController();
  final fechaController = TextEditingController();

  // 🔥 FUNCIÓN REGISTRO
  Future<void> registrarPaciente() async {
    print("REGISTRO EJECUTÁNDOSE");

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
    "id_rol": 1
  }),
);

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 201) {
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
        automaticallyImplyLeading: true,
        title: const Text("Crear cuenta"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Complete sus datos para registrarse.",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                _campo("Nombre", controller: nombreController),
                const SizedBox(height: 16),

                _campo("Apellido Paterno", controller: apellidoPController),
                const SizedBox(height: 16),

                _campo("Apellido Materno", controller: apellidoMController),
                const SizedBox(height: 16),

                _campo("Correo Electrónico", controller: correoController),
                const SizedBox(height: 16),

                _campo("CURP", controller: curpController),
                const SizedBox(height: 16),

                _campo("Contraseña", esPassword: true, controller: passwordController),
                const SizedBox(height: 16),

                _campo("Fecha de Nacimiento (YYYY-MM-DD)", controller: fechaController),

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
                              registrarPaciente();
                            }
                          }
                        : null,
                    child: const Text("Confirmar Registro"),
                  ),
                ),

                const SizedBox(height: 20),

                _cajaAyuda(
                  "Tu seguridad es nuestra prioridad",
                  "Toda su información personal será protegida bajo los estándares internacionales de seguridad.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campo(String label,
      {bool esPassword = false,
      TextEditingController? controller}) {
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

  Widget _cajaAyuda(String titulo, String texto) {
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(texto),
        ],
      ),
    );
  }
}