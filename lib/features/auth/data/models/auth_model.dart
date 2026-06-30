import 'package:hive/hive.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 0)
class AuthModel {
  @HiveField(0)
  String? token;

  @HiveField(1)
  String? refreshToken;

  @HiveField(2)
  String? id;

  @HiveField(3)
  String? fullName;

  @HiveField(4)
  String? email;

  @HiveField(5)
  bool? isDeaf;

  @HiveField(6)
  bool? isMute;

  @HiveField(7)
  String? preferredLanguage;

  AuthModel({
    this.token,
    this.refreshToken,
    this.id,
    this.fullName,
    this.email,
    this.isDeaf,
    this.isMute,
    this.preferredLanguage,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json['token'],
        refreshToken: json['refreshToken'],
        id: json['id'],
        fullName: json['fullName'],
        email: json['email'],
        isDeaf: json['isDeaf'],
        isMute: json['isMute'],
        preferredLanguage: json['preferredLanguage'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'refreshToken': refreshToken,
        'id': id,
        'fullName': fullName,
        'email': email,
        'isDeaf': isDeaf,
        'isMute': isMute,
        'preferredLanguage': preferredLanguage,
      };
}