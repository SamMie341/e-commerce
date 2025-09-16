import 'dart:io';

import 'package:e_commerce/features/payment/data/models/payment_model.dart';
import 'package:e_commerce/features/payment/domain/repository/payment_repository.dart';

class PaymentUseCase {
  final PaymentRepository repository;

  PaymentUseCase(this.repository);

  Future<PaymentModel> call(int id) async {
    return await repository.fetchById(id);
  }

  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg) async {
    return await repository.payment(orderId, productstatusId, comment, payimg);
  }
}
