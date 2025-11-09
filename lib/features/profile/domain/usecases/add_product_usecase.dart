import 'package:e_commerce/features/payment/data/models/add_product.dart';
import 'package:e_commerce/features/profile/domain/repositories/add_product_repository.dart';

class AddProductUseCase {
  final AddProductRepository repository;

  AddProductUseCase(this.repository);

  Future<void> call(AddProductModel data) async {
    return await repository.addProduct(data);
  }
}
