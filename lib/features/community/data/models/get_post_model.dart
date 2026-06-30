class GetPostModel {
  String? id;
  String? userId;
  String? userFullName;
  String? userProfileImage;
  String? content;
  String? mediaUrl;
  String? mediaType;
  int? likesCount;
  int? commentsCount;
  bool? isLikedByMe;
  String? createdAt;

  GetPostModel(
      {this.id,
      this.userId,
      this.userFullName,
      this.userProfileImage,
      this.content,
      this.mediaUrl,
      this.mediaType,
      this.likesCount,
      this.commentsCount,
      this.isLikedByMe,
      this.createdAt});

  GetPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userFullName = json['userFullName'];
    userProfileImage = json['userProfileImage'];
    content = json['content'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    isLikedByMe = json['isLikedByMe'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['userFullName'] = userFullName;
    data['userProfileImage'] = userProfileImage;
    data['content'] = content;
    data['mediaUrl'] = mediaUrl;
    data['mediaType'] = mediaType;
    data['likesCount'] = likesCount;
    data['commentsCount'] = commentsCount;
    data['isLikedByMe'] = isLikedByMe;
    data['createdAt'] = createdAt;
    return data;
  }
}
