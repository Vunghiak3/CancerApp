import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testfile/services/user.dart';
import 'package:testfile/utils/apiEnpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, dynamic>> register(String name, String email,
      String password, String confirmPassword) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.auth.register);
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
            "confirm_password": confirmPassword
          }));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.auth.login);

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        String idToken = responseBody["idToken"];

        final user = await UserService().getUser(idToken);
        user["idToken"] = idToken;
        await saveUser(user);

        return responseBody;
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Hàm để lưu User vào Secure Storage
  Future<void> saveUser(final response) async {
    String userJson = jsonEncode(response);
    await _storage.write(key: 'user', value: userJson);
  }

  // Hàm để lấy user từ Secure Storage
  Future<String?> getUser() async {
    return await _storage.read(key: 'user');
  }

  // Hàm để xóa User và idToken khỏi Secure Storage
  Future<void> deleteUser() async {
    await _storage.delete(key: 'user');
  }

  Future<String> getIdToken() async {
    String? userJson = await AuthService().getUser();
    Map<String, dynamic> user = jsonDecode(userJson!);
    String idToken = user['idToken'];
    return idToken;
  }

  Future<void> loginGoogle(String idToken) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.auth.loginGoogle);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_token": idToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        idToken = responseBody['access_token'];

        final user = await UserService().getUser(idToken);
        user["idToken"] = idToken;
        await saveUser(user);

        return responseBody;
      } else {
        throw response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(String idToken) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.auth.signout);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        await AuthService().deleteUser();
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount(String idToken) async {
    final url =
        Uri.parse(baseUrl + ApiEndpoints.user.deleteAccount);

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        await AuthService().deleteUser();
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
