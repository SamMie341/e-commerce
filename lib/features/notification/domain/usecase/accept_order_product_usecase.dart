import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';

class AcceptOrderProductUseCase {
  final OrderProductRepository repository;

  AcceptOrderProductUseCase(this.repository);

  Future<void> call(int orderId, int productstatusId) async {
    return await repository.acceptOrder(orderId, productstatusId);
  }
}
