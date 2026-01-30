import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<List<dynamic>> getNewOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Background Task: No token found');
        return [];
      }

      _dio.options.headers = {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await _dio.get('$apiUrl/api/orders/seller?status=pending');
      if (response.statusCode == 200) {
        final List<dynamic> orders = response.data['data'] ?? [];
        return orders;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
