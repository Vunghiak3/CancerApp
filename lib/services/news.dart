import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testfile/model/news.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsService {
  static Future<List<NewsArticle>> fetchHealthNews() async {
    String apiUrl = dotenv.env['NEWS_API_URL'] ?? '';
    String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
    final fullUrl = Uri.parse('$apiUrl$apiKey');
    final response = await http.get(fullUrl);
    final decodedBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final data = jsonDecode(decodedBody);
      final List<dynamic> results = data['results'];
      return results.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
