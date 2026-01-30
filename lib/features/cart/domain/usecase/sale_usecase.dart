import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/data/repositories/sale_repository.dart';

class SaleUseCase {
  final SaleRepository repository;

  SaleUseCase(this.repository);

  Future<Either<Failure, void>> call(List<Map<String, dynamic>> data) async {
    return await repository.sale(data);
  }
}
