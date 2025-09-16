// // To parse this JSON data, do
// //
// //     final productByShop = productByShopFromJson(jsonString);

// import 'dart:convert';

// import 'package:get/get.dart';

// List<ProductByShop> productByShopFromJson(String str) =>
//     List<ProductByShop>.from(
//         json.decode(str).map((x) => ProductByShop.fromJson(x)));

// String productByShopToJson(List<ProductByShop> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProductByShop {
//   final int id;
//   final String userCode;
//   final String actived;
//   final String title;
//   final String detail;
//   final num price;
//   final String pimg;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Category category;
//   final User user;
//   final bool favorite;

//   ProductByShop({
//     required this.id,
//     required this.userCode,
//     required this.actived,
//     required this.title,
//     required this.detail,
//     required this.price,
//     required this.pimg,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.category,
//     required this.user,
//     required this.favorite,
//   });

//   factory ProductByShop.fromJson(Map<String, dynamic> json) => ProductByShop(
//         id: json["id"] ?? 0,
//         userCode: json["userCode"] ?? '',
//         actived: json["actived"] ?? '',
//         title: json["title"] ?? '',
//         detail: json["detail"] ?? '',
//         price: num.tryParse(json["price"].toString()) ?? 0,
//         pimg: json["pimg"] ?? '',
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         category: Category.fromJson(json["category"]),
//         user: User.fromJson(json["user"] ?? []),
//         favorite: json["favorite"] ?? false,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userCode": userCode,
//         "actived": actived,
//         "title": title,
//         "detail": detail,
//         "price": price,
//         "pimg": pimg,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "category": category.toJson(),
//         "user": user,
//         "favorite": favorite,
//       };
// }

// class Category {
//   final int id;
//   final String name;
//   final String? catimg;
//   final String code;

//   Category({
//     required this.id,
//     required this.name,
//     this.catimg,
//     required this.code,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         catimg: json["catimg"],
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "catimg": catimg,
//         "code": code,
//       };
// }

// class User {
//   final int id;
//   final String firstname;
//   final String lastname;
//   final String code;
//   final String tel;

//   User({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.code,
//     required this.tel,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         code: json["code"],
//         tel: json["tel"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "firstname": firstname,
//         "lastname": lastname,
//         "code": code,
//         "tel": tel,
//       };
// }
