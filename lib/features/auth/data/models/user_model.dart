import 'package:e_commerce/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String username,
    required String code,
    required String firstname,
    required String lastname,
    required String gender,
    required String tel,
    required String userimg,
    required String token,
  }) : super(
          id: id,
          username: username,
          code: code,
          firstname: firstname,
          lastname: lastname,
          gender: gender,
          tel: tel,
          userimg: userimg,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["u_id"] ?? 0,
        username: json["username"] ?? '-',
        code: json["code"] ?? '-',
        firstname: json["firstname"] ?? '-',
        lastname: json["lastname"] ?? '-',
        gender: json["gender"] ?? '-',
        tel: json["tel"] ?? '-',
        userimg: json["userimg"] ?? '-',
        token: json["token"] ?? '-',
      );
}
