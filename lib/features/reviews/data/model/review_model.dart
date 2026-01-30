// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(
    json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  final int id;
  final String title;
  final String pimg;
  final Shop shop;

  ReviewModel({
    required this.id,
    required this.title,
    required this.pimg,
    required this.shop,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        pimg: json["pimg"] ?? '',
        shop: Shop.fromJson(json["shop"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pimg": pimg,
        "shop": shop.toJson(),
      };
}

class Shop {
  final int id;
  final String name;
  final String tel;
  final String userCode;

  Shop({
    required this.id,
    required this.name,
    required this.tel,
    required this.userCode,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        tel: json["tel"] ?? '',
        userCode: json["userCode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
        "userCode": userCode,
      };
}
