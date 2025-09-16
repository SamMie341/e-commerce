import 'package:e_commerce/features/notification/data/datasource/order_product_remote.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRepository {
  Future<List<OrderProductModel>> fetchOrderProduct(
      {int page = 1, int limit = 10});

  Future<List<OrderProductModel>> fetchAcceptProduct(
      {int page = 1, int limit = 10});

  Future<void> acceptOrder(int orderId, int productstatusId);
}

class OrderProductRepositoryImpl implements OrderProductRepository {
  final OrderProductRemote remoteDatasource;
  OrderProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<OrderProductModel>> fetchOrderProduct(
      {int page = 1, int limit = 10}) async {
    return await remoteDatasource.fetchOrderProduct(page: page, limit: limit);
  }

  @override
  Future<List<OrderProductModel>> fetchAcceptProduct(
      {int page = 1, int limit = 10}) async {
    return await remoteDatasource.fetchAcceptProduct(page: page, limit: limit);
  }

  @override
  Future<void> acceptOrder(int orderId, int productstatusId) async {
    return await remoteDatasource.acceptOrder(orderId, productstatusId);
  }
}
