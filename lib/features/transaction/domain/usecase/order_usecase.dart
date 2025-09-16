import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';

class OrderUseCase {
  final OrderRepository repository;

  OrderUseCase(this.repository);

  Future<List<OrderDetailModel>> call({int page = 1, int limit = 10}) async {
    return await repository.fetchOrder(page: page, limit: limit);
  }
}
