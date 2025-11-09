import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';

abstract class SaleRemoteDatasource {
  Future<void> sale(List<Map<String, dynamic>> data);
}

class SaleRemoteDatasourceImpl implements SaleRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<void> sale(List<Map<String, dynamic>> data) async {
    final response = await _dio.post(
      '$apiUrl/api/orders',
      data: data,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to Create Order");
    }
  }
}
