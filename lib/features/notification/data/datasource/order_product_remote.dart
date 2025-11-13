import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRemote {
  Future<List<OrderProductModel>> fetchOrderProduct();

  Future<List<OrderProductModel>> fetchAcceptProduct();

  Future<void> acceptOrder(int orderId, int productstatusId);

  Future<OrderProductModel> fetchById(int id);

  // Future<void> cancelOrder(int orderId, int productstatusId);
}

class OrderProductRemoteImpl implements OrderProductRemote {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<OrderProductModel>> fetchOrderProduct() async {
    final response = await _dio.get('/api/orderseller');
    return (response.data as List)
        .map((json) => OrderProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<OrderProductModel>> fetchAcceptProduct() async {
    final response = await _dio.get('/api/sellerprocess');
    return (response.data as List)
        .map((item) => OrderProductModel.fromJson(item))
        .toList();
  }

  @override
  Future<void> acceptOrder(int orderId, int productstatusId) async {
    final response = await _dio.post(
      '$apiUrl/api/orders/orderstatus',
      data: {
        'orderId': orderId,
        'productstatusId': productstatusId,
      },
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Fail to accept');
    }
  }

  @override
  Future<OrderProductModel> fetchById(int id) async {
    try {
      final response = await _dio.get('/api/orders/$id');
      final Map<String, dynamic> json = response.data;
      print('fetch by id order seller $json');
      return OrderProductModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<void> cancelOrder(int orderId, int productstatusId) async {
  //   final response = await DioConfig.dioWithAuth.post(
  //     '$apiUrl/api/orders/orderstatus',
  //     data: {
  //       "orderId": orderId,
  //       "productstatusId": productstatusId,
  //     },
  //   );
  //   if (response.statusCode != 201 || response.statusCode != 200) {
  //     throw Exception('Fail to Cancel Order');
  //   }
  // }
}
