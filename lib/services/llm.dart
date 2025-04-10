import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testfile/services/auth.dart';
import 'package:testfile/utils/apiEnpoints.dart';

class LLMService {
  // final String baseUrl = 'http://127.0.0.1:8000/llm';
  final String baseUrl = ApiEndpoints.baseUrl + '/llm';
  String? _authToken;

  /// Lazily fetch auth token when needed
  Future<Map<String, String>> _getHeaders() async {
    _authToken ??= await AuthService().getIdToken();

    if (_authToken == null) {
      throw Exception('❗ Auth token could not be retrieved.');
    }

    return {
      'Authorization': 'Bearer $_authToken',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, dynamic>> getLatestSession() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/user/latest_session/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch latest session: ${response.statusCode}');
    }
  }

  Future<String> createSession(Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/create_session'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['sessionId'] ?? '';
    } else {
      throw Exception('Failed to create session: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getSessionMessages(String sessionId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/session/$sessionId/messages'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }
  }

  Future<String> generate(Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/generate'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? 'No response';
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getUserSessions() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/user/session'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch sessions: ${response.statusCode}');
    }
  }
}
