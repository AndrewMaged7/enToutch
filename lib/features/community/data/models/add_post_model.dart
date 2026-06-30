class AddPostModel {
  String? message;
  String? postId;

  AddPostModel({this.message, this.postId});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['postId'] = postId;
    return data;
  }
}
