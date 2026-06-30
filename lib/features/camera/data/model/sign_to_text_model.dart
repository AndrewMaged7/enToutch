// class SignToTextModel {
//   bool? success;
//   String? prediction;
//   String? confidence;
//   String? videoPath;

//   SignToTextModel(
//       {this.success, this.prediction, this.confidence, this.videoPath});

//   SignToTextModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     prediction = json['prediction'];
//     confidence = json['confidence'];
//     videoPath = json['videoPath'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['prediction'] = this.prediction;
//     data['confidence'] = this.confidence;
//     data['videoPath'] = this.videoPath;
//     return data;
//   }
// }












class SignToTextModel {
  bool? success;
  String? prediction;
  String? confidence;
  String? videoPath;

  SignToTextModel({this.success, this.prediction, this.confidence, this.videoPath});

  SignToTextModel.fromJson(Map<String, dynamic> json) {
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
