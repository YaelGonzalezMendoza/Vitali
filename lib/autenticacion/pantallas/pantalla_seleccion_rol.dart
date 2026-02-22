import 'package:flutter/material.dart';
import '../../nucleo/rutas/app_rutas.dart';

class PantallaSeleccionRol extends StatelessWidget {
  const PantallaSeleccionRol({super.key});

  Widget tarjetaRol(
    BuildContext context,
    IconData icono,
    String titulo,
    String descripcion,
    String ruta,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE0EDFF),
          child: Icon(
            icono,
            color: const Color(0xFF2563EB),
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(descripcion),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () {
          Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // 🔵 FLECHA DE REGRESO
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Selecciona tu rol",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // 🔵 PACIENTE
            tarjetaRol(
              context,
              Icons.person,
              "Paciente",
              "Gestiona tus recetas y tratamientos.",
              '/registroPaciente',
            ),

            const SizedBox(height: 16),

            // 🔵 MÉDICO
            tarjetaRol(
              context,
              Icons.medical_services,
              "Médico",
              "Administra pacientes y recetas.",
              '/registroMedico',
            ),
          ],
        ),
      ),
    );
  }
}
