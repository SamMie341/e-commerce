// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(
    json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  final int id;
  final String orderNo;
  final int productId;
  final String userCode;
  final int quantity;
  final String price;
  final String totalprice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  ReviewModel({
    required this.id,
    required this.orderNo,
    required this.productId,
    required this.userCode,
    required this.quantity,
    required this.price,
    required this.totalprice,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        orderNo: json["orderNo"],
        productId: json["productId"],
        userCode: json["userCode"],
        quantity: json["quantity"],
        price: json["price"],
        totalprice: json["totalprice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNo": orderNo,
        "productId": productId,
        "userCode": userCode,
        "quantity": quantity,
        "price": price,
        "totalprice": totalprice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}

class Product {
  final int id;
  final String title;
  final String pimg;
  final User user;

  Product({
    required this.id,
    required this.title,
    required this.pimg,
    required this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        pimg: json["pimg"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pimg": pimg,
        "user": user.toJson(),
      };
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String code;
  final String tel;
  final Chu unit;
  final Chu chu;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.code,
    required this.tel,
    required this.unit,
    required this.chu,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        code: json["code"],
        tel: json["tel"],
        unit: Chu.fromJson(json["unit"]),
        chu: Chu.fromJson(json["chu"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "code": code,
        "tel": tel,
        "unit": unit.toJson(),
        "chu": chu.toJson(),
      };
}

class Chu {
  final String name;

  Chu({
    required this.name,
  });

  factory Chu.fromJson(Map<String, dynamic> json) => Chu(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
