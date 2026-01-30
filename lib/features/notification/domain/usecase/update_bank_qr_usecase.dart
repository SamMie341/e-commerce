import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class UpdateBankQrUseCase {
  final ShopRepository repository;

  UpdateBankQrUseCase(this.repository);

  Future<Either<Failure, void>> call(AddQRModel data, int id) async {
    return await repository.updateBankQR(data, id);
  }
}
