import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';

class OrderUseCase {
  final OrderRepository repository;

  OrderUseCase(this.repository);

  Future<List<OrderDetailModel>> call() async {
    return await repository.fetchOrder();
  }

  Future<OrderDetailModel> callById(int id) async {
    return await repository.fetchOrderById(id);
  }
}
