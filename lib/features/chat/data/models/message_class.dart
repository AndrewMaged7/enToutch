class MessageModel {
  String? id;
  String? senderId;
  String? senderName;
  String? receiverId;
  String? content;
  String? videoPath;
  String? messageType;
  String? sentAt;
  bool? isRead;

  MessageModel(
      {this.id,
      this.senderId,
      this.senderName,
      this.receiverId,
      this.content,
      this.videoPath,
      this.messageType,
      this.sentAt,
      this.isRead});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    content = json['content'];
    videoPath = json['videoPath'];
    messageType = json['messageType'];
    sentAt = json['sentAt'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['senderId'] = senderId;
    data['senderName'] = senderName;
    data['receiverId'] = receiverId;
    data['content'] = content;
    data['videoPath'] = videoPath;
    data['messageType'] = messageType;
    data['sentAt'] = sentAt;
    data['isRead'] = isRead;
    return data;
  }
}









// class MessageClass {
//   final String senderId;
//   final String senderEmail;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   MessageClass({
//     required this.senderId,
//     required this.senderEmail,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//   });
//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'senderEmail': senderEmail,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': timestamp,
//     };
//   }
// }
