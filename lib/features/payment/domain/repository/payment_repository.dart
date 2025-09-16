import 'dart:io';

import 'package:e_commerce/features/payment/data/datasource/payment_datasource.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';

abstract class PaymentRepository {
  Future<PaymentModel> fetchById(int id);
  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource remoteDatasource;

  PaymentRepositoryImpl(this.remoteDatasource);

  @override
  Future<PaymentModel> fetchById(int id) async {
    return await remoteDatasource.fetchById(id);
  }

  @override
  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg) async {
    return await remoteDatasource.payment(
        orderId, productstatusId, comment, payimg);
  }
}
