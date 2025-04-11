import 'dart:convert';
import 'dart:io';

import 'package:testfile/utils/apiEnpoints.dart';
import 'package:http/http.dart' as http;

class CnnService {
  Future<Map<String, dynamic>> diagnoses(String idToken, File image) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.diagnoses);

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $idToken';
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseData);
      } else {
        throw Exception("API Error: $responseData");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> history(String idToken) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.user.history);

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteHistoryById(String idToken, String diagnosisId) async {
    final url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.user.history}/$diagnosisId');

    try {
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
    } catch (e) {
      rethrow;
    }
  }
}
