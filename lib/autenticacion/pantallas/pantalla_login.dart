import 'package:flutter/material.dart';

class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

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
        centerTitle: true,
        title: const Text("Iniciar Sesión"),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [

              const SizedBox(height: 20),

              const Icon(
                Icons.local_hospital,
                size: 80,
                color: Color(0xFF2563EB),
              ),

              const SizedBox(height: 30),

              /// CORREO
              TextField(
                decoration: InputDecoration(
                  labelText: "Correo electrónico",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// CONTRASEÑA
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// BOTÓN ENTRAR
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
                    // 🔥 NAVEGAR AL HOME DEL PACIENTE
                    Navigator.pushReplacementNamed(
                      context,
                      '/homePaciente',
                    );
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// IR A REGISTRO
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/seleccionRol');
                },
                child: const Text(
                  "¿No tienes cuenta? Regístrate",
                  style: TextStyle(
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
