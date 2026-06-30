class AcceptAndRejectAndDeleteModel {
  String? message;

  AcceptAndRejectAndDeleteModel({this.message});

  AcceptAndRejectAndDeleteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = message;
    return data;
  }
}
