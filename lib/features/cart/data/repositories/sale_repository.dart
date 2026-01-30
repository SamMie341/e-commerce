import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/data/datasources/sale_remote_datasource.dart';

abstract class SaleRepository {
  Future<Either<Failure, void>> sale(List<Map<String, dynamic>> data);
}

class SaleRepositoryImpl implements SaleRepository {
  final SaleRemoteDatasource remoteDataSource;

  SaleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> sale(List<Map<String, dynamic>> data) async {
    return await remoteDataSource.sale(data);
  }
}
