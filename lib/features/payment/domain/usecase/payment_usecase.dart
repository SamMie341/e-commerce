import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';
import 'package:e_commerce/features/payment/domain/repository/payment_repository.dart';

class PaymentUseCase {
  final PaymentRepository repository;

  PaymentUseCase(this.repository);

  Future<PaymentModel> call(int id) async {
    return await repository.fetchById(id);
  }

  Future<Either<Failure, void>> payment(PayModel data) async {
    return await repository.payment(data);
  }
}
