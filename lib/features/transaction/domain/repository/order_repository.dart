import 'package:e_commerce/features/transaction/data/datasource/order_remote_datasource.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class OrderRepository {
  Future<List<OrderDetailModel>> fetchOrder();

  Future<List<OrderDetailModel>> fetchOrderProcess();

  Future<List<OrderDetailModel>> fetchOrderCancel();

  Future<OrderDetailModel> fetchOrderById(int id);

  Future<void> deleteOrder(int id);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource remoteDatasource;

  OrderRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<OrderDetailModel>> fetchOrder() async {
    return await remoteDatasource.fetchOrder();
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderProcess() async {
    return await remoteDatasource.fetchOrderProcess();
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderCancel() async {
    return await remoteDatasource.fetchOrderCancel();
  }

  @override
  Future<OrderDetailModel> fetchOrderById(int id) async {
    return await remoteDatasource.fetchOrderById(id);
  }

  @override
  Future<void> deleteOrder(int id) {
    return remoteDatasource.deleteOrder(id);
  }
}
