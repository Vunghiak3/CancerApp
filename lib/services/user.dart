import 'dart:convert';
import 'dart:io';

import 'package:testfile/services/auth.dart';
import 'package:testfile/utils/apiEnpoints.dart';
import 'package:http/http.dart' as http;

class UserService {
  final baseUrl = ApiEndpoints.baseUrl;
  Future<dynamic> getUser(String idToken) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.user.getUser);

    try {
      final response = await http.get(url, headers: {
        "Authorization": 'Bearer $idToken',
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword, String idToken) async {
    final url =
        Uri.parse(baseUrl + ApiEndpoints.user.updatePassword);

    try {
      final response = await http.put(url,
          headers: {
            "Authorization": 'Bearer $idToken',
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "current_password": currentPassword,
            "new_password": newPassword
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

  Future<void> updateUser(Map<String, dynamic>info) async {
    final url = Uri.parse(baseUrl + ApiEndpoints.user.updateUser);

    try {
      final idToken = await AuthService().getIdToken();

      final response = await http.put(
          url,
          headers: {
            "Authorization": 'Bearer $idToken',
            "Content-Type": "application/json"
          },
          body: jsonEncode(info)
      );

      if (response.statusCode == 200) {
        final user = await getUser(idToken);
        user["idToken"] = idToken;
        await AuthService().saveUser(user);

        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfilePicture(File image) async{
    final url = Uri.parse(baseUrl + ApiEndpoints.user.updateProfilePicture);

    try{
      final idToken = await AuthService().getIdToken();

      var request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = 'Bearer $idToken';
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode != 200) {
        final responseData = await response.stream.bytesToString();
        throw Exception("API Error: $responseData");
      }else{
        final user = await getUser(idToken);
        user['idToken'] = idToken;
        await AuthService().saveUser(user);
        final user1 = await AuthService().getUser();
      }
    }catch(e){
      rethrow;
    }
  }
}
