import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaCrearRecordatorio extends StatefulWidget {
  const PantallaCrearRecordatorio({super.key});

  @override
  State<PantallaCrearRecordatorio> createState() =>
      _PantallaCrearRecordatorioState();
}

class _PantallaCrearRecordatorioState
    extends State<PantallaCrearRecordatorio> {

  final TextEditingController tituloController =
      TextEditingController();

  final TextEditingController descripcionController =
      TextEditingController();

  DateTime? fechaSeleccionada;
  TimeOfDay? horaSeleccionada;

  bool cargando = false;

  Future<void> crearRecordatorio(int userId) async {

    if (fechaSeleccionada == null ||
        horaSeleccionada == null ||
        tituloController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    setState(() => cargando = true);

    final fechaHora = DateTime(
      fechaSeleccionada!.year,
      fechaSeleccionada!.month,
      fechaSeleccionada!.day,
      horaSeleccionada!.hour,
      horaSeleccionada!.minute,
    );

    final url =
        Uri.parse("http://192.168.150.72:8000/api/recordatorios");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "titulo": tituloController.text.trim(),
        "descripcion": descripcionController.text.trim(),
        "fecha_hora": fechaHora.toString(),
      }),
    );

    setState(() => cargando = false);

    if (response.statusCode == 201) {
      Navigator.pop(context, true); // devolver true para refrescar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al crear recordatorio")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final Map usuario =
        ModalRoute.of(context)!.settings.arguments as Map;

    final int userId = usuario['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Recordatorio"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: "Título",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: "Descripción",
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final fecha = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );

                if (fecha != null) {
                  setState(() => fechaSeleccionada = fecha);
                }
              },
              child: Text(
                fechaSeleccionada == null
                    ? "Seleccionar Fecha"
                    : fechaSeleccionada.toString().split(' ')[0],
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                final hora = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (hora != null) {
                  setState(() => horaSeleccionada = hora);
                }
              },
              child: Text(
                horaSeleccionada == null
                    ? "Seleccionar Hora"
                    : horaSeleccionada!.format(context),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cargando
                    ? null
                    : () => crearRecordatorio(userId),
                child: cargando
                    ? const CircularProgressIndicator()
                    : const Text("Guardar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}