import 'package:e_commerce/features/cart/data/datasources/sale_remote_datasource.dart';

abstract class SaleRepository {
  Future<void> sale(List<Map<String, dynamic>> data);
}

class SaleRepositoryImpl implements SaleRepository {
  final SaleRemoteDatasource remoteDataSource;

  SaleRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sale(List<Map<String, dynamic>> data) async {
    return await remoteDataSource.sale(data);
  }
}
