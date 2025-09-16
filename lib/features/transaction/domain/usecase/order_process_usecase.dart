import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';

class OrderProcessUseCase {
  final OrderRepository repository;

  OrderProcessUseCase(this.repository);

  Future<List<OrderDetailModel>> call({int page = 1, int limit = 10}) async {
    return await repository.fetchOrderProcess(page: page, limit: limit);
  }
}
