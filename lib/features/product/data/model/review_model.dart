import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

class Review {
  final int id;
  final int productId;
  final String userCode;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Profile user;

  Review({
    required this.id,
    required this.productId,
    required this.userCode,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] ?? 0,
        productId: json["productId"],
        userCode: json["userCode"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: Profile.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "userCode": userCode,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "user": user,
      };
}
