import 'package:flutter/material.dart';
import '../../nucleo/rutas/app_rutas.dart';

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF4F6F8),

    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {},
          child: Container(
            width: 50, // 👈 mismo valor
            height: 60, // 👈 mismo valor
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.accessibility,
                size: 36,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ),
      ),
    ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// Imagen principal
              SizedBox(
                height: 260,
                child: Image.asset(
                  'assets/imagenes/doctor1.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              /// Cápsula VITALI
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "VITALI",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Título con dos colores
              const Text.rich(
                TextSpan(
                  text: "Tu salud,\n",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: "conectada y segura",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              /// Descripción
              const Text(
                "La forma más sencilla de\n"
                "gestionar tus recetas y\n"
                "tratamientos.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 40),

              /// Botón principal
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    elevation: 8,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRutas.inicio,
                    );
                  },
                  child: const Text(
                    "Comenzar ahora",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // 👈 Texto blanco
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}