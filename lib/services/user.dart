import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testfile/utils/apiEnpoints.dart';
import 'package:http/http.dart' as http;

class UserService{
  Future<dynamic> getUser(String idToken) async{
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.getUser);

    try{
      final response = await http.get(
          url,
          headers: {
            "Authorization": 'Bearer $idToken',
          }
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> saveUserToStorage(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(userData));
  }

  Future<void> changePassword(String currentPassword, String newPassword, String idToken) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.updatePassword);

    try{
      final response = await http.put(
          url,
          headers: {
            "Authorization": 'Bearer $idToken',
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "current_password": currentPassword,
            "new_password": newPassword
          })
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    }catch(e){
      rethrow;
    }
  }
}