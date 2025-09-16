import 'package:e_commerce/features/transaction/data/datasource/order_remote_datasource.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class OrderRepository {
  Future<List<OrderDetailModel>> fetchOrder({int page = 1, int limit = 10});

  Future<List<OrderDetailModel>> fetchOrderProcess(
      {int page = 1, int limit = 10});

  Future<List<OrderDetailModel>> fetchOrderCancel(
      {int page = 1, int limit = 10});

  Future<void> deleteOrder(int id);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource remoteDatasource;

  OrderRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<OrderDetailModel>> fetchOrder(
      {int page = 1, int limit = 10}) async {
    return await remoteDatasource.fetchOrder(page: page, limit: limit);
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderProcess(
      {int page = 1, int limit = 10}) async {
    return await remoteDatasource.fetchOrderProcess(page: page, limit: limit);
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderCancel(
      {int page = 1, int limit = 10}) async {
    return await remoteDatasource.fetchOrderCancel(page: page, limit: limit);
  }

  @override
  Future<void> deleteOrder(int id) {
    return remoteDatasource.deleteOrder(id);
  }
}
