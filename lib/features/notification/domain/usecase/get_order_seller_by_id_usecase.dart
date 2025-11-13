import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';

class GetOrderSellerByIdUseCase {
  final OrderProductRepository repository;

  GetOrderSellerByIdUseCase(this.repository);

  Future<OrderProductModel> call(int id) async {
    return await repository.fetchById(id);
  }
}
