import 'package:flutter/material.dart';

class PantallaRegistroMedico extends StatefulWidget {
  const PantallaRegistroMedico({super.key});

  @override
  State<PantallaRegistroMedico> createState() =>
      _PantallaRegistroMedicoState();
}

class _PantallaRegistroMedicoState
    extends State<PantallaRegistroMedico> {

  int pasoActual = 1;

  final _formKeyPaso1 = GlobalKey<FormState>();
  final _formKeyPaso2 = GlobalKey<FormState>();

  bool aceptaTerminos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          pasoActual == 1
              ? "Registro Profesional"
              : "Seguridad de Cuenta",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: pasoActual == 1
            ? _paso1()
            : _paso2(),
      ),
    );
  }

  // =========================
  // PASO 1 - DATOS PROFESIONALES
  // =========================

  Widget _paso1() {
    return Form(
      key: _formKeyPaso1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Complete su información profesional.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _campo("Nombre Completo"),
            const SizedBox(height: 16),

            _campo("Correo Electrónico"),
            const SizedBox(height: 16),

            _campo("Especialidad Médica"),
            const SizedBox(height: 16),

            _campo("Número de Cédula Profesional"),
            const SizedBox(height: 16),

            _campo("Hospital o Clínica donde labora"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (_formKeyPaso1.currentState!.validate()) {
                    setState(() {
                      pasoActual = 2;
                    });
                  }
                },
                child: const Text("Continuar →"),
              ),
            ),

            const SizedBox(height: 20),

            _cajaInfo(
              "Validación Profesional",
              "Su información será verificada antes de activar su cuenta médica.",
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // PASO 2 - SEGURIDAD
  // =========================

  Widget _paso2() {
    return Form(
      key: _formKeyPaso2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Configure la seguridad de su cuenta.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _campo("Crear Contraseña", esPassword: true),
            const SizedBox(height: 16),

            _campo("Confirmar Contraseña", esPassword: true),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: aceptaTerminos
                    ? () {
                        if (_formKeyPaso2.currentState!.validate()) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Registro Médico enviado para validación 🩺"),
                            ),
                          );
                        }
                      }
                    : null,
                child: const Text("Finalizar Registro"),
              ),
            ),

            const SizedBox(height: 20),

            _cajaInfo(
              "Revisión Administrativa",
              "Su cuenta será activada una vez que el equipo valide su cédula profesional.",
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // COMPONENTES
  // =========================

  Widget _campo(String label,
      {bool esPassword = false}) {
    return TextFormField(
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
