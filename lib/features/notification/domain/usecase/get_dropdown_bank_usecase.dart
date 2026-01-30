import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class GetDropdownBankUseCase {
  final ShopRepository repository;

  GetDropdownBankUseCase(this.repository);

  Future<Either<Failure, List<Banklogo>>> call() async {
    return await repository.dropDownBank();
  }
}
