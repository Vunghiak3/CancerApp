class NewsArticle {
  final String title;
  final String link;
  final String description;
  final String imageUrl;

  NewsArticle({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      link: json['link'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
