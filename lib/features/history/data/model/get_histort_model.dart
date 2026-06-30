class GetHistoryModel {
  String? id;
  String? type;
  String? inputText;
  String? outputText;
  String? outputVideoPath;
  String? status;
  String? createdAt;

  GetHistoryModel(
      {this.id,
      this.type,
      this.inputText,
      this.outputText,
      this.outputVideoPath,
      this.status,
      this.createdAt});

  GetHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    inputText = json['inputText'];
    outputText = json['outputText'];
    outputVideoPath = json['outputVideoPath'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['inputText'] = inputText;
    data['outputText'] = outputText;
    data['outputVideoPath'] = outputVideoPath;
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }
}
