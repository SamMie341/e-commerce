import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';
import 'package:e_commerce/features/notification/data/model/add_product_model.dart';

class UpdateProductUseCase {
  final ShopRepository repository;

  UpdateProductUseCase(this.repository);

  Future<Either<Failure, void>> call(
      AddProductModel product, int productId) async {
    return await repository.updateProduct(product, productId);
  }
}
