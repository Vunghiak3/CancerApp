import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = 'pub_70410c2c926195f2e9a2c1b621e5d84aee57f';
  static const String _baseUrl = 'https://newsdata.io/api/1/latest';

  static Future<List<Map<String, dynamic>>> fetchNews() async {
    final url =
        Uri.parse('$_baseUrl?country=vi&category=health&apikey=$_apiKey');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));

        if (jsonData.containsKey('results') && jsonData['results'] is List) {
          final List<dynamic> articles = jsonData['results'];

          return articles
              .map((item) => {
                    "title": item['title'] ?? 'No Title',
                    "link": item['link'] ?? '',
                    "image_url": item['image_url'] ?? '',
                    "description": item['description'] ?? 'No Description',
                    "pubDate": item['pubDate'] ?? '',
                    "source_name": item['source_name'] ?? 'Unknown Source',
                  })
              .toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception(
            'Failed to load news, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
