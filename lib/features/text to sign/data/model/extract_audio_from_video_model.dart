class ExtractAudioFromVideoModel {
  bool? success;
  String? translationId;
  String? transcribedText;

  ExtractAudioFromVideoModel(
      {this.success, this.translationId, this.transcribedText});

  ExtractAudioFromVideoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    translationId = json['translationId'];
    transcribedText = json['transcribedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['translationId'] = translationId;
    data['transcribedText'] = transcribedText;
    return data;
  }
}
