class HistoryDiagnose{
  String id;
  String title;
  String content;
  String image;
  double confidenceScore;

  HistoryDiagnose({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.confidenceScore,
  });

  // Phương thức từ JSON -> Object
  factory HistoryDiagnose.fromJson(Map<String, dynamic> json) {
    return HistoryDiagnose(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
    );
  }

  // Phương thức từ Object -> JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'confidenceScore': confidenceScore,
    };
  }
}
