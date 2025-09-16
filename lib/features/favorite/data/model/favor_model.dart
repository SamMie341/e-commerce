// To parse this JSON data, do
//
//     final favorModel = favorModelFromJson(jsonString);

import 'dart:convert';

List<FavorModel> favorModelFromJson(String str) =>
    List<FavorModel>.from(json.decode(str).map((x) => FavorModel.fromJson(x)));

String favorModelToJson(List<FavorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavorModel {
  final String userCode;
  final int productId;
  bool favorite;
  final num avgRating;
  final Product product;

  FavorModel({
    required this.userCode,
    required this.productId,
    required this.favorite,
    required this.avgRating,
    required this.product,
  });

  factory FavorModel.fromJson(Map<String, dynamic> json) => FavorModel(
        userCode: json["userCode"],
        productId: json["productId"],
        favorite: json["favorite"],
        avgRating: num.tryParse(json["avgRating"].toString()) ?? 0,
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "userCode": userCode,
        "productId": productId,
        "favorite": favorite,
        "avgRating": avgRating,
        "product": product.toJson(),
      };
}

class Product {
  final int id;
  final int categoryId;
  final int productunitId;
  final String userCode;
  final String actived;
  final String title;
  final String detail;
  final num price;
  final String pimg;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final Category productunit;
  final List<dynamic> reviews;

  Product({
    required this.id,
    required this.categoryId,
    required this.productunitId,
    required this.userCode,
    required this.actived,
    required this.title,
    required this.detail,
    required this.price,
    required this.pimg,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.productunit,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["categoryId"],
        productunitId: json["productunitId"],
        userCode: json["userCode"],
        actived: json["actived"],
        title: json["title"] ?? '',
        detail: json["detail"],
        price: num.tryParse(json["price"].toString()) ?? 0,
        pimg: json["pimg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Category.fromJson(json["category"]),
        productunit: Category.fromJson(json["productunit"]),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "productunitId": productunitId,
        "userCode": userCode,
        "actived": actived,
        "title": title,
        "detail": detail,
        "price": price,
        "pimg": pimg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "productunit": productunit.toJson(),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
      };
}

class Category {
  final int id;
  final String name;
  final String? catimg;
  final String code;

  Category({
    required this.id,
    required this.name,
    this.catimg,
    required this.code,
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
