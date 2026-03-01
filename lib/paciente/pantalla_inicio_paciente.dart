import 'package:flutter/material.dart';
import 'package:meditrack_app/paciente/services/recordatorio_service.dart';

class PantallaInicioPaciente extends StatefulWidget {
  const PantallaInicioPaciente({super.key});

  @override
  State<PantallaInicioPaciente> createState() =>
      _PantallaInicioPacienteState();
}

class _PantallaInicioPacienteState
    extends State<PantallaInicioPaciente> {

  List<dynamic> recordatorios = [];
  bool cargando = true;
  bool yaCargo = false;

  int? userId;
  String nombre = "Paciente";

  Future<void> cargarRecordatorios() async {
    if (userId == null) return;

    try {
      final data =
          await RecordatorioService.obtenerRecordatorios(userId!);

      setState(() {
        recordatorios = data;
        cargando = false;
      });
    } catch (e) {
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments;

    if (!yaCargo && args != null) {
      final Map usuario = args as Map;
      userId = usuario['id'];
      nombre = usuario['nombre'] ?? "Paciente";
      yaCargo = true;
      cargarRecordatorios();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // 🔵 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Hola, $nombre",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none,
                color: Colors.black),
          )
        ],
      ),

      // 🔵 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Recordatorios de Hoy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            if (cargando)
              const Center(child: CircularProgressIndicator())
            else if (recordatorios.isEmpty)
              const Text("No tienes recordatorios")
            else
              Column(
                children: recordatorios.map((rec) {

                  final fechaHora =
                      DateTime.parse(rec['fecha_hora']);

                  final fecha =
                      "${fechaHora.day.toString().padLeft(2, '0')}/"
                      "${fechaHora.month.toString().padLeft(2, '0')}/"
                      "${fechaHora.year}";

                  final hora =
                      "${fechaHora.hour.toString().padLeft(2, '0')}:"
                      "${fechaHora.minute.toString().padLeft(2, '0')}";

                  final descripcion =
                      rec['descripcion'] != null &&
                              rec['descripcion']
                                  .toString()
                                  .isNotEmpty
                          ? "$fecha • $hora\n${rec['descripcion']}"
                          : "$fecha • $hora";

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12),
                    child: _recordatorioCard(
                      rec: rec,
                      descripcion: descripcion,
                    ),
                  );

                }).toList(),
              ),

            const SizedBox(height: 30),

            // 🔵 RECETAS MOCK
            const Text(
              "Mis Recetas Recientes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _recetaCard(
              titulo: "Tratamiento Hipertensión",
              doctor: "Dr. Carlos Méndez",
              fecha: "12 Oct 2023",
            ),

            const SizedBox(height: 12),

            _recetaCard(
              titulo: "Suplementos Anuales",
              doctor: "Dra. Elena Ruiz",
              fecha: "05 Oct 2023",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // 🔵 BOTÓN CREAR
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: () async {

          final result = await Navigator.pushNamed(
            context,
            '/crearRecordatorio',
            arguments: {
              'id': userId,
              'nombre': nombre,
            },
          );

          if (result == true) {
            setState(() {
              cargando = true;
            });
            await cargarRecordatorios();
          }
        },
        child: const Icon(Icons.add),
      ),

      // 🔵 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Citas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Nuevo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: "Recetas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil"),
        ],
      ),
    );
  }

  // =====================================================
  // CARD RECORDATORIO CON SWITCH Y ELIMINAR
  // =====================================================

  Widget _recordatorioCard({
    required Map rec,
    required String descripcion,
  }) {
    final bool activo = rec['activo'] == true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: activo
            ? Colors.white
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const Icon(
                Icons.medication,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  rec['titulo'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: activo
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),
                ),
              ),

              Switch(
                value: activo,
                activeColor:
                    const Color(0xFF2563EB),
                onChanged: (value) async {

                  // Cambiar localmente primero
                  setState(() {
                    rec['activo'] = value;
                  });

                  // Luego backend
                  await RecordatorioService
                      .toggleRecordatorio(
                          rec['id']);
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            descripcion,
            style: TextStyle(
              color: Colors.grey,
              decoration: activo
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment:
                Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {

                await RecordatorioService
                    .eliminarRecordatorio(
                        rec['id']);

                setState(() {
                  recordatorios.removeWhere(
                      (r) =>
                          r['id'] ==
                          rec['id']);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _recetaCard({
    required String titulo,
    required String doctor,
    required String fecha,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.description,
              color: Color(0xFF2563EB)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "$doctor • $fecha",
                  style:
                      const TextStyle(
                          color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.download,
              color: Color(0xFF2563EB)),
        ],
      ),
    );
  }
}