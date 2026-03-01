import 'package:flutter/material.dart';

class PantallaInicioMedico extends StatelessWidget {
  const PantallaInicioMedico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio Médico"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Pantalla Principal del Médico",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}