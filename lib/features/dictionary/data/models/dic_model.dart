class YoutubeVideoModel {
    final String title;
  final String videoId;
  final String thumbnail;

  YoutubeVideoModel({
    required this.title,
    required this.videoId,
    required this.thumbnail,
  });

  factory YoutubeVideoModel.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoModel(
      title: json['snippet']['title'],
      videoId: json['id']['videoId'],
      thumbnail:
          json['snippet']['thumbnails']['high']['url'],
    );
  }
}
