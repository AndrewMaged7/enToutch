class AddLikeModel {
  String? message;
  bool? liked;

  AddLikeModel({this.message, this.liked});

  AddLikeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['liked'] = liked;
    return data;
  }
}
