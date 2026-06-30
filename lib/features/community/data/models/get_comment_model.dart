class GetCommentModel {
  String? id;
  String? userId;
  String? userFullName;
  String? userProfileImage;
  String? content;
  String? createdAt;

  GetCommentModel(
      {this.id,
      this.userId,
      this.userFullName,
      this.userProfileImage,
      this.content,
      this.createdAt});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userFullName = json['userFullName'];
    userProfileImage = json['userProfileImage'];
    content = json['content'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['userFullName'] = userFullName;
    data['userProfileImage'] = userProfileImage;
    data['content'] = content;
    data['createdAt'] = createdAt;
    return data;
  }
}
