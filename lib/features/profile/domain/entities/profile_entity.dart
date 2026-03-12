import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  final int id;
  final String username;
  final String code;
  final String firstname;
  final String lastname;
  final String gender;
  final String tel;
  final String userimg;
  final UnitModel unit;
  final Shop shop;

  Profile({
    required this.id,
    required this.username,
    required this.code,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.tel,
    required this.userimg,
    required this.unit,
    required this.shop,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] ?? 0,
        username: json["username"] ?? '',
        code: json["code"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        gender: json["gender"] ?? '',
        tel: json["tel"] ?? '',
        userimg: json["userimg"] ?? '',
        unit: UnitModel.fromJson(json["unit"] ?? {}),
        shop: Shop.fromJson(json["shop"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "code": code,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "tel": tel,
        "userimg": userimg,
        "unit": unit,
        "shop": shop,
      };
}

class UnitModel {
  final int id;
  final int no;
  final String name;

  UnitModel({
    required this.id,
    required this.no,
    required this.name,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"] ?? 0,
        no: json["no"] ?? 0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
      };
}

class Shop {
  final int? id;
  final String? name;

  Shop(this.id, this.name);

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        json["id"],
        json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
