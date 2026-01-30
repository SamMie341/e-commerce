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
  final String avgRating;
  final Product product;

  FavorModel({
    required this.userCode,
    required this.productId,
    required this.favorite,
    required this.avgRating,
    required this.product,
  });

  factory FavorModel.fromJson(Map<String, dynamic> json) => FavorModel(
        userCode: json["userCode"] ?? '',
        productId: json["productId"] ?? 0,
        favorite: json["favorite"] ?? false,
        avgRating: json["avgRating"] ?? '',
        product: Product.fromJson(json["product"] ?? {}),
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
  final int shopId;
  final int categoryId;
  final int productunitId;
  final String actived;
  final int approved;
  final String title;
  final String detail;
  final String price;
  final String pimg;
  final int percent;
  final int userActionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Shop shop;
  final Category category;
  // final Category productunit;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.productunitId,
    required this.actived,
    required this.approved,
    required this.title,
    required this.detail,
    required this.price,
    required this.pimg,
    required this.percent,
    required this.userActionId,
    required this.createdAt,
    required this.updatedAt,
    required this.shop,
    required this.category,
    // required this.productunit,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        shopId: json["shopId"] ?? 0,
        categoryId: json["categoryId"] ?? 0,
        productunitId: json["productunitId"] ?? 0,
        actived: json["actived"] ?? '',
        approved: json["approved"] ?? 0,
        title: json["title"] ?? '',
        detail: json["detail"] ?? '',
        price: json["price"] ?? '',
        pimg: json["pimg"] ?? '',
        percent: json["percent"] ?? 0,
        userActionId: json["userActionId"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
        shop: Shop.fromJson(json["shop"] ?? ''),
        category: Category.fromJson(json["category"] ?? ''),
        // productunit: Category.fromJson(json["productunit"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "shop": shop.toJson(),
        "category": category.toJson(),
        // "productunit": productunit.toJson(),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Category {
  final int id;
  final String name;
  final String catimg;
  final String code;

  Category({
    required this.id,
    required this.name,
    required this.catimg,
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

class Review {
  final int rating;

  Review({
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
      };
}

class Shop {
  final int id;
  final String name;
  final String tel;
  final String userCode;
  final int approved;
  final DateTime createdAt;
  final DateTime updatedAt;

  Shop({
    required this.id,
    required this.name,
    required this.tel,
    required this.userCode,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        tel: json["tel"],
        userCode: json["userCode"],
        approved: json["approved"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tel": tel,
        "userCode": userCode,
        "approved": approved,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
