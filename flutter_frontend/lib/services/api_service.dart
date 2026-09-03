import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getInfo() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/info'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load info: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> createLinkToken() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/create_link_token'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create link token: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>>setAccessToken(String publicToken) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/set_access_token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'public_token': publicToken}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to set access token: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }
}