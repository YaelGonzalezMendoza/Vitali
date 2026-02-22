import 'package:flutter/material.dart';
import 'package:meditrack_app/paciente/pantalla_inicio_paciente.dart';

import 'autenticacion/pantallas/pantalla_bienvenida.dart';
import 'autenticacion/pantallas/pantalla_inicio.dart';
import 'autenticacion/pantallas/pantalla_seleccion_rol.dart';
import 'autenticacion/pantallas/pantalla_login.dart';
import 'autenticacion/pantallas/pantalla_registro_paciente.dart';
import 'autenticacion/pantallas/pantalla_registro_medico.dart';


void main() {
  runApp(const VitaliApp());
}

class VitaliApp extends StatelessWidget {
  const VitaliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {

        // 🔵 PANTALLA 1 - BIENVENIDA
        '/': (context) => const PantallaBienvenida(),

        // 🔵 PANTALLA 2 - INICIO
        '/inicio': (context) => const PantallaInicio(),

        // 🔵 LOGIN
        '/login': (context) => const PantallaLogin(),

        // 🔵 SELECCIÓN DE ROL
        '/seleccionRol': (context) =>
            const PantallaSeleccionRol(),

        // 🔵 REGISTRO PACIENTE
        '/registroPaciente': (context) =>
            const PantallaRegistroPaciente(),

        // 🔵 REGISTRO MÉDICO
        '/registroMedico': (context) =>
            const PantallaRegistroMedico(),

        // 🔵 HOME PACIENTE
        '/homePaciente': (context) =>
            const PantallaInicioPaciente(),
      },
    );
  }
}
