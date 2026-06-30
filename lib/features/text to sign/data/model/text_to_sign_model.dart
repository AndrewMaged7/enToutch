class TextToSignModel {
  bool? success;
  String? translationId;
  String? inputText;
  String? outputVideoUrl;

  TextToSignModel(
      {this.success, this.translationId, this.inputText, this.outputVideoUrl});

  TextToSignModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    translationId = json['translationId'];
    inputText = json['inputText'];
    outputVideoUrl = json['outputVideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['translationId'] = translationId;
    data['inputText'] = inputText;
    data['outputVideoUrl'] = outputVideoUrl;
    return data;
  }
}
