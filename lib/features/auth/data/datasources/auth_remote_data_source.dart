import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  Future<UserModel> login(
      String username, String password, bool rememberMe) async {
    final response = await DioConfig.dio.post(
      '/api/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final result = response.data;
      if (result['token'] == null || result['user'] == null) {
        throw Exception('Invalid response data');
      }

      final user = UserModel.fromJson(result);
      Utility.setSharedPreference('token', result['token']);
      if (rememberMe) {
        Utility.setSharedPreference('rememberMe', rememberMe);
        Utility.setSharedPreference('password', password);
        Utility.setSharedPreference('username', result['user']['username']);
        // Utility.setSharedPreference('userimg', result['user']['userimg']);
      } else {
        Utility.removeSharedPreference('username');
        Utility.setSharedPreference('rememberMe', rememberMe);
      }

      print('token: ${response.data['token']}');
      print('data: $result');
      return user;
    } else {
      throw Exception(response.data['message'] ?? 'Login Failed');
    }
  }
}
