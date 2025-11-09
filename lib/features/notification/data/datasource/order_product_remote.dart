import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRemote {
  Future<List<OrderProductModel>> fetchOrderProduct(
      {int page = 1, int limit = 10});

  Future<List<OrderProductModel>> fetchAcceptProduct(
      {int page = 1, int limit = 10});

  Future<void> acceptOrder(int orderId, int productstatusId);

  // Future<void> cancelOrder(int orderId, int productstatusId);
}

class OrderProductRemoteImpl implements OrderProductRemote {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<OrderProductModel>> fetchOrderProduct(
      {int page = 1, int limit = 10}) async {
    final response = await _dio.get('/api/orderseller?page=$page&limit=$limit');
    return (response.data as List)
        .map((json) => OrderProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<OrderProductModel>> fetchAcceptProduct(
      {int page = 1, int limit = 10}) async {
    final response =
        await _dio.get('/api/sellerprocess?page=$page&limit=$limit');
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
