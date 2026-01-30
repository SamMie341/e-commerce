// To parse this JSON data, do
//
//     final saleModel = saleModelFromJson(jsonString);

import 'dart:convert';

SaleModel saleModelFromJson(String str) => SaleModel.fromJson(json.decode(str));

String saleModelToJson(SaleModel data) => json.encode(data.toJson());

class SaleModel {
  final List<Product>? products;
  final int? shopTotal;
  final int? shopDivide;

  SaleModel({
    this.products,
    this.shopTotal,
    this.shopDivide,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        shopTotal: json["shopTotal"] ?? 0,
        shopDivide: json["shopDivide"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "shopTotal": shopTotal,
        "shopDivide": shopDivide,
      };
}

class Product {
  final int productId;
  final String title;
  final String pimg;
  final int price;
  final int percent;
  final int quantity;
  final int totalprice;
  final int divide;

  Product({
    required this.productId,
    required this.title,
    required this.pimg,
    required this.price,
    required this.percent,
    required this.quantity,
    required this.totalprice,
    required this.divide,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"] ?? 0,
        title: json["title"] ?? '',
        pimg: json["pimg"] ?? '',
        price: json["price"] ?? 0,
        percent: json["percent"] ?? 0,
        quantity: json["quantity"] ?? 0,
        totalprice: json["totalprice"] ?? 0,
        divide: json["divide"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "pimg": pimg,
        "price": price,
        "percent": percent,
        "quantity": quantity,
        "totalprice": totalprice,
        "divide": divide,
      };

  // @override
  // List<Object?> get props => [productId, title];
}
