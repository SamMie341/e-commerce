import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';

class OrderCancelUseCase {
  final OrderRepository repository;

  OrderCancelUseCase(this.repository);

  Future<List<OrderDetailModel>> call() async {
    return await repository.fetchOrderCancel();
  }
}
