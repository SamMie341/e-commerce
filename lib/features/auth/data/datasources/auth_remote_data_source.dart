import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<UserModel> login(String username, String password) async {
    print('[remoteDataSource] calling API');
    final response = await _dio.post(
      '/api/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    final result = response.data;
    final user = UserModel.fromJson(result);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Utility.setSharedPreference('data', response.data);
      Utility.setSharedPreference('token', response.data['token']);
      print('token: ${response.data['token']}');
      print('data: $result');
      return user;
    } else {
      throw Exception(response.data['message'] ?? 'Login Failed');
    }
  }
}
