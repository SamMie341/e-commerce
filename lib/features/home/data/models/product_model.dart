import 'package:e_commerce/features/home/domain/entities/products_entity.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.userCode,
    required super.title,
    required super.detail,
    required super.price,
    required super.pimg,
    // required super.options,
    required super.category,
    required super.user,
    required super.avgRating,
    required super.reviewCount,
    required super.favorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      userCode: json["userCode"],
      title: json["title"],
      detail: json["detail"],
      price: num.tryParse(json["price"].toString()) ?? 0,
      pimg: json["pimg"],
      category: CategoryModel.fromJson(json["category"]),
      user: Profile.fromJson(json["user"]),
      avgRating: num.tryParse(json["avgRating"].toString()) ?? 0,
      reviewCount: num.tryParse(json["reviewCount"].toString()) ?? 0,
      favorite: json["favorite"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userCode": userCode,
        "title": title,
        "detail": detail,
        "price": price,
        "pimg": pimg,
        "category": (category as CategoryModel).toJson(),
        "user": (user).toJson(),
        "avgRating": avgRating,
        "favorite": favorite,
      };
}

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.catimg,
    required super.code,
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
