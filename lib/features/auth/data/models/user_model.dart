import 'package:e_commerce/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.code,
    required super.firstname,
    required super.lastname,
    required super.gender,
    required super.tel,
    required super.userimg,
    required super.role,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json.containsKey('user') ? json['user'] : json;
    return UserModel(
      id: userData["id"] ?? 0,
      username: userData["username"] ?? '-',
      code: userData["code"] ?? '-',
      firstname: userData["firstname"] ?? '-',
      lastname: userData["lastname"] ?? '-',
      gender: userData["gender"] ?? '-',
      tel: userData["tel"] ?? '-',
      userimg: userData["userimg"] ?? '-',
      role: userData["roleId"] ?? 0,
      token: userData["token"] ?? '-',
    );
  }
}
