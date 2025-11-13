// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  final int id;
  final String? orderNo;
  final int? shopId;
  final String? userCode;
  final String? grandtotalprice;
  final int? currentStatusId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Status? currentStatus;
  final Shop? shop;
  final List<OrderDetail>? orderDetails;
  final List<OrderStatus>? orderStatuses;

  PaymentModel({
    required this.id,
    this.orderNo,
    this.shopId,
    this.userCode,
    this.grandtotalprice,
    this.currentStatusId,
    this.createdAt,
    this.updatedAt,
    this.currentStatus,
    this.shop,
    this.orderDetails,
    this.orderStatuses,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        orderNo: json["orderNo"],
        shopId: json["shopId"],
        userCode: json["userCode"],
        grandtotalprice: json["grandtotalprice"],
        currentStatusId: json["currentStatusId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        currentStatus: json["currentStatus"] == null
            ? null
            : Status.fromJson(json["currentStatus"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        orderDetails: json["orderDetails"] == null
            ? []
            : List<OrderDetail>.from(
                json["orderDetails"]!.map((x) => OrderDetail.fromJson(x))),
        orderStatuses: json["orderStatuses"] == null
            ? []
            : List<OrderStatus>.from(
                json["orderStatuses"]!.map((x) => OrderStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNo": orderNo,
        "shopId": shopId,
        "userCode": userCode,
        "grandtotalprice": grandtotalprice,
        "currentStatusId": currentStatusId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "currentStatus": currentStatus?.toJson(),
        "shop": shop?.toJson(),
        "orderDetails": orderDetails == null
            ? []
            : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
        "orderStatuses": orderStatuses == null
            ? []
            : List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
      };
}

class Status {
  final int? id;
  final String? name;

  Status({
    this.id,
    this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class OrderDetail {
  final Product? product;
  final int? quantity;
  final String? price;
  final String? totalprice;

  OrderDetail({
    this.product,
    this.quantity,
    this.price,
    this.totalprice,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        price: json["price"],
        totalprice: json["totalprice"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "quantity": quantity,
        "price": price,
        "totalprice": totalprice,
      };
}

class Product {
  final int? id;
  final String? title;
  final String? pimg;

  Product({
    this.id,
    this.title,
    this.pimg,
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

class OrderStatus {
  final Status? productstatus;
  final dynamic comment;
  final dynamic payimg;
  final User? user;
  final DateTime? createdAt;

  OrderStatus({
    this.productstatus,
    this.comment,
    this.payimg,
    this.user,
    this.createdAt,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        productstatus: json["productstatus"] == null
            ? null
            : Status.fromJson(json["productstatus"]),
        comment: json["comment"],
        payimg: json["payimg"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "productstatus": productstatus?.toJson(),
        "comment": comment,
        "payimg": payimg,
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class User {
  final int? id;
  final String? code;
  final String? firstname;
  final String? lastname;
  final String? gender;
  final String? tel;

  User({
    this.id,
    this.code,
    this.firstname,
    this.lastname,
    this.gender,
    this.tel,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        code: json["code"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "tel": tel,
      };
}

class Shop {
  final int? id;
  final String? name;
  final String? tel;
  final String? userCode;

  Shop({
    this.id,
    this.name,
    this.tel,
    this.userCode,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        tel: json["tel"],
        userCode: json["userCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
        "userCode": userCode,
      };
}
