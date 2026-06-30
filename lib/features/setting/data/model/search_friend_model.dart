class SearchFriendsModel {
  String? id;
  String? fullName;
  String? profileImageUrl;
  bool? isDeaf;
  bool? isMute;
  String? friendshipStatus;

  SearchFriendsModel(
      {this.id,
      this.fullName,
      this.profileImageUrl,
      this.isDeaf,
      this.isMute,
      this.friendshipStatus});

  SearchFriendsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    profileImageUrl = json['profileImageUrl'];
    isDeaf = json['isDeaf'];
    isMute = json['isMute'];
    friendshipStatus = json['friendshipStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['fullName'] =fullName;
    data['profileImageUrl'] = profileImageUrl;
    data['isDeaf'] = isDeaf;
    data['isMute'] = isMute;
    data['friendshipStatus'] = friendshipStatus;
    return data;
  }
}
