import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/data'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/info'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch info: $e');
    }
  }

  Future<Map<String, dynamic>> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Server health check failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to check server health: $e');
    }
  }
}