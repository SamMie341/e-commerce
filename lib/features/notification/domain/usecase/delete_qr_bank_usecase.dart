import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class DeleteQrBankUseCase {
  final ShopRepository repository;

  DeleteQrBankUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteQRBank(id);
  }
}
