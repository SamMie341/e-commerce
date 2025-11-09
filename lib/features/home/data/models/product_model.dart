import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

class ProductModel {
  final int id;
  final int categoryId;
  final int productunitId;
  final String userCode;
  final String title;
  final String detail;
  final num price;
  final String pimg;
  // final List<String> options;
  final CategoryModel category;
  final Profile user;
  final int? avgRating;
  final num reviewCount;
  final Shop shop;
  final Map<String, int>? ratingCounts;
  bool favorite;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.productunitId,
    required this.userCode,
    required this.title,
    required this.detail,
    required this.price,
    required this.pimg,
    // required this.options,
    required this.category,
    required this.user,
    this.avgRating,
    required this.reviewCount,
    required this.shop,
    this.ratingCounts,
    required this.favorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      categoryId: json["categoryId"] ?? 0,
      productunitId: json["productunitId"] ?? 0,
      userCode: json["userCode"] ?? '',
      title: json["title"] ?? '',
      detail: json["detail"] ?? '',
      price: num.tryParse(json["price"].toString()) ?? 0,
      pimg: json["pimg"] ?? '',
      category: CategoryModel.fromJson(json["category"] ?? {}),
      user: Profile.fromJson(json["user"] ?? {}),
      avgRating: int.tryParse(json["avgRating"].toString()) ?? 0,
      reviewCount: num.tryParse(json["reviewCount"].toString()) ?? 0,
      shop: Shop.fromJson(json["shop"]),
      ratingCounts: json["ratingCounts"] != null
          ? Map.from(json["ratingCounts"])
              .map((k, v) => MapEntry<String, int>(k, v))
          : null,
      favorite: json["favorite"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "productunitId": productunitId,
        "userCode": userCode,
        "title": title,
        "detail": detail,
        "price": price,
        "pimg": pimg,
        "category": (category).toJson(),
        "user": (user).toJson(),
        "avgRating": avgRating,
        "ratingCounts": ratingCounts != null
            ? Map.from(ratingCounts!).map((k, v) => MapEntry<String, int>(k, v))
            : null,
        "shop": shop.toJson(),
        "favorite": favorite,
      };
}

class CategoryModel {
  final int id;
  final String name;
  final String catimg;
  final String code;

  CategoryModel({
    required this.id,
    required this.name,
    required this.catimg,
    required this.code,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      catimg: json['catimg'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'catimg': catimg,
      'code': code,
    };
  }
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
