class RadioModel {
  final int id;
  final String title;
  final String url;
  bool isPlaying;
  bool isMuted;

  RadioModel({
    this.id = 0,
    required this.title,
    required this.url,
    this.isPlaying = false,
    this.isMuted = false,
  });
  factory RadioModel.fromJsonRadio(Map<String, dynamic> json) {
    return RadioModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? "إذاعة غير معروفة",
      url: json['url'] ?? "",
    );
  }
  factory RadioModel.fromJsonReciter(Map<String, dynamic> json) {
    String serverUrl = "";
    if (json['moshaf'] != null && (json['moshaf'] as List).isNotEmpty) {
      serverUrl = json['moshaf'][0]['server'];
    }

    return RadioModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? "قارئ غير معروف",
      url: serverUrl.isNotEmpty ? "$serverUrl/001.mp3" : "",
    );
  }
}