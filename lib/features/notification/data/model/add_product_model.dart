// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromMap(jsonString);

import 'dart:io';

import 'dart:convert';

AddProductModel addProductModelFromMap(String str) =>
    AddProductModel.fromMap(json.decode(str));

String addProductModelToMap(AddProductModel data) => json.encode(data.toMap());

class AddProductModel {
  final int? categoryId;
  final int? productunitId;
  final String? title;
  final String? detail;
  final num? price;
  final File? pimg;

  AddProductModel({
    this.categoryId,
    this.productunitId,
    this.title,
    this.detail,
    this.price,
    this.pimg,
  });

  factory AddProductModel.fromMap(Map<String, dynamic> json) => AddProductModel(
        categoryId: json["categoryId"],
        productunitId: json["productunitId"],
        title: json["title"],
        detail: json["detail"],
        price: num.tryParse(json["price"].toString()),
        pimg: json["pimg"],
      );

  Map<String, dynamic> toMap() => {
        "categoryId": categoryId,
        "productunitId": productunitId,
        "title": title,
        "detail": detail,
        "price": price,
        "pimg": pimg,
      };
}
