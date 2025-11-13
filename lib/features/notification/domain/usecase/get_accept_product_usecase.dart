import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';

class GetAcceptProductUseCase {
  final OrderProductRepository repository;

  GetAcceptProductUseCase(this.repository);

  Future<List<OrderProductModel>> call() async {
    return await repository.fetchAcceptProduct();
  }
}
