import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/payment/data/datasource/payment_datasource.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';

abstract class PaymentRepository {
  Future<PaymentModel> fetchById(int id);
  Future<Either<Failure, void>> payment(PayModel data);
  Future<Either<Failure, List<BankModel>>> fetchBank(int id);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource remoteDatasource;

  PaymentRepositoryImpl(this.remoteDatasource);

  @override
  Future<PaymentModel> fetchById(int id) async {
    return await remoteDatasource.fetchById(id);
  }

  @override
  Future<Either<Failure, void>> payment(PayModel data) async {
    return await remoteDatasource.payment(data);
  }

  @override
  Future<Either<Failure, List<BankModel>>> fetchBank(int id) async {
    return await remoteDatasource.fetchBank(id);
  }
}
