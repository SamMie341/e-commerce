// To parse this JSON data, do
//
//     final reviewByProductModel = reviewByProductModelFromJson(jsonString);

import 'dart:convert';

List<ReviewByProductModel> reviewByProductModelFromJson(String str) =>
    List<ReviewByProductModel>.from(
        json.decode(str).map((x) => ReviewByProductModel.fromJson(x)));

String reviewByProductModelToJson(List<ReviewByProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewByProductModel {
  final int? id;
  final int? productId;
  final String? userCode;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  ReviewByProductModel({
    this.id,
    this.productId,
    this.userCode,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ReviewByProductModel.fromJson(Map<String, dynamic> json) =>
      ReviewByProductModel(
        id: json["id"],
        productId: json["productId"],
        userCode: json["userCode"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "userCode": userCode,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? code;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.code,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "code": code,
      };
}
