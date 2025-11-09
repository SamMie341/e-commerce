// To parse this JSON data, do
//
//     final favorModel = favorModelFromJson(jsonString);

import 'dart:convert';

List<FavorModel> favorModelFromJson(String str) =>
    List<FavorModel>.from(json.decode(str).map((x) => FavorModel.fromJson(x)));

String favorModelToJson(List<FavorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavorModel {
  final String? userCode;
  final int? productId;
  bool? favorite;
  final num? avgRating;
  final Product? product;

  FavorModel({
    this.userCode,
    this.productId,
    this.favorite,
    this.avgRating,
    this.product,
  });

  factory FavorModel.fromJson(Map<String, dynamic> json) => FavorModel(
        userCode: json["userCode"],
        productId: json["productId"],
        favorite: json["favorite"],
        avgRating: json["avgRating"] ?? 0,
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "userCode": userCode,
        "productId": productId,
        "favorite": favorite,
        "avgRating": avgRating,
        "product": product?.toJson(),
      };
}

class Product {
  final int? id;
  final int? shopId;
  final int? categoryId;
  final int? productunitId;
  final String? actived;
  final int? approved;
  final String? title;
  final String? detail;
  final num? price;
  final String? pimg;
  final int? percent;
  final int? userActionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Shop? shop;
  final Category? category;
  final ProductUnit? productunit;
  final List<dynamic>? reviews;

  Product({
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
    this.shop,
    this.category,
    this.productunit,
    this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shopId"],
        categoryId: json["categoryId"],
        productunitId: json["productunitId"],
        actived: json["actived"],
        approved: json["approved"],
        title: json["title"],
        detail: json["detail"],
        price: num.tryParse(json["price"].toString()) ?? 0,
        pimg: json["pimg"],
        percent: json["percent"],
        userActionId: json["userActionId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        productunit: json["productunit"] == null
            ? null
            : ProductUnit.fromJson(json["productunit"]),
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
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
        "shop": shop?.toJson(),
        "category": category?.toJson(),
        "productunit": productunit?.toJson(),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
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
  final String? userCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Shop({
    this.id,
    this.name,
    this.tel,
    this.userCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        tel: json["tel"] ?? '',
        userCode: json["userCode"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
        "userCode": userCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProductUnit {
  final int? id;
  final String? name;
  final String? code;

  ProductUnit({
    this.id,
    this.name,
    this.code,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        code: json["code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
