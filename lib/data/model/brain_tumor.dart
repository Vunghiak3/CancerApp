class BrainTumor {
  final String type;
  final String description;
  final List<String> commonLocations;
  final List<String> symptoms;
  final List<String> treatmentOptions;

  BrainTumor({
    required this.type,
    required this.description,
    required this.commonLocations,
    required this.symptoms,
    required this.treatmentOptions,
  });

  factory BrainTumor.fromJson(Map<String, dynamic> json) {
    return BrainTumor(
      type: json['type'],
      description: json['description'],
      commonLocations: List<String>.from(json['commonLocations']),
      symptoms: List<String>.from(json['symptoms']),
      treatmentOptions: List<String>.from(json['treatmentOptions']),
    );
  }
}
