// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

List<ShopModel> shopModelFromJson(String str) =>
    List<ShopModel>.from(json.decode(str).map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  final int? id;
  final int? shopId;
  final int? categoryId;
  final int? productunitId;
  final String? actived;
  final int? approved;
  final String? title;
  final String? detail;
  final String? price;
  final String? pimg;
  final int? percent;
  final int? userActionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final Category? productunit;
  final Shop? shop;
  final UserAction? userAction;

  ShopModel({
    this.id,
    this.shopId,
    this.categoryId,
    this.productunitId,
    this.actived,
    this.approved,
    this.title,
    this.detail,
    this.price,
    this.pimg,
    this.percent,
    this.userActionId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.productunit,
    this.shop,
    this.userAction,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        shopId: json["shopId"],
        categoryId: json["categoryId"],
        productunitId: json["productunitId"],
        actived: json["actived"],
        approved: json["approved"],
        title: json["title"],
        detail: json["detail"],
        price: json["price"],
        pimg: json["pimg"],
        percent: json["percent"],
        userActionId: json["userActionId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        productunit: json["productunit"] == null
            ? null
            : Category.fromJson(json["productunit"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        userAction: json["userAction"] == null
            ? null
            : UserAction.fromJson(json["userAction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shopId": shopId,
        "categoryId": categoryId,
        "productunitId": productunitId,
        "actived": actived,
        "approved": approved,
        "title": title,
        "detail": detail,
        "price": price,
        "pimg": pimg,
        "percent": percent,
        "userActionId": userActionId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
        "productunit": productunit?.toJson(),
        "shop": shop?.toJson(),
        "userAction": userAction?.toJson(),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? catimg;
  final String? code;

  Category({
    this.id,
    this.name,
    this.catimg,
    this.code,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        catimg: json["catimg"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "catimg": catimg,
        "code": code,
      };
}

class Shop {
  final int? id;
  final String? name;
  final String? tel;

  Shop({
    this.id,
    this.name,
    this.tel,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
      };
}

class UserAction {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? gender;

  UserAction({
    this.id,
    this.firstname,
    this.lastname,
    this.gender,
  });

  factory UserAction.fromJson(Map<String, dynamic> json) => UserAction(
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
