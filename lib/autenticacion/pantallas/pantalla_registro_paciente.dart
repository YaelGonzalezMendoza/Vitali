import 'package:flutter/material.dart';

class PantallaRegistroPaciente extends StatefulWidget {
  const PantallaRegistroPaciente({super.key});

  @override
  State<PantallaRegistroPaciente> createState() =>
      _PantallaRegistroPacienteState();
}

class _PantallaRegistroPacienteState
    extends State<PantallaRegistroPaciente> {

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
        title: Text(
          pasoActual == 1
              ? "Crear cuenta"
              : "Finalizar Registro",
        ),
        centerTitle: true,
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
  // PASO 1
  // =========================

  Widget _paso1() {
    return Form(
      key: _formKeyPaso1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Complete sus datos para continuar.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _campo("Nombre Completo"),
            const SizedBox(height: 16),

            _campo("Correo Electrónico"),
            const SizedBox(height: 16),

            _campo("CURP"),
            const SizedBox(height: 16),

            _campo("Contraseña", esPassword: true),
            const SizedBox(height: 16),

            _campo("Fecha de Nacimiento (dd/mm/yyyy)"),

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

            _cajaAyuda(
                "¿Necesitas ayuda?",
                "Si tiene dificultades para completar este formulario, puede llamar a nuestro centro de asistencia."),
          ],
        ),
      ),
    );
  }

  // =========================
  // PASO 2
  // =========================

  Widget _paso2() {
    return Form(
      key: _formKeyPaso2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Seguridad de su cuenta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

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
                              content:
                                  Text("Registro completado 🎉"),
                            ),
                          );
                        }
                      }
                    : null,
                child: const Text("Finalizar Registro"),
              ),
            ),

            const SizedBox(height: 20),

            _cajaAyuda(
                "Tu seguridad es nuestra prioridad",
                "Toda su información personal será protegida bajo los estándares internacionales de seguridad."),
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
