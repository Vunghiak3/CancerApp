import 'dart:convert';
import 'dart:io';

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

  Future<void> updateUser(final info, String idToken)async {
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.updateUser);

    try{
      final response = await http.put(
        url,
        headers: {
          "Authorization": 'Bearer $idToken',
          "Content-Type": "application/json"
        },
        body: jsonDecode(info)
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

  Future<dynamic> history(String idToken) async{
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.history);

    try{
      final response = await http.get(
          url,
          headers: {
            "Authorization": 'Bearer $idToken',
            "Content-Type": "application/json"
          },
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

  Future<dynamic> deleteHistoryById(String idToken, String diagnosisId) async{
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.user.history}/$diagnosisId');

    try{
      final response = await http.delete(
          url,
          headers: {
            "Authorization": 'Bearer $idToken',
            "Content-Type": "application/json"
          },
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

  Future<Map<String, dynamic>> diagnoses(String idToken, File image) async{
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.diagnoses);

    try{
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $idToken';
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if(response.statusCode == 200){
        return jsonDecode(responseData);
      }else{
        throw Exception("API Error: $responseData");
      }
    }catch(e){
      rethrow;
    }
  }
}