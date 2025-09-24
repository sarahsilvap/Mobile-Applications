import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Destination.dart';

class ApiService {
  static const String baseUrl = "http://10.109.83.6:3000";

  static Future<List<Destination>> getDestinos() async {
    final response = await http.get(Uri.parse("$baseUrl/destinos"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Destination.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao carregar destinos: ${response.statusCode}");
    }
  }
}
