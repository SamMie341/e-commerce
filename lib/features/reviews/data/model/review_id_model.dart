// To parse this JSON data, do
//
//     final reviewIdModel = reviewIdModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReviewIdModel reviewIdModelFromJson(String str) =>
    ReviewIdModel.fromJson(json.decode(str));

String reviewIdModelToJson(ReviewIdModel data) => json.encode(data.toJson());

class ReviewIdModel {
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
  final List<OrderDetail> orderDetails;

  ReviewIdModel({
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
    required this.orderDetails,
  });

  factory ReviewIdModel.fromJson(Map<String, dynamic> json) => ReviewIdModel(
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
        orderDetails: List<OrderDetail>.from(
            json["orderDetails"].map((x) => OrderDetail.fromJson(x))),
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
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  final int id;
  final int orderId;
  final String userCode;
  final int productstatusId;
  final String comment;
  final String payimg;
  final DateTime createdAt;
  final Productstatus productstatus;
  final User user;
  final dynamic paydate;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.userCode,
    required this.productstatusId,
    required this.comment,
    required this.payimg,
    required this.createdAt,
    required this.productstatus,
    required this.user,
    required this.paydate,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["orderId"],
        userCode: json["userCode"],
        productstatusId: json["productstatusId"],
        comment: json["comment"] ?? '',
        payimg: json["payimg"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        productstatus: Productstatus.fromJson(json["productstatus"]),
        user: User.fromJson(json["user"]),
        paydate: json["paydate"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "userCode": userCode,
        "productstatusId": productstatusId,
        "comment": comment,
        "payimg": payimg,
        "createdAt": createdAt.toIso8601String(),
        "productstatus": productstatus.toJson(),
        "user": user.toJson(),
        "paydate": paydate,
      };
}

class Productstatus {
  final int id;
  final String name;
  final dynamic code;

  Productstatus({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Productstatus.fromJson(Map<String, dynamic> json) => Productstatus(
        id: json["id"],
        name: json["name"] ?? '',
        code: json["code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String gender;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
      };
}

class Product {
  final int id;
  final String title;
  final String pimg;

  Product({
    required this.id,
    required this.title,
    required this.pimg,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        pimg: json["pimg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pimg": pimg,
      };
}
