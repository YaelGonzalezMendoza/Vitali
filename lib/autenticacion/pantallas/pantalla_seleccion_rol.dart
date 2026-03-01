import 'package:flutter/material.dart';

class PantallaSeleccionRol extends StatelessWidget {
  const PantallaSeleccionRol({super.key});

  Widget tarjetaRol(
    BuildContext context,
    IconData icono,
    String titulo,
    String descripcion,
    String ruta,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.pushNamed(context, ruta);
        },
        child: Row(
          children: [

            /// Icono circular
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFE6F0FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icono,
                color: const Color(0xFF2563EB),
                size: 26,
              ),
            ),

            const SizedBox(width: 16),

            /// Texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descripcion,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// Icono superior
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F0FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_box_outlined,
                size: 32,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(height: 24),

            /// Título
            const Text(
              "Bienvenido a\nVitali",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// Subtítulo
            const Text(
              "Selecciona tu rol para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 40),

            /// PACIENTE
            tarjetaRol(
              context,
              Icons.person,
              "Paciente",
              "Gestiona tus recetas y tratamientos diarios.",
              '/registroPaciente', // 👈 tu ruta original
            ),

            /// MÉDICO
            tarjetaRol(
              context,
              Icons.medical_services,
              "Médico",
              "Prescribe y realiza seguimiento a pacientes.",
              '/registroMedico', // 👈 tu ruta original
            ),

            const Spacer(),

            /// Link inferior
            GestureDetector(
              onTap: () {},
              child: const Text(
                "¿Necesitas ayuda para elegir?",
                style: TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}