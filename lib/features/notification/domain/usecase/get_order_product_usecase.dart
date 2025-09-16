import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';

class GetOrderProductUseCase {
  final OrderProductRepository repository;

  GetOrderProductUseCase(this.repository);

  Future<List<OrderProductModel>> call({int page = 1, int limit = 10}) async {
    return await repository.fetchOrderProduct(page: page, limit: limit);
  }
}
