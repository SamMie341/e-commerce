import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/profile/data/repositories/profile_repository_impl.dart';

class RequestShopUseCase {
  final ProfileRepositoryImpl repository;

  RequestShopUseCase(this.repository);

  Future<Either<Failure, void>> call(String name, String tel) async {
    return await repository.requestShop(name, tel);
  }
}
