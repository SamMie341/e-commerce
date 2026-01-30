import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';
import 'package:e_commerce/features/notification/data/model/add_product_model.dart';

class AddProductUseCase {
  final ShopRepository repository;

  AddProductUseCase(this.repository);

  Future<Either<Failure, void>> call(AddProductModel data) async {
    return await repository.addProduct(data);
  }
}
