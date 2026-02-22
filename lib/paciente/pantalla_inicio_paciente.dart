import 'package:flutter/material.dart';

class PantallaInicioPaciente extends StatelessWidget {
  const PantallaInicioPaciente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // 🔵 APPBAR CON NOTIFICACIONES
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Hola, Juan",
          style: TextStyle(
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔵 RECORDATORIOS
            const Text(
              "Recordatorios de Hoy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _recordatorioCard(
              titulo: "Paracetamol - 500mg",
              descripcion: "8:00 AM • Con el desayuno",
              estado: "Próximo",
              colorEstado: Colors.green,
            ),

            const SizedBox(height: 12),

            _recordatorioCard(
              titulo: "Vitamina D",
              descripcion: "12:00 PM • Una cápsula",
              estado: "Pendiente",
              colorEstado: Colors.orange,
            ),

            const SizedBox(height: 30),

            // 🔵 RECETAS RECIENTES
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

            // 🔵 PRÓXIMA CITA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Próxima Cita",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lunes 23 de Octubre - 10:30 AM",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔵 BOTÓN FLOTANTE
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      // 🔵 BOTTOM NAVIGATION
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

  // ========================
  // COMPONENTES
  // ========================

  Widget _recordatorioCard({
    required String titulo,
    required String descripcion,
    required String estado,
    required Color colorEstado,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.medication,
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
                  descripcion,
                  style:
                      const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorEstado.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              estado,
              style: TextStyle(
                color: colorEstado,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
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
                      const TextStyle(color: Colors.grey),
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
