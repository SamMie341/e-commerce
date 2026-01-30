import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class GetBankQrUseCase {
  final ShopRepository repository;

  GetBankQrUseCase(this.repository);

  Future<Either<Failure, List<BankModel>>> call() async {
    return await repository.fetchBankQR();
  }
}
