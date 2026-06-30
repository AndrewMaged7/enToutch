class GetMyChatsModel {
  String? userId;
  String? fullName;
  String? profileImageUrl;
  bool? isDeaf;
  bool? isMute;
  String? lastMessage;
  String? lastMessageType;
  String? lastMessageAt;
  bool? isLastMessageMine;
  int? unreadCount;

  GetMyChatsModel(
      {this.userId,
      this.fullName,
      this.profileImageUrl,
      this.isDeaf,
      this.isMute,
      this.lastMessage,
      this.lastMessageType,
      this.lastMessageAt,
      this.isLastMessageMine,
      this.unreadCount});

  GetMyChatsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    profileImageUrl = json['profileImageUrl'];
    isDeaf = json['isDeaf'];
    isMute = json['isMute'];
    lastMessage = json['lastMessage'];
    lastMessageType = json['lastMessageType'];
    lastMessageAt = json['lastMessageAt'];
    isLastMessageMine = json['isLastMessageMine'];
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['profileImageUrl'] = profileImageUrl;
    data['isDeaf'] = isDeaf;
    data['isMute'] = isMute;
    data['lastMessage'] = lastMessage;
    data['lastMessageType'] = lastMessageType;
    data['lastMessageAt'] = lastMessageAt;
    data['isLastMessageMine'] = isLastMessageMine;
    data['unreadCount'] = unreadCount;
    return data;
  }
}
