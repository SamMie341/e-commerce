// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String username;
  final String code;
  final String firstname;
  final String lastname;
  final String gender;
  final String tel;
  final String userimg;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.code,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.tel,
    required this.userimg,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        code: json["code"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        tel: json["tel"],
        userimg: json["userimg"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "code": code,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "tel": tel,
        "userimg": userimg,
        "token": token,
      };
}
