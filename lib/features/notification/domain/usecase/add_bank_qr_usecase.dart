import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class AddBankQrUseCase {
  final ShopRepository repository;

  AddBankQrUseCase(this.repository);

  Future<Either<Failure, void>> call(AddQRModel data) async {
    return await repository.addBankQR(data);
  }
}
