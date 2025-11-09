import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';

abstract class PaymentRemoteDatasource {
  Future<PaymentModel> fetchById(int id);
  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg);
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<PaymentModel> fetchById(int id) async {
    try {
      final response = await _dio.get('/api/orders/$id');
      final Map<String, dynamic> jsonList = response.data;
      print(jsonList);
      return PaymentModel.fromJson(jsonList);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg) async {
    try {
      final formData = FormData.fromMap({
        "orderId": orderId,
        "productstatusId": productstatusId,
        "comment": comment,
        "payimg": await MultipartFile.fromFile(
          payimg.path,
          filename: payimg.path.split('/').last,
        ),
      });
      final response =
          await _dio.post('/api/orders/orderstatus', data: formData);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Fail to Payment');
      }
    } catch (e) {
      rethrow;
    }
  }
}
