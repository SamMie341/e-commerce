import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class OrderRemoteDatasource {
  Future<List<OrderDetailModel>> fetchOrder({int page = 1, int limit = 10});

  Future<List<OrderDetailModel>> fetchOrderProcess(
      {int page = 1, int limit = 10});

  Future<List<OrderDetailModel>> fetchOrderCancel(
      {int page = 1, int limit = 10});

  Future<void> deleteOrder(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDatasource {
  final Dio dioConfig = DioConfig.dioWithAuth;

  @override
  Future<List<OrderDetailModel>> fetchOrder(
      {int page = 1, int limit = 10}) async {
    final response = await DioConfig.dioWithAuth
        .get('/api/orderlist?page=$page&limit=$limit');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => OrderDetailModel.fromJson(json)).toList();
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderProcess(
      {int page = 1, int limit = 10}) async {
    final response = await DioConfig.dioWithAuth
        .get('/api/orderprocess?page=$page&limit=$limit');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => OrderDetailModel.fromJson(item)).toList();
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderCancel(
      {int page = 1, int limit = 10}) async {
    final response = await DioConfig.dioWithAuth
        .get('/api/ordercancle?page=$page&limit=$limit');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => OrderDetailModel.fromJson(item)).toList();
  }

  @override
  Future<void> deleteOrder(int id) async {
    final response = await dioConfig.delete('$apiUrl/api/orders/$id');
    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}
