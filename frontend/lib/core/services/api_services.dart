import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://10.0.2.2:8000';
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }
}
