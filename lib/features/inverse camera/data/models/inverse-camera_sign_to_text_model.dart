class InverseCameraSignToTextModel {
  bool? success;
  String? prediction;
  String? confidence;
  String? videoPath;

  InverseCameraSignToTextModel({this.success, this.prediction, this.confidence, this.videoPath});

  InverseCameraSignToTextModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    prediction = json['prediction'];
    confidence = json['confidence'];
    videoPath = json['videoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['prediction'] = prediction;
    data['confidence'] = confidence;
    data['videoPath'] = videoPath;
    return data;
  }
}
