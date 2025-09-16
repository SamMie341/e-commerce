import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

class Product {
  final int id;
  final String userCode;
  final String title;
  final String detail;
  final num price;
  final String pimg;
  // final List<String> options;
  final Category category;
  final Profile user;
  final num avgRating;
  final num reviewCount;
  bool favorite;

  Product({
    required this.id,
    required this.userCode,
    required this.title,
    required this.detail,
    required this.price,
    required this.pimg,
    // required this.options,
    required this.category,
    required this.user,
    required this.avgRating,
    required this.reviewCount,
    required this.favorite,
  });
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
}

class ProductBranch {
  final int id;
  final String name;
  final String description;

  ProductBranch({
    required this.id,
    required this.name,
    required this.description,
  });
}
