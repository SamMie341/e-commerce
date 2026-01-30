import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRemote {
  Future<List<OrderProductModel>> fetchOrderProduct();

  Future<List<OrderProductModel>> fetchAcceptProduct();

  Future<bool> acceptOrder(int orderId, int productstatusId, {String? comment});

  Future<OrderProductModel> fetchById(int id);
}

class OrderProductRemoteImpl implements OrderProductRemote {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<OrderProductModel>> fetchOrderProduct() async {
    final response = await _dio.get('/api/orderseller');
    print(response.data);
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
  Future<bool> acceptOrder(int orderId, int productstatusId,
      {String? comment}) async {
    try {
      final response = await _dio.post(
        '$apiUrl/api/orders/orderstatus',
        data: {
          'orderId': orderId,
          'productstatusId': productstatusId,
          'comment': comment,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      throw Error();
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
}
