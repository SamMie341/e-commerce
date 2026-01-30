import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/profile/domain/repositories/profile_repository.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

class BuyHistoryUseCase {
  final ProfileRepository repository;

  BuyHistoryUseCase(this.repository);

  Future<Either<Failure, List<OrderDetailModel>>> call() async {
    return await repository.fetchHistory();
  }
}
