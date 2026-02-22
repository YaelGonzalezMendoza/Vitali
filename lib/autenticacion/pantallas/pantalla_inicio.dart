import 'package:flutter/material.dart';
import '../../nucleo/rutas/app_rutas.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔵 APPBAR CON FLECHA DE REGRESO
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),

      backgroundColor: const Color(0xFFF4F6F8),

      body: SafeArea(
        child: Stack(
          children: [

            /// CONTENIDO PRINCIPAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  /// Logo superior
                  const Text(
                    "Vitali",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Icono superior
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6F0FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_hospital,
                      size: 40,
                      color: Color(0xFF2563EB),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Título
                  const Text(
                    "Bienvenido a\nVitali",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Descripción
                  const Text(
                    "Tu asistente fácil para recetas médicas y seguimiento de tratamientos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Imagen
                  Expanded(
                    child: Image.asset(
                      'assets/imagenes/equipo_medico.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  /// Botón iniciar sesión
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
                        Navigator.pushNamed(
                            context, AppRutas.login);
                      },
                      child: const Text(
                        "Iniciar Sesión",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Botón registrarse
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF2563EB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRutas.seleccionRol);
                      },
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Diseñado para ser fácil de usar",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            /// BOTÓN FLOTANTE ACCESIBILIDAD
            Positioned(
              bottom: 30,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF2563EB),
                onPressed: () {},
                child: const Icon(Icons.accessibility),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
