import 'package:e_commerce/features/notification/data/datasource/order_product_remote.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRepository {
  Future<List<OrderProductModel>> fetchOrderProduct();

  Future<List<OrderProductModel>> fetchAcceptProduct();

  Future<void> acceptOrder(int orderId, int productstatusId);

  Future<OrderProductModel> fetchById(int id);

  // Future<void> cancelOrder(int orderId,)
}

class OrderProductRepositoryImpl implements OrderProductRepository {
  final OrderProductRemote remoteDatasource;
  OrderProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<OrderProductModel>> fetchOrderProduct() async {
    return await remoteDatasource.fetchOrderProduct();
  }

  @override
  Future<List<OrderProductModel>> fetchAcceptProduct() async {
    return await remoteDatasource.fetchAcceptProduct();
  }

  @override
  Future<void> acceptOrder(int orderId, int productstatusId) async {
    return await remoteDatasource.acceptOrder(orderId, productstatusId);
  }

  @override
  Future<OrderProductModel> fetchById(int id) async {
    return await remoteDatasource.fetchById(id);
  }
}
