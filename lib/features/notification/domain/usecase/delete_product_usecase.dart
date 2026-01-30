import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class DeleteProductUseCase {
  final ShopRepository repository;

  DeleteProductUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteProduct(id);
  }
}
