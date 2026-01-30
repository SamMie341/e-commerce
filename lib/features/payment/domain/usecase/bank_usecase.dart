import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/payment/domain/repository/payment_repository.dart';

class BankUseCase {
  final PaymentRepository repository;

  BankUseCase(this.repository);

  Future<Either<Failure, List<BankModel>>> call(int id) async {
    return await repository.fetchBank(id);
  }
}
