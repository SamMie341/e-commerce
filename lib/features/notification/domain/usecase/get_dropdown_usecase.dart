import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

class GetDropdownUseCase {
  final ShopRepository repository;
  GetDropdownUseCase(this.repository);

  Future<Either<Failure, List<CategoryModel>>> callCategory() async {
    return await repository.fetchCategory();
  }

  Future<Either<Failure, List<UnitModel>>> callUnit() async {
    return await repository.fetchUnit();
  }
}
