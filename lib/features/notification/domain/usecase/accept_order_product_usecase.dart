import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';

class AcceptOrderProductUseCase {
  final OrderProductRepository repository;

  AcceptOrderProductUseCase(this.repository);

  Future<Either<Failure, bool>> call(int orderId, int productstatusId,
      {String? comment}) async {
    return await repository.acceptOrder(orderId, productstatusId,
        comment: comment);
  }
}
