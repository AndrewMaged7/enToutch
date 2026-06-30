class AddCommentModel {
  String? message;
  String? commentId;

  AddCommentModel({this.message, this.commentId});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    commentId = json['commentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['commentId'] = commentId;
    return data;
  }
}
