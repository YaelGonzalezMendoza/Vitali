import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class PantallaRegistro extends StatelessWidget {
  final String tipo; // 'paciente' o 'medico'

  const PantallaRegistro({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final bool esMedico = tipo == 'medico';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // 🔵 APPBAR CON FLECHA
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          esMedico
              ? "Registro de Médico"
              : "Registro de Usuario",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TÍTULO CENTRAL
            Center(
              child: Column(
                children: [
                  Text(
                    esMedico
                        ? "Únete como Profesional"
                        : "¡Bienvenido a Vitali!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    esMedico
                        ? "Complete su perfil profesional para comenzar."
                        : "Seleccione su perfil para comenzar el registro.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// SELECTOR ROL
            Row(
              children: [
                Expanded(
                  child: _botonRol(
                    activo: !esMedico,
                    texto: "Soy Paciente",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _botonRol(
                    activo: esMedico,
                    texto: "Soy Médico",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// NOMBRE
            const Text("Nombre Completo"),
            const SizedBox(height: 6),
            _campo("Ej: Juan Pérez"),

            const SizedBox(height: 16),

            /// CORREO
            const Text("Correo electrónico"),
            const SizedBox(height: 6),
            _campo("ejemplo@correo.com"),

            /// ESPECIALIDAD SOLO SI ES MÉDICO
            if (esMedico) ...[
              const SizedBox(height: 16),
              const Text("Especialidad"),
              const SizedBox(height: 6),
              _campo("Ej: Cardiología"),
            ],

            const SizedBox(height: 16),

            /// CONTRASEÑA
            const Text("Contraseña"),
            const SizedBox(height: 6),
            _campo(
              "Cree una contraseña segura",
              esPassword: true,
            ),

            const SizedBox(height: 30),

            /// BOTÓN CONTINUAR
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
                onPressed: () {},
                child: const Text(
                  "Continuar registro →",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TEXTO IR A LOGIN
            Center(
              child: Text.rich(
                TextSpan(
                  text: "¿Ya tienes una cuenta? ",
                  children: [
                    TextSpan(
                      text: "Inicia sesión aquí",
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CAJA INFORMATIVA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F0FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                esMedico
                    ? "Si requiere asistencia para el proceso de validación profesional, comuníquese con nuestro soporte institucional."
                    : "Si necesita ayuda para registrarse, puede comunicarse con nuestro centro de atención al cliente.",
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CAMPO PERSONALIZADO
  Widget _campo(String hint, {bool esPassword = false}) {
    return TextField(
      obscureText: esPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// BOTÓN ROL
  Widget _botonRol({
    required bool activo,
    required String texto,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: activo
            ? const Color(0xFF2563EB)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        texto,
        style: TextStyle(
          color: activo ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
