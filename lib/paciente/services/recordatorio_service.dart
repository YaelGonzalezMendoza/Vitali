import 'dart:convert';
import 'package:http/http.dart' as http;

class RecordatorioService {

  static const String baseUrl = "http://192.168.150.72:8000/api";

  // 🔹 Obtener recordatorios por usuario
  static Future<List<dynamic>> obtenerRecordatorios(int userId) async {

    final response = await http.get(
      Uri.parse("$baseUrl/recordatorios/$userId"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener recordatorios");
    }
  }

  // 🔥 Eliminar recordatorio
  static Future<void> eliminarRecordatorio(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/recordatorios/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al eliminar recordatorio");
    }

    // Actualizar
  }
  static Future<void> toggleRecordatorio(int id) async {
  final response = await http.patch(
    Uri.parse("$baseUrl/recordatorios/$id/toggle"),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al actualizar estado");
  }
}
}